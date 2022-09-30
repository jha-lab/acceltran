# Simulate inference of a Transformer model in the FlexiBERT 2.0 framework on AccelTran

import os
import gc
import sys
import json
import yaml
import time
import shutil
import argparse
import numpy as np
from tqdm import tqdm
from matplotlib import pyplot as plt

from pe import *
from ops import *
from utils import *
from buffer import *
from tiled_ops import *
from accelerator import *
from dict2ops import main as dict2ops


DO_LOGGING = True
gc.disable()


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
	assert config['softmax_per_pe'] in design_space['softmax_per_pe'], f'Cofiguration "softmax_per_pe" ({config["softmax_per_pe"]}) not in {design_space["softmax_per_pe"]}'

	assert config['tile']['tile_b'] <= config['batch_size'], f'Configuraton "tile_b" ({config["tile"]["tile_b"]}) should be less than or equal to "batch_size" ({config["batch_size"]})'
	assert config['batch_size'] in design_space['batch_size'], f'Configuration "batch_size" not in {design_space["batch_size"]}'

	assert config['activation_buffer_size'] in design_space['activation_buffer_size'], f'Configuration "activation_buffer_size" not in {design_space["activation_buffer_size"]}'
	assert config['weight_buffer_size'] in design_space['weight_buffer_size'], f'Configuration "weight_buffer_size" not in {design_space["weight_buffer_size"]}'
	assert config['mask_buffer_size'] in design_space['mask_buffer_size'], f'Configuration "mask_buffer_size" not in {design_space["mask_buffer_size"]}'

	assert config['main_memory']['type'] in design_space['main_memory_config'].keys(), f'Unsupported main memory type ({config["main_memory"]["type"]})'
	memory_config = {'banks': config['main_memory']['banks'], 'ranks': config['main_memory']['ranks'], 'channels': config['main_memory']['channels']}
	assert memory_config in design_space['main_memory_config'][config['main_memory']['type']], f'Unsupported main memory configuration ({memory_config})'

	if config['scheduler']['memory_ops']['tiled'] is True: raise NotImplementedError('Tiled memory operations are not implemented yet.')
	if config['scheduler']['memory_ops']['batch_size'] != 1: raise NotImplementedError('Batch size > 1 for memory operations is not implemented yet.')


def get_op_list(ops, op_idx, batch_size):
	assert type(op_idx) == list

	if op_idx[0] is None:
		return [None]
	elif type(ops[op_idx[0]]) == list:
		assert len(op_idx[1]) != 0
		ops_list = []
		for head_idx, head_ops in enumerate(ops[op_idx[0]]):
			if op_idx[1][head_idx] is None: ops_list.append(None)
			elif batch_size == 1:
				ops_list.append(head_ops[op_idx[1][head_idx]])
			else:
				ops_list.append([head_ops[i] for i in range(op_idx[1][head_idx], 
					min(len(head_ops), op_idx[1][head_idx] + batch_size)) if type(head_ops[i]) == type(head_ops[op_idx[1][head_idx]])])
		return ops_list
	else:
		if batch_size == 1:
			if op_idx[0] == None: return []
			return [ops[op_idx[0]]]
		else:
			ops_list = []
			# Add up to batch_size number of operations
			for i in range(op_idx[0], op_idx[0] + batch_size + 1):
				if i < len(ops) and type(ops[i]) != list and type(ops[i]) == type(ops[op_idx[0]]):
					ops_list.append(ops[i])
				else:
					break
			return [ops_list]


def get_last_compute_op(head_op, head_idx, memory_op_idx, memory_ops, compute_ops):
	"""Get the last compute_op corresponding to the current storing memory_op"""

	last_compute_op = None
	compute_op_found = False

	if memory_op_idx[1] != []:
		num_lists = len([idx for idx in range(memory_op_idx[0]) if type(memory_ops[idx]) == list]) + 1
		list_reached = 0
		for idx in range(len(compute_ops)):
			if type(compute_ops[idx]) == list:
				list_reached += 1
			if list_reached == num_lists: 
				head_ops = compute_ops[idx][head_idx]
				break
	else:
		head_ops = compute_ops

	for i, compute_op in enumerate(head_ops):
		if type(compute_op) == list: continue
		if compute_op.op_name.startswith(head_op.op_name[:-2]):
			last_compute_op_idx = i
			compute_op_found = True
			if i == len(head_ops) - 1: return compute_op
		elif compute_op_found:
			return head_ops[last_compute_op_idx]


def prev_memory_op_done(head_op, head_idx, memory_op_idx, memory_ops):
	"""Mark previous memory_op as done"""

	if memory_op_idx[1] != []:
		curr_idx = memory_op_idx[1][head_idx]
		head_ops = memory_ops[memory_op_idx[0]][head_idx]
	else:
		curr_idx = memory_op_idx[0]
		head_ops = memory_ops

	for prev_op_idx in range(curr_idx - 1, -1, -1):
		if type(head_ops[prev_op_idx]) == list: continue
		if head_ops[prev_op_idx].data_type == head_op.data_type:
			head_ops[prev_op_idx].done = True
			break


