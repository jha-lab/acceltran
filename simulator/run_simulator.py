# Simulate inference of a Transformer model in the FlexiBERT 2.0 framework on AccelTran

import os
import sys
import json
import yaml
import shutil
import argparse
from tqdm import tqdm

sys.path.append('./src/')

from pe import *
from ops import *
from utils import *
from buffer import *
from tiled_ops import *
from accelerator import *
from dict2ops import main as dict2ops


SEQ_LENGTH = 512
DEBUG = True
OVERWRITE_LOGS = True


def check_config(config: dict, design_space: dict):
	"""Check if the accelerator configuration comes under the allowed design space"""
	assert config['tile']['tile_b'] in design_space['tile']['tile_b'], f'Configuration "tile_b" ({config["tile"]["tile_b"]}) not in {design_space["tile"]["tile_b"]}'
	assert config['tile']['tile_x'] == config['tile']['tile_y'], f'Configuration "tile_x" ({config["tile"]["tile_x"]}) and "tile_y" ({config["tile"]["tile_y"]}) should match'
	assert config['tile']['tile_x'] in design_space['tile']['tile_x'], f'Configuration "tile_x" ({config["tile"]["tile_b"]}) not in {design_space["tile"]["tile_x"]}'
	assert config['tile']['tile_y'] in design_space['tile']['tile_y'], f'Configuration "tile_y" ({config["tile"]["tile_y"]}) not in {design_space["tile"]["tile_y"]}'

	assert config['non_linearity'] in design_space['non_linearity'], f'Configuration "non_linearity" ({config["non_linearity"]}) not in {design_space["non_linearity"]}'
	assert config['pe'] in design_space['pe'], f'Configuration "pe" ({config["pe"]}) should be in {design_space["pe"]}'
	assert config['lanes_per_pe'] in design_space['lanes_per_pe'], f'Configuration "lanes_per_pe" ({config["lanes_per_pe"]}) not in {design_space["lanes_per_pe"]}'
	assert config['mac_per_lane'] in design_space['mac_per_lane'], f'Cofiguration "mac_per_lane" ({config["mac_per_lane"]}) not in {design_space["mac_per_lane"]}'

	assert config['tile']['tile_b'] <= config['batch_size'], f'Configuraton "tile_b" ({config["tile"]["tile_b"]}) should be less than or equal to "batch_size" ({config["batch_size"]})'
	assert config['batch_size'] in design_space['batch_size'], f'Configuration "batch_size" not in {design_space["batch_size"]}'

	assert config['activation_buffer_size'] in design_space['activation_buffer_size'], f'Configuration "activation_buffer_size" not in {design_space["activation_buffer_size"]}'
	assert config['weight_buffer_size'] in design_space['weight_buffer_size'], f'Configuration "weight_buffer_size" not in {design_space["weight_buffer_size"]}'
	assert config['mask_buffer_size'] in design_space['mask_buffer_size'], f'Configuration "mask_buffer_size" not in {design_space["mask_buffer_size"]}'

	assert config['main_memory']['type'] in design_space['main_memory_config'].keys(), f'Unsupported main memory type ({config["main_memory"]["type"]})'
	memory_config = {'banks': config['main_memory']['banks'], 'ranks': config['main_memory']['ranks'], 'channels': config['main_memory']['channels']}
	assert memory_config in design_space['main_memory_config'][config['main_memory']['type']], f'Unsupported main memory configuration ({memory_config})'


def get_last_compute_op(memory_op, compute_ops):
	"""Get the last compute_op corresponding to the current storing memory_op"""
	assert isinstance(memory_op, (MemoryStoreOp, MemoryStoreTiledOp))

	for compute_op in compute_ops:
		if compute_op.op_name == memory_op.op_name[:-2]:
			return compute_op


def log_energy(total_pe_energy, activation_buffer_energy, weight_buffer_energy, mask_buffer_energy, cycle, logs_path):
	"""Log energy values for every cycle"""
	if os.path.exists(logs_path):
		logs = json.load(open(logs_path, 'r'))

		last_cycle = logs['cycle'][-1]
		cycle_difference = cycle - last_cycle
		assert cycle_difference > 0

		for c in range(last_cycle + 1, cycle + 1):
			logs['cycle'].append(c)
			logs['total_pe_energy'].append((total_pe_energy[0] / cycle_difference, total_pe_energy[1] / cycle_difference))
			logs['activation_buffer_energy'].append((activation_buffer_energy[0] / cycle_difference, activation_buffer_energy[1] / cycle_difference))
			logs['weight_buffer_energy'].append((weight_buffer_energy[0] / cycle_difference, weight_buffer_energy[1] / cycle_difference))
			logs['mask_buffer_energy'].append((mask_buffer_energy[0] / cycle_difference, mask_buffer_energy[1] / cycle_difference))

		json.dump(logs, open(logs_path, 'w'))
	else:
		assert cycle == 1

		logs = {'total_pe_energy': [total_pe_energy], 'activation_buffer_energy': [activation_buffer_energy], 'weight_buffer_energy': [weight_buffer_energy], 'mask_buffer_energy': [mask_buffer_energy], 'cycle': [cycle]}
		json.dump(logs, open(logs_path, 'w+'))


