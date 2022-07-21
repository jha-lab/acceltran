# Simulate inference of a Transformer model in the FlexiBERT 2.0 framework on AccelTran

import os
import sys
import json
import yaml
import argparse
from tqdm import tqdm

sys.path.append('./src/')

from pe import *
from ops import *
from buffer import *
from tiled_ops import *
from accelerator import *
from dict2ops import main as dict2ops


SEQ_LENGTH = 512
DEBUG = True


def main(model_dict: dict, config: dict, constants: dict, debug=False):
	"""Run a model_dict on an Accelerator object"""

	# Instantiate accelerator baesd on given configuration
	accelerator = Accelerator(config, constants)
	
	# Get tiled ops from model dictionary
	ops, tiled_ops = dict2ops(model_dict, config, tile_ops=True, debug=debug)

	memory_ops, compute_ops = [op for op in tiled_ops if not op.compute_op], [op for op in tiled_ops if op.compute_op]

	cycle, memory_op_idx, compute_op_idx = 0, 0, 0
	memory_op, compute_op = memory_ops[0], compute_ops[0]

	# Run operations on the accelerator in a cycle-accurate manner
	while memory_op is not None or compute_op is not None:

		memory_stall, compute_stall, required_in_buffer_stall = False, False, False
		
		if memory_op:
			assert isinstance(memory_op, (MemoryLoadOp, MemoryLoadTiledOp, MemoryStoreOp, MemoryStoreTiledOp))

		if debug: print(f'Running memory operation with name: {memory_op.op_name if memory_op else None}\nand compute operation with name: {compute_op.op_name if compute_op else None}')

		# Run memory operation
		if memory_op:
			# Get corresponding data object
			data = memory_op.convert_to_data()

			last_compute_done, store_op = True, False
			if isinstance(memory_op, (MemoryStoreOp, MemoryStoreTiledOp)): 
				last_compute_done = get_last_compute_op(memory_op, compute_ops).done
				store_op = True

			buffer = getattr(accelerator, f'{data.data_type}_buffer')

			if buffer.ready:
				# Previous memory_op for this buffer is done
				for memory_op_idx_prev in range(memory_op_idx, -1, -1):
					if memory_ops[memory_op_idx_prev].data_type == memory_op.data_type:
						memory_ops[memory_op_idx_prev].done = True
						break

				if buffer.can_store(data) and last_compute_done:
					memory_stall = False
			else:
				memory_stall = True
				if debug:
					if not buffer.ready: print(f'Memory stall: {buffer.buffer_type} buffer not ready')
					if not buffer.can_store(data): print(f'Memory stall: {buffer.buffer_type} buffer can\'t store data of size {data.data_size}')
					if not last_compute_done: print(f'Memory stall: waiting for last compute operation "{get_last_compute_op(memory_op, compute_op).op_name}"')
			
			if not memory_stall:
				if store_op:
					removed_old_data = buffer.store(data)
					removed_old_data_mask = accelerator.mask_buffer.store(data)
				else:
					removed_old_data = buffer.load(data)
					removed_old_data_mask = accelerator.mask_buffer.load(data)

		# Run compute operation
		if compute_op:
			# Check if required data is in memory
			for data_name in compute_op.required_in_buffer:
				if not accelerator.activation_buffer.data_in_buffer(data_name) and not accelerator.weight_buffer.data_in_buffer(data_name):
					compute_stall = True
					required_in_buffer_stall = True
					if debug: print(f'Compute stall: {data_name} required in buffer')
					break

			if not compute_stall:
				assigned_op = accelerator.assign_op(compute_op)
				if assigned_op:
					accelerator.set_required(compute_op)
				else:
					compute_stall = True 
					if debug: print(f'Compute stall: no MAC lanes are ready')

		# Process cycle for every module
		accelerator.process_cycle(memory_ops, compute_ops)
		cycle += 1

		if debug: print(f'Cycle: {cycle}')

		if memory_stall and required_in_buffer_stall:
			min_cycles = min([process_cycles for process_cycles in [accelerator.activation_buffer.process_cycles, accelerator.weight_buffer.process_cycles, accelerator.mask_buffer.process_cycles] if process_cycles not in [0, None]])

			if min_cycles > 1:
				accelerator.activation_buffer.process_cycle(min_cycles)
				accelerator.weight_buffer.process_cycle(min_cycles)
				accelerator.mask_buffer.process_cycle(min_cycles)

				cycle += min_cycles
				continue

		if memory_stall:
			# memory_op remains the same
			pass
		elif memory_op_idx < len(memory_ops) - 1:
			memory_op_idx += 1
			memory_op = memory_ops[memory_op_idx]
		else:
			memory_op = None

		if compute_stall:
			# compute_op remains the same
			pass
		elif compute_op_idx < len(compute_ops) - 1:
			compute_op_idx += 1
			compute_op = compute_ops[compute_op_idx]
		else:
			compute_op = None


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description='Input parameters for conversion',
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--model_dict_path',
		metavar='',
		type=str,
		default='model_dict.json',
		help='path where the model dictionary file is stored')
	parser.add_argument('--config_path',
		metavar='',
		type=str,
		default='./config/config.yaml',
		help='path to the accelerator configuration file')
	parser.add_argument('--constants_path',
		metavar='',
		type=str,
		default='./constants/constants.yaml',
		help='path to the accelerator constants file')
	parser.add_argument('--debug',
		dest='debug',
		help='print debugging statements',
		action='store_true')
	parser.set_defaults(debug=DEBUG)

	args = parser.parse_args()

	if os.path.exists(args.model_dict_path):
		model_dict = json.load(open(args.model_dict_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.model_dict_path}')

	if os.path.exists(args.config_path):
		config = yaml.safe_load(open(args.config_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.config_path}')

	if os.path.exists(args.constants_path):
		constants = yaml.safe_load(open(args.constants_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.constants_path}')

	main(model_dict, config, constants, args.debug)