def update_op_idx(ops, op_idx, stall_list, batch_size, ops_done):
	if op_idx[0] is None:
		return [None, []], 0

	# Update op_idx based on stalls
	for head_idx, stall in enumerate(stall_list):
		if stall:
			# corresponding memory_op remains the same
			pass
		else:
			ops_done += batch_size
			if len(stall_list) > 1:
				if op_idx[1][head_idx] is not None and op_idx[1][head_idx] < len(ops[op_idx[0]][head_idx]) - batch_size:
					op_idx[1][head_idx] += batch_size
				else:
					op_idx[1][head_idx] = None
			else:
				for idx in range(op_idx[0] + 1, op_idx[0] + batch_size + 1):
					if idx >= len(ops) - 1 or type(ops[idx]) == list: break
				op_idx[0] = idx
				if op_idx[0] > len(ops) - 1: break
				elif type(ops[op_idx[0]]) == list:
					op_idx[1] = [0] * len(ops[op_idx[0]])
				else:
					op_idx[1] = []

	# If all ops are done in a multi-head op, proceed to next op
	if len(stall_list) > 1 and all([op_idx[1][head_idx] is None for head_idx in range(len(stall_list))]):
		op_idx[0] += 1
		if op_idx[0] < len(ops) and type(ops[op_idx[0]]) == list:
			op_idx[1] = [0] * len(ops[op_idx[0]])
		else:
			op_idx[1] = []

	if op_idx[0] > len(ops) - 1:
		op_idx[0] = None; op_idx[1] = []

	return op_idx, ops_done


def get_ops_done(memory_ops, compute_ops):
	ops_done = 0
	for op in memory_ops:
		if type(op) == list:
			for head_ops in op:
				for head_op in head_ops:
					if head_op.done: 
						ops_done += 1
					else:
						break
		else:
			if op.done: ops_done += 1

	for op in compute_ops:
		if type(op) == list:
			for head_ops in op:
				for head_op in head_ops:
					if head_op.done: 
						ops_done += 1
					else:
						break
		else:
			if op.done: ops_done += 1

	return ops_done


def get_utilization(accelerator):
	num_mac_lanes_free, num_mac_lanes = accelerator.num_mac_lanes_free()
	num_ln_free, num_ln = accelerator.num_ln_free()
	num_sftm_free, num_sftm = accelerator.num_sftm_free()

	return (num_mac_lanes - num_mac_lanes_free) * 1.0 / num_mac_lanes, (num_ln - num_ln_free) * 1.0 / num_ln, (num_sftm - num_sftm_free) * 1.0 / num_sftm, accelerator.activation_buffer.used * 1.0 / accelerator.activation_buffer.buffer_size, accelerator.weight_buffer.used * 1.0 / accelerator.weight_buffer.buffer_size, accelerator.mask_buffer.used * 1.0 / accelerator.mask_buffer.buffer_size


def log_metrics(logs, total_pe_energy, activation_buffer_energy, weight_buffer_energy, mask_buffer_energy, stalls, logs_dir, accelerator, plot_steps):
	"""Log energy values for every cycle"""
	if logs:
		last_cycle = logs['cycle'][-1]
	else:
		last_cycle = 0
		for log_file in os.listdir(os.path.join(logs_dir, 'metrics')):
			last_cycle = max(last_cycle, int(log_file.split('_')[1].split('.')[0]))

		logs = {'cycle': [], 'total_pe_energy': [], 'activation_buffer_energy': [], 'weight_buffer_energy': [], 'mask_buffer_energy': [], 'activation_buffer_utilization': [], 'weight_buffer_utilization': [], 'mask_buffer_utilization': [], 'mac_lane_utilization': [], 'ln_utilization': [], 'sftm_utilization': [], 'stalls': []}

	cycle_difference = accelerator.cycle - last_cycle
	assert cycle_difference > 0 
	for c in range(last_cycle + 1, accelerator.cycle + 1):
		logs['cycle'].append(c)
		logs['total_pe_energy'].append((total_pe_energy[0] / cycle_difference, total_pe_energy[1] / cycle_difference))
		logs['activation_buffer_energy'].append((activation_buffer_energy[0] / cycle_difference, activation_buffer_energy[1] / cycle_difference))
		logs['weight_buffer_energy'].append((weight_buffer_energy[0] / cycle_difference, weight_buffer_energy[1] / cycle_difference))
		logs['mask_buffer_energy'].append((mask_buffer_energy[0] / cycle_difference, mask_buffer_energy[1] / cycle_difference))

		mac_lane_utilization, ln_utilization, sftm_utilization, activation_buffer_utilization, weight_buffer_utilization, mask_buffer_utilization = get_utilization(accelerator)

		logs['activation_buffer_utilization'].append(activation_buffer_utilization)
		logs['weight_buffer_utilization'].append(weight_buffer_utilization)
		logs['mask_buffer_utilization'].append(mask_buffer_utilization)
		logs['mac_lane_utilization'].append(mac_lane_utilization)
		logs['ln_utilization'].append(ln_utilization)
		logs['sftm_utilization'].append(sftm_utilization)

		logs['stalls'].append(stalls)

	if accelerator.cycle % plot_steps == 0:
		json.dump(logs, open(os.path.join(logs_dir, 'metrics', f'logs_{accelerator.cycle}.json'), 'w+'))
		del logs; gc.collect()
		logs = {}

	## logs_length = len(logs['cycle']) if logs else 0
	## if logs_length > plot_steps: raise RuntimeError(f'Logs length exceeded plot steps')

	return logs