def main(model_dict: dict, config: dict, constants: dict, design_space: dict, logs_path: str, utilization_dir: str, debug=False):
	"""Run a model_dict on an Accelerator object"""

	# Check if configuration is valid
	check_config(config, design_space)

	# Instantiate accelerator baesd on given configuration
	accelerator = Accelerator(config, constants)
	print(f'{color.GREEN}Accelerator area: {accelerator.area / 1e6 : 0.03f} mm\u00b2{color.ENDC}')
	
	# Get tiled ops from model dictionary
	ops, tiled_ops = dict2ops(model_dict, config, tile_ops=True, debug=debug)

	memory_ops, compute_ops = [op for op in tiled_ops if not op.compute_op], [op for op in tiled_ops if op.compute_op]

	memory_op_idx, compute_op_idx = 0, 0
	memory_op, compute_op = memory_ops[0], compute_ops[0]

	# Run operations on the accelerator in a cycle-accurate manner
	while memory_op is not None or compute_op is not None:

		memory_stall, compute_stall = False, False
		
		if memory_op:
			assert isinstance(memory_op, (MemoryLoadOp, MemoryLoadTiledOp, MemoryStoreOp, MemoryStoreTiledOp))

		if debug: print(f'{color.HEADER}Running memory operation with name: {memory_op.op_name if memory_op else None}\nand compute operation with name: {compute_op.op_name if compute_op else None}{color.ENDC}')

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
					if not buffer.ready: print(f'{color.WARNING}Memory stall: {buffer.buffer_type} buffer not ready{color.ENDC}')
					if not buffer.can_store(data): print(f'{color.WARNING}Memory stall: {buffer.buffer_type} buffer can\'t store data of size {data.data_size}{color.ENDC}')
					if not last_compute_done: print(f'{color.WARNING}Memory stall: waiting for last compute operation "{get_last_compute_op(memory_op, compute_op).op_name}"{color.ENDC}')
			
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
					if debug: print(f'{color.WARNING}Compute stall: {data_name} required in buffer{color.ENDC}')
					break

			if not compute_stall:
				assigned_op = accelerator.assign_op(compute_op)
				if assigned_op:
					accelerator.set_required(compute_op)
				else:
					compute_stall = True 
					if debug: print(f'{color.WARNING}Compute stall: no MAC lanes are ready{color.ENDC}')

		# Process cycle for every module
		total_pe_energy, activation_buffer_energy, weight_buffer_energy, mask_buffer_energy = accelerator.process_cycle(memory_ops, compute_ops)
		accelerator.cycle += 1

		# Log energy values for each cycle 
		log_energy(total_pe_energy, activation_buffer_energy, weight_buffer_energy, mask_buffer_energy, accelerator.cycle, logs_path)

		# Plot utilization of the accelerator
		accelerator.plot_utilization(utilization_dir, debug)

		if debug: print(f'{color.GREEN}Cycle: {accelerator.cycle}{color.GREEN}')

		if memory_stall and compute_stall and accelerator.all_macs_free():
			min_cycles = min([process_cycles for process_cycles in [accelerator.activation_buffer.process_cycles, accelerator.weight_buffer.process_cycles, accelerator.mask_buffer.process_cycles] if process_cycles not in [0, None]])

			if min_cycles > 1:
				activation_buffer_energy = accelerator.activation_buffer.process_cycle(min_cycles)
				weight_buffer_energy = accelerator.weight_buffer.process_cycle(min_cycles)
				mask_buffer_energy = accelerator.mask_buffer.process_cycle(min_cycles)

				accelerator.cycle += min_cycles

				log_energy((0, 0), activation_buffer_energy, weight_buffer_energy, mask_buffer_energy, accelerator.cycle, logs_path)
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
		default='./model_dicts/bert_tiny.json',
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
	parser.add_argument('--design_space_path',
		metavar='',
		type=str,
		default='./design_space/design_space.yaml',
		help='path to the design space file')
	parser.add_argument('--logs_path',
		metavar='',
		type=str,
		default='./logs/logs.json',
		help='path to the logs file')
	parser.add_argument('--utilization_dir',
		metavar='',
		type=str,
		default='./logs/utilization/',
		help='directory to store utlization plots')
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
		raise FileNotFoundError(f'Couldn\'t find YAML file for given path: {args.config_path}')

	if os.path.exists(args.constants_path):
		constants = yaml.safe_load(open(args.constants_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find YAML file for given path: {args.constants_path}')

	if os.path.exists(args.design_space_path):
		design_space = yaml.safe_load(open(args.design_space_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find YAML file for given path: {args.design_space_path}')

	if os.path.exists(args.logs_path) and OVERWRITE_LOGS: os.remove(args.logs_path)
	if os.path.exists(args.utilization_dir) and OVERWRITE_LOGS: shutil.rmtree(args.utilization_dir)
	os.makedirs('./logs', exist_ok=True)

	main(model_dict, config, constants, design_space, args.logs_path, args.utilization_dir, args.debug)