def plot_metrics(logs_dir, constants):
	logs_metrics = {'cycle': [], 'total_pe_energy': [], 'activation_buffer_energy': [], 'weight_buffer_energy': [], 'mask_buffer_energy': [], 'activation_buffer_utilization': [], 'weight_buffer_utilization': [], 'mask_buffer_utilization': [], 'mac_lane_utilization': [], 'ln_utilization': [], 'sftm_utilization': [], 'stalls': []}
	log_files = os.listdir(os.path.join(logs_dir, 'metrics'))
	log_files = sorted(log_files, key=lambda log_file: int(log_file.split('_')[1].split('.')[0]))
	for log_file in log_files:
		logs_temp = json.load(open(os.path.join(logs_dir, 'metrics', log_file)))
		logs_metrics['cycle'].extend(logs_temp['cycle'])
		logs_metrics['total_pe_energy'].extend(logs_temp['total_pe_energy'])
		logs_metrics['activation_buffer_energy'].extend(logs_temp['activation_buffer_energy'])
		logs_metrics['weight_buffer_energy'].extend(logs_temp['weight_buffer_energy'])
		logs_metrics['mask_buffer_energy'].extend(logs_temp['mask_buffer_energy'])
		logs_metrics['activation_buffer_utilization'].extend(logs_temp['activation_buffer_utilization'])
		logs_metrics['weight_buffer_utilization'].extend(logs_temp['weight_buffer_utilization'])
		logs_metrics['mask_buffer_utilization'].extend(logs_temp['mask_buffer_utilization'])
		logs_metrics['mac_lane_utilization'].extend(logs_temp['mac_lane_utilization'])
		logs_metrics['ln_utilization'].extend(logs_temp['ln_utilization'])
		logs_metrics['sftm_utilization'].extend(logs_temp['sftm_utilization'])
		logs_metrics['stalls'].extend(logs_temp['stalls'])

	fig, (ax_power, ax_utilization) = plt.subplots(2, 1)
	moving_avg = min([64, len(logs_metrics['cycle'])])
	ln1 = ax_power.plot(logs_metrics['cycle'], np.convolve([pe_energy[0] * constants['clock_frequency'] / 1000 for pe_energy in logs_metrics['total_pe_energy']], np.ones(moving_avg)/moving_avg, 'same'), color='b', linestyle='-', label='PEs (dynamic)')
	ln2 = ax_power.plot(logs_metrics['cycle'], [pe_energy[1] * constants['clock_frequency'] / 1000 for pe_energy in logs_metrics['total_pe_energy']], color='tab:blue', linestyle='--', label='PEs (leakage)') 
	ax_mem_power = ax_power.twinx()
	ln3 = ax_mem_power.plot(logs_metrics['cycle'], [(logs_metrics['activation_buffer_energy'][i][0] + logs_metrics['weight_buffer_energy'][i][0] + logs_metrics['mask_buffer_energy'][i][0]) * constants['clock_frequency'] / 1000 for i in range(len(logs_metrics['cycle']))], color='tab:grey', label='Buffers Main mem.')
	lns = ln1 + ln2 + ln3
	labs = [ln.get_label() for ln in lns]
	ax_power.legend(lns, labs, loc='upper left')
	ax_power.set_xticklabels([])
	ax_power.set_ylabel('Compute Power (W)', color='b', fontsize=12)
	ax_power.tick_params(axis='y', labelcolor='b')
	ax_mem_power.set_ylabel('Memory Power (W)', fontsize=12)

	ax_utilization.plot(logs_metrics['cycle'], [util * 100.0 for util in logs_metrics['mac_lane_utilization']], color='tab:blue', linestyle='-', label='MAC Lanes')
	ax_utilization.plot(logs_metrics['cycle'], [util * 100.0 for util in logs_metrics['ln_utilization']], color='tab:purple', linestyle='-', label='Layer-norm')
	ax_utilization.plot(logs_metrics['cycle'], np.convolve([util * 100.0 for util in logs_metrics['sftm_utilization']], np.ones(moving_avg)/moving_avg, 'same'), color='tab:green', linestyle='-', label='Softmax')
	ax_utilization.plot(logs_metrics['cycle'], [util * 100.0 for util in logs_metrics['activation_buffer_utilization']], 'k-', label='Activation Buffer')
	ax_utilization.plot(logs_metrics['cycle'], [util * 100.0 for util in logs_metrics['weight_buffer_utilization']], 'k--', label='Weight Buffer')
	ax_utilization.plot(logs_metrics['cycle'], [util * 100.0 for util in logs_metrics['mask_buffer_utilization']], color='grey', label='Mask Buffer')
	ax_utilization.set_xlabel('Cycles', fontsize=12)
	ax_utilization.set_ylabel('Utilization (%)', fontsize=12)
	ax_utilization.legend(loc='upper left')

	del logs_temp, logs_metrics; gc.collect()

	plt.savefig(os.path.join(logs_dir, 'metrics.pdf'), bbox_inches='tight')
	plt.close()


def simulate(model_dict: dict, config: dict, constants: dict, design_space: dict, logs_dir: str, plot_steps: int, plot_utilization=True, first_layer_only=False, debug=False):
	"""Run a model_dict on an Accelerator object"""

	# Check if configuration is valid
	if not debug: check_config(config, design_space)

	# Instantiate accelerator based on given configuration
	accelerator = Accelerator(config, constants)
	print(f'{color.GREEN}Accelerator area: {accelerator.area / 1e6 : 0.03f} mm\u00b2{color.ENDC}')
	
	# Get tiled ops from model dictionary
	memory_ops, compute_ops, num_ops = dict2ops(model_dict, config, tile_compute_ops=config['scheduler']['compute_ops']['tiled'], tile_memory_ops=config['scheduler']['memory_ops']['tiled'], first_layer_only=first_layer_only, debug=debug)

	assert type(memory_ops[1]) == list and type(compute_ops[0]) == list
	memory_op_idx, compute_op_idx, ops_done = [0, []], [0, [0] * len(compute_ops[0])], 0

	# Get operation batch sizes
	compute_ops_batch_size = config['scheduler']['compute_ops']['batch_size']
	memory_ops_batch_size = config['scheduler']['memory_ops']['batch_size']
	assert memory_ops_batch_size == 1

	# Get operations
	memory_op, compute_op = get_op_list(memory_ops, memory_op_idx, memory_ops_batch_size), get_op_list(compute_ops, compute_op_idx, compute_ops_batch_size)

	# Create logs dictionary
	logs = {}

	pbar = tqdm(total=num_ops)
	pbar.set_description(f'Simulating accelerator:')

	sp_char = "\n\t"
	reverse_memory_order = False
	last_compute_ops = {}
	stalls = [0] * 7

	# Run operations on the accelerator in a cycle-accurate manner
	while not compute_ops[-1].done:
		# Update progress bar
		if not debug:
			pbar.set_description(f'Simulating accelerator at cycle: {accelerator.cycle}')
		pbar.update(get_ops_done(memory_ops, compute_ops) - pbar.n)

		# Print cycle
		if debug: tqdm.write(f'{color.GREEN}Cycle: {accelerator.cycle + 1}{color.ENDC}')

		memory_stall, compute_stall = False, False
		new_stalls = [0] * 7

		if debug: 
			tqdm.write(f'{color.HEADER}Running memory operation(s) with name(s):\n\t{f"{sp_char}".join([f"- {op.op_name}" for op in memory_op if op])}\nand compute operation(s) with name(s):\n\t{f"{sp_char}".join(["- " + (f"{op.op_name}" if compute_ops_batch_size == 1 else f"{op[0].op_name} + " + str( compute_ops_batch_size - 1) + " more") for op in compute_op if op])}{color.ENDC}')

		# Run memory operation
		if memory_op:
			memory_stall = [None] * len(memory_op)
			debug_output = []

			# Sort operation order to give higher priority to tasks first
			sorted_head_ids, head_ids = [i for i in range(len(memory_op))], [i for i in range(len(memory_op))]
			if len([op for op in memory_op if op is not None]) > 1:
				sorted_head_ids = np.argsort(np.array([idx for idx  in memory_op_idx[1] if idx is not None]))
				head_ids = np.arange(len(memory_op))
				head_ids = list(head_ids[sorted_head_ids])

			for head_idx in head_ids:
				head_op = memory_op[head_idx]
				if head_op is None: continue

				# Get corresponding data object
				data = head_op.convert_to_data()

				# Word and position embeddings are always required in buffer
				if 'emb' in head_op.op_name: data.required_in_buffer = True

				last_compute_done, store_op = True, False
				if isinstance(head_op, (MemoryStoreOp, MemoryStoreTiledOp)): 
					if head_op.op_name in last_compute_ops:
						last_compute_op = last_compute_ops[head_op.op_name]
					else:
						last_compute_op = get_last_compute_op(head_op, head_idx, memory_op_idx, memory_ops, compute_ops)
						last_compute_ops[head_op.op_name] = last_compute_op
					last_compute_done = last_compute_op.done
					store_op = True

				buffer = getattr(accelerator, f'{data.data_type}_buffer')

				if buffer.ready and accelerator.mask_buffer.ready:
					# Previous memory_op for this buffer is done
					prev_memory_op_done(head_op, head_idx, memory_op_idx, memory_ops)

					if buffer.can_store(data) and accelerator.mask_buffer.can_store(data) and last_compute_done:
						memory_stall[head_idx] = False
					else:
						memory_stall[head_idx] = True
				else:
					memory_stall[head_idx] = True

				if memory_stall[head_idx] and debug:
					op_debug_output = []
					if not buffer.ready: 
						op_debug_output.append(f'{color.WARNING}Memory stall{f" for head {head_idx + 1}" if len(memory_op) > 1 else ""}: {buffer.buffer_type} buffer not ready{color.ENDC}')
						new_stalls[0] = max(1, new_stalls[0] + 1)
					if not accelerator.mask_buffer.ready: 
						op_debug_output.append(f'{color.WARNING}Memory stall{f" for head {head_idx + 1}" if len(memory_op) > 1 else ""}: mask buffer not ready{color.ENDC}')
						new_stalls[1] = max(1, new_stalls[1] + 1)  
					if not buffer.can_store(data): 
						op_debug_output.append(f'{color.WARNING}Memory stall{f" for head {head_idx + 1}" if len(memory_op) > 1 else ""}: {buffer.buffer_type} buffer can\'t store data of size {data.data_size}{color.ENDC}')
						new_stalls[2] = max(1, new_stalls[2] + 1)
					if not accelerator.mask_buffer.can_store(data): 
						op_debug_output.append(f'{color.WARNING}Memory stall{f" for head {head_idx + 1}" if len(memory_op) > 1 else ""}: {accelerator.mask_buffer.buffer_type} buffer can\'t store data of size {data.data_size}{color.ENDC}')
						new_stalls[3] = max(1, new_stalls[3] + 1)
					if not last_compute_done: 
						op_debug_output.append(f'{color.WARNING}Memory stall{f" for head {head_idx + 1}" if len(memory_op) > 1 else ""}: waiting for last compute operation "{get_last_compute_op(head_op, head_idx, memory_op_idx, memory_ops, compute_ops).op_name}"{color.ENDC}')
						new_stalls[4] = max(1, new_stalls[4] + 1)
					debug_output.append("\n".join(op_debug_output))
				
				if not memory_stall[head_idx]:
					if store_op:
						removed_old_data = buffer.store(data)
						removed_old_data_mask = accelerator.mask_buffer.store(data)
					else:
						removed_old_data = buffer.load(data)
						removed_old_data_mask = accelerator.mask_buffer.load(data)

			if debug and debug_output:
				tqdm.write("\n".join([debug_output[i] for i in head_ids if i < len(debug_output)]))

		# Run compute operation
		ops_to_set_required = []
		if compute_op:
			# We do not sort operations here for staggered implemention and better utilization
			compute_stall = [None] * len(compute_op)
			for head_idx, head_ops in enumerate(compute_op):
				if head_ops is None: continue

				# Check if required data is in memory
				if type(head_ops) != list:
					head_ops = [head_ops]

				if not accelerator.can_assign(head_ops):
					compute_stall[head_idx] = True
					if debug: 
						tqdm.write(f'{color.WARNING}Compute stall{f" for head {head_idx + 1}" if len(compute_op) > 1 else ""}: all resources are busy{color.ENDC}')
						new_stalls[5] = max(1, new_stalls[5] + 1)

				required_in_buffer_stall = False
				for head_op in head_ops:
					for data_name in head_op.required_in_buffer:
						if not accelerator.activation_buffer.data_in_buffer(data_name) and not accelerator.weight_buffer.data_in_buffer(data_name):
							compute_stall[head_idx] = True
							required_in_buffer_stall = True
							new_stalls[6] = max(1, new_stalls[6] + 1)
							break
				
				if debug and required_in_buffer_stall: tqdm.write(f'{color.WARNING}Compute stall{f" for head {head_idx + 1}" if len(compute_op) > 1 else ""}: {data_name} required in buffer{color.ENDC}')
							

				if not compute_stall[head_idx]:
					for head_op in head_ops:
						assigned_op = accelerator.assign_op(head_op)
						assert assigned_op is True
						ops_to_set_required.append(head_op)
							
		# Process cycle for every module
		total_pe_energy, activation_buffer_energy, weight_buffer_energy, mask_buffer_energy = accelerator.process_cycle(memory_ops, compute_ops, ops_to_set_required + compute_op)
		accelerator.cycle += 1

		# Update stalls
		stalls = [stalls[i] + new_stalls[i] for i in range(7)]

		# Log energy values for each cycle 
		if DO_LOGGING: logs = log_metrics(logs, total_pe_energy, activation_buffer_energy, weight_buffer_energy, mask_buffer_energy, stalls, logs_dir, accelerator, plot_steps)

		if debug:
			mac_lane_utilization, ln_utilization, sftm_utilization, activation_buffer_utilization, weight_buffer_utilization, mask_buffer_utilization = get_utilization(accelerator)

			tqdm.write(f'Activation Buffer used: {activation_buffer_utilization * 100.0 : 0.3f}%')
			tqdm.write(f'Weight Buffer used: {weight_buffer_utilization * 100.0 : 0.3f}%')
			tqdm.write(f'Mask Buffer used: {mask_buffer_utilization * 100.0 : 0.3f}%')
			tqdm.write(f'MAC Lanes used: {mac_lane_utilization * 100.0 : 0.3f}%')
			tqdm.write(f'Layer-norm used: {ln_utilization * 100.0 : 0.3f}%')
			tqdm.write(f'Softmax used: {sftm_utilization * 100.0 : 0.3f}%')

		if accelerator.cycle % plot_steps == 0:
			# Plot utilization of the accelerator
			if plot_utilization: accelerator.plot_utilization(os.path.join(logs_dir, 'utilization'))

			# Plot metrics
			if DO_LOGGING: plot_metrics(logs_dir, constants)

		if memory_op_idx[0] is not None and memory_op_idx[0] < len(memory_ops) and  all([stall for stall in memory_stall if stall is not None]) and all([stall for stall in compute_stall if stall is not None]) and accelerator.all_resources_free():
			cycles_list = [process_cycles for process_cycles in [accelerator.activation_buffer.process_cycles, accelerator.weight_buffer.process_cycles, accelerator.mask_buffer.process_cycles] if process_cycles not in [0, None]]
			min_cycles = min(cycles_list) if cycles_list else 0
			min_cycles = min(plot_steps - accelerator.cycle % plot_steps - 1, min_cycles)

			if min_cycles > 1:
				activation_buffer_energy = accelerator.activation_buffer.process_cycle(min_cycles)
				weight_buffer_energy = accelerator.weight_buffer.process_cycle(min_cycles)
				mask_buffer_energy = accelerator.mask_buffer.process_cycle(min_cycles)

				accelerator.cycle += min_cycles

				stalls = [stalls[i] + (new_stalls[i] * min_cycles) for i in range(7)]

				if DO_LOGGING: logs = log_metrics(logs, (0, 0), activation_buffer_energy, weight_buffer_energy, mask_buffer_energy, stalls, logs_dir, accelerator, plot_steps)
				continue

		memory_op_idx, ops_done = update_op_idx(memory_ops, memory_op_idx, memory_stall, memory_ops_batch_size, ops_done)
		compute_op_idx, ops_done = update_op_idx(compute_ops, compute_op_idx, compute_stall, compute_ops_batch_size, ops_done)

		memory_op, compute_op = get_op_list(memory_ops, memory_op_idx, memory_ops_batch_size), get_op_list(compute_ops, compute_op_idx, compute_ops_batch_size)

	# Save remaining logs
	if DO_LOGGING: 
		json.dump(logs, open(os.path.join(logs_dir, 'metrics', f'logs_{accelerator.cycle}.json'), 'w+'))
		plot_metrics(logs_dir, constants)

	pbar.close()
	print(f'{color.GREEN}Finished simulation{color.ENDC}')


def simulate_fast(model_dict: dict, config: dict, constants: dict, design_space: dict, logs_dir: str, plot_steps: int, plot_utilization=True, first_layer_only=False, debug=False):
	"""Run model_dict in an approximate manner on the Accelerator object"""

	# Check if configuration is valid
	if not debug: check_config(config, design_space)

	# Instantiate accelerator based on given configuration
	accelerator = Accelerator(config, constants)
	print(f'{color.GREEN}Accelerator area: {accelerator.area / 1e6 : 0.03f} mm\u00b2{color.ENDC}')
	
	# Get ops from model_dict
	memory_ops, compute_ops, num_ops = dict2ops(model_dict, config, tile_compute_ops=False, tile_memory_ops=False, first_layer_only=first_layer_only, debug=debug)
	print('No tiling implemented in a fast run')

	assert type(memory_ops[1]) == list and type(compute_ops[0]) == list
	memory_op_idx, compute_op_idx, ops_done = [0, []], [0, [0] * len(compute_ops[0])], 0
	memory_fast_idx, compute_fast_idx = 1, 0

	energy = {'buffer': 0, 'main_memory': 0, 'mac_lanes': [0, 0], 'softmax': [0, 0], 'layer_norm': [0 ,0], 'sparsity': [0, 0], 'others': [0, 0]}

	# Current cycle
	cycles = 0

	# Set weight factors
	weight_factor = {'activation': (constants['bits']['IL'] + constants['bits']['FL']) * (1 - constants['sparsity']['activation']), 'weight': (constants['bits']['IL'] + constants['bits']['FL']) * (1 - constants['sparsity']['weight']), 'mask': 1}

	# Set buffer parameters
	main_memory_energy = constants['main_memory']['energy'][f'{config["main_memory"]["type"]}_{config["main_memory"]["banks"]}_{config["main_memory"]["ranks"]}_{config["main_memory"]["channels"]}']
	main_memory_bandwidth = constants['main_memory']['bandwidth'][config['main_memory']['mode']]
	main_memory_block_size = constants['main_memory']['block_size']

	# Set PE paramaters
	clock_frequency = constants['clock_frequency']
	num_mac_lanes = config['pe'] * config['lanes_per_pe']
	num_macs = config['pe'] * config['lanes_per_pe'] * config['mac_per_lane']
	num_softmax = config['pe'] * config['softmax_per_pe']
	num_layer_norm = config['pe']
	mac_lane_dynamic = constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['dynamic']
	mac_lane_leakage = constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['leakage'] 
	softmax_dynamic = constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['dynamic']
	softmax_leakage = constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['leakage']
	layer_norm_dynamic = constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['dynamic']
	layer_norm_leakage = constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['leakage']
	sparsity_dynamic = constants['pre_sparsity']['dynamic'] + constants['post_sparsity']['dynamic']
	sparsity_leakage = constants['pre_sparsity']['leakage'] + constants['post_sparsity']['leakage']
	others_dynamic = constants['dma']['dynamic'] + constants['fifo']['dynamic'] + constants['dataflow']['dynamic']
	others_leakage = constants['dma']['leakage'] + constants['fifo']['leakage'] + constants['dataflow']['leakage']

	# Get input embeddings into weight buffer
	emb_data = memory_ops[0].convert_to_data()
	accelerator.weight_buffer.can_store(emb_data)
	cycles += math.ceil(emb_data.data_size * weight_factor['weight'] / main_memory_bandwidth)
	# energy['weight_buffer'] += main_memory_energy * emb_data.data_size / main_memory_block_size

	# Create logs dictionary
	logs = {}

	pbar = tqdm(total=len(compute_ops)-1)
	pbar.set_description(f'Simulating accelerator:')

	while memory_fast_idx < len(memory_ops) or compute_fast_idx < len(compute_ops):

		# Update progress bar
		pbar.update(compute_fast_idx - pbar.n)

		if memory_fast_idx < len(memory_ops):
			if type(memory_ops[memory_fast_idx]) == list:
				# Find energy of all ops
				for head in memory_ops[memory_fast_idx]:
					for head_op in head:
						data = head_op.convert_to_data()
						if isinstance(head_op, MemoryStoreOp):
							energy[f'buffer'] += constants[f'{data.data_type}_buffer']['energy'] * math.sqrt(config[f'{data.data_type}_buffer_size']) * data.data_size / constants[f'{data.data_type}_buffer']['block_size']
						else:
							energy[f'main_memory'] += main_memory_energy * data.data_size * (1 - constants['sparsity']['weight']) / main_memory_block_size
			else:
				head_op = memory_ops[memory_fast_idx]
				data = head_op.convert_to_data()
				if isinstance(head_op, MemoryStoreOp):
					energy[f'buffer'] += constants[f'{data.data_type}_buffer']['energy'] * math.sqrt(config[f'{data.data_type}_buffer_size']) * data.data_size / constants[f'{data.data_type}_buffer']['block_size']
				else:
					energy[f'main_memory'] += main_memory_energy * data.data_size * (1 - constants['sparsity']['weight']) / main_memory_block_size

		if compute_fast_idx < len(compute_ops):
			if type(compute_ops[compute_fast_idx]) == list:
				mac_lanes_head, softmax_head, layer_norm_head = None, None, None
				pe_cycles = [np.inf, np.inf, np.inf]
				head_ids = [0 for _ in range(len(compute_ops[compute_fast_idx]))]
				while any([head_ids[i] < len(compute_ops[compute_fast_idx][i]) for i in range(len(head_ids))]):
					for i, head_id in enumerate(head_ids):
						if head_id == len(compute_ops[compute_fast_idx][i]): continue
						head_op = compute_ops[compute_fast_idx][i][head_id]
						if isinstance(head_op, (MatrixMultOp, Conv1DOp)):
							if mac_lanes_head is None:
								tiled_ops = head_op.tile_op()
								mac_lanes_cycles = math.ceil(len(tiled_ops) * tiled_ops[0].num_muls * 1.0 / num_macs * (1 - constants['sparsity']['activation']))
								energy['mac_lanes'][0] += (mac_lane_dynamic * num_mac_lanes) / clock_frequency * mac_lanes_cycles 
								energy['mac_lanes'][1] += (mac_lane_leakage * num_mac_lanes) / clock_frequency * mac_lanes_cycles 
								energy['sparsity'][0] += (sparsity_dynamic * num_mac_lanes) / clock_frequency * len(tiled_ops)
								energy['sparsity'][1] += (sparsity_leakage * num_mac_lanes) / clock_frequency * len(tiled_ops)
								energy['others'][0] += (others_dynamic * config['pe']) / clock_frequency * len(tiled_ops)
								energy['others'][1] += (others_leakage * config['pe']) / clock_frequency * len(tiled_ops)
								pe_cycles[0], mac_lanes_head = mac_lanes_cycles, i
								head_ids[i] = min(head_ids[i] + 1, len(compute_ops[compute_fast_idx][i]))
						elif isinstance(head_op, SoftmaxOp):
							if softmax_head is None:
								tiled_ops = head_op.tile_op()
								softmax_cycles = math.ceil(len(tiled_ops) * tiled_ops[0].input_size[0] * (tiled_ops[0].input_size[0] + tiled_ops[0].input_size[1]) * (1 - constants['sparsity']['activation']) / num_softmax)
								energy['softmax'][0] += (softmax_dynamic * num_softmax) / clock_frequency * softmax_cycles
								energy['softmax'][1] += (softmax_leakage * num_softmax) / clock_frequency * softmax_cycles
								pe_cycles[1], softmax_head = softmax_cycles, i
								head_ids[i] = min(head_ids[i] + 1, len(compute_ops[compute_fast_idx][i]))
						elif instance(head_op, LayerNormOp):
							if layer_norm_head is not None:
								tiled_ops = head_op.tile_op()
								layer_norm_cycles = math.ceil(len(tiled_ops) * tiled_ops[0].input_size[0] * (tiled_ops[0].input_size[1] + tiled_ops[0].input_size[2]) * (1 - constants['sparsity']['activation']) / num_layer_norm)
								energy['layer_norm'][0] += (layer_norm_dynamic * num_layer_norm) / clock_frequency * layer_norm_cycles
								energy['layer_norm'][1] += (layer_norm_leakage * num_layer_norm) / clock_frequency * layer_norm_cycles
								pe_cycles[2], layer_norm_head = layer_norm_cycles, i
								head_ids[i] = min(head_ids[i] + 1, len(compute_ops[compute_fast_idx][i]))

					min_cycles = min(pe_cycles)
					cycles += min_cycles

					for m in range(len(pe_cycles)):
						if pe_cycles[m] == min_cycles:
							if m == 0:
								mac_lanes_head = None
							elif m == 1:
								softmax_head = None
							else:
								layer_norm_head = None
							pe_cycles[m] = np.inf
						else:
							pe_cycles[m] -= min_cycles

					if mac_lanes_head is None:
						assert pe_cycles[0] == np.inf
					else:
						assert pe_cycles[0] < np.inf

					if softmax_head is None:
						assert pe_cycles[1] == np.inf
					else:
						assert pe_cycles[1] < np.inf

					if layer_norm_head is None:
						assert pe_cycles[2] == np.inf
					else:
						assert pe_cycles[2] < np.inf
			else:
				head_op = compute_ops[compute_fast_idx]
				if isinstance(head_op, MatrixMultOp):
					mac_lanes_cycles = math.ceil(head_op.num_muls * 1.0 / num_macs * (1 - constants['sparsity']['activation']))
					cycles += mac_lanes_cycles
					energy['mac_lanes'][0] += (mac_lane_dynamic * num_mac_lanes) / clock_frequency * mac_lanes_cycles 
					energy['mac_lanes'][1] += (mac_lane_leakage * num_mac_lanes) / clock_frequency * mac_lanes_cycles
				elif isinstance(head_op, SoftmaxOp):
					tiled_ops = head_op.tile_op()
					softmax_cycles = math.ceil(len(tiled_ops) * tiled_ops[0].input_size[0] * (tiled_ops[0].input_size[0] + tiled_ops[0].input_size[1]) * (1 - constants['sparsity']['activation']) / num_softmax)
					cycles += softmax_cycles
					energy['softmax'][0] += (softmax_dynamic * num_softmax) / clock_frequency * softmax_cycles
					energy['softmax'][1] += (softmax_leakage * num_softmax) / clock_frequency * softmax_cycles
				elif isinstance(head_op, LayerNormOp):
					tiled_ops = head_op.tile_op()
					layer_norm_cycles = math.ceil(len(tiled_ops) * tiled_ops[0].input_size[0] * (tiled_ops[0].input_size[1] + tiled_ops[0].input_size[2]) * (1 - constants['sparsity']['activation']) / num_layer_norm)
					cycles += layer_norm_cycles
					energy['layer_norm'][0] += (layer_norm_dynamic * num_layer_norm) / clock_frequency * layer_norm_cycles
					energy['layer_norm'][1] += (layer_norm_leakage * num_layer_norm) / clock_frequency * layer_norm_cycles

		memory_fast_idx = min(memory_fast_idx + 1, len(memory_ops))
		compute_fast_idx = min(compute_fast_idx + 1, len(compute_ops))

	logs = {'cycles': cycles, 'energy': energy}

	# Save logs
	if DO_LOGGING: 
		json.dump(logs, open(os.path.join(logs_dir, 'metrics', f'logs_fast.json'), 'w+'))

	pbar.close()
	print(f'{color.GREEN}Finished simulation{color.ENDC}')

