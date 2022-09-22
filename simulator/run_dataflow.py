# Run dataflow tests

import os
import gc
import re
import sys
import json
import yaml
import time
import shutil
import argparse
import itertools
import numpy as np
from tqdm import tqdm
from copy import deepcopy
from matplotlib import pyplot as plt

sys.path.append('./src/')

from pe import *
from ops import *
from utils import *
from buffer import *
from modules import *
from tiled_ops import *
from accelerator import *
from dict2ops import main as dict2ops

gc.disable()


def get_ops_done(ops):
	ops_done = 0
	for op in ops:
		if op.done: ops_done += 1

	return ops_done


def main(args):
	"""Run sparsity tests"""

	if args.test:
		constants = yaml.safe_load(open(args.constants_path))
		main_config = yaml.safe_load(open(args.main_config_path))

		matmul_sizes = [int(size) for size in args.matmul_sizes.split('_')]

		# Create four MAC lanes
		mac_lanes = [MACLane(f'mac_lane_{i}', main_config, constants) for i in range(4)]

		# Define some constants
		access_energy = constants['activation_buffer']['energy'] * math.sqrt(main_config[f'activation_buffer_size'])
		block_size = constants['activation_buffer']['block_size']

		results = {'mat_mul_sizes': args.matmul_sizes}
		for loop_unrolling in itertools.permutations(['b', 'i', 'j', 'k']):
			print(f'Running loop unrolling: {"_".join(loop_unrolling)}')

			# Update config with new loop unrolling
			config = deepcopy(main_config)
			config['loop_unrolling'] = '_'.join(loop_unrolling)

			# Create a matrix multiplication operation and tile it
			op = MatrixMultOp('matrix_mult', config, [], (4, matmul_sizes[0], matmul_sizes[1]), (4, matmul_sizes[1], matmul_sizes[2]))
			tiled_ops = op.tile_op()

			result = {'cycles': 0, 'energy': [0, 0], 're_use': 0}

			op_idx = 0
			while get_ops_done(tiled_ops) < len(tiled_ops):
				if args.debug: print(f'Cycle: {result["cycles"]}')
				# Assign ops for mac_lanes that are free
				for mac_lane in mac_lanes:
					if not mac_lane.ready: continue

					# Get tile information for current op
					op = tiled_ops[op_idx]
					b = int(re.search('b([0-9]+)', op.op_name).group()[1:])
					i = int(re.search('i([0-9]+)', op.op_name).group()[1:])
					j = int(re.search('j([0-9]+)', op.op_name).group()[1:])
					k = int(re.search('k([0-9]+)', op.op_name).group()[1:])
					
					if not (mac_lane.fifo.b == b and mac_lane.fifo.i == i and mac_lane.fifo.k == k):
						result['energy'][0] += access_energy * math.prod(op.input_1_size) / block_size
					else:
						result['re_use'] += 1
						if args.debug: print(f'Input 1 re-use for MAC Lane: {mac_lane.module_name}')

					if not (mac_lane.fifo.b == b and mac_lane.fifo.k == k and mac_lane.fifo.k == k):
						result['energy'][0] += access_energy * math.prod(op.input_2_size) / block_size
					else:
						result['re_use'] += 1
						if args.debug: print(f'Input 2 re-use for MAC Lane: {mac_lane.module_name}')

					mac_lane.assign_op(op)
					if args.debug: print(f'Assigned operation "{op.op_name}" to MAC Lane: {mac_lane.module_name}')

					op_idx += 1

				for mac_lane in mac_lanes:
					energy = mac_lane.process_cycle()
					result['energy'][0] += energy[0]; result['energy'][1] += energy[1]

				result['cycles'] += 1

			print(f'Cycles: {result["cycles"]}, Energy: {result["energy"]}, Re-use instances: {result["re_use"]}')
			results[config['loop_unrolling']] = result

		os.makedirs(args.logs_dir, exist_ok=True)
		json.dump(results, open(os.path.join(args.logs_dir, f'test_dataflow_{args.matmul_sizes}.json'), 'w+'))
	
	else:
		os.makedirs(args.logs_dir, exist_ok=True)
		os.makedirs('./config/dataflow/', exist_ok=True)

		main_config = yaml.safe_load(open(args.main_config_path, 'r'))

		for loop_unrolling in itertools.permutations(['b', 'i', 'j', 'k']):
			print(f'Running loop unrolling: {"_".join(loop_unrolling)}')

			# Set local logs dir
			local_logs_dir = os.path.join(args.logs_dir, f'bert_tiny_edge_{"_".join(loop_unrolling)}')

			if os.path.exists(os.path.join(local_logs_dir, 'metrics.pdf')):
				print('Results already stored')
				continue

			os.makedirs(local_logs_dir, exist_ok=True)

			# Copy main config
			config = deepcopy(main_config)
			config_path = os.path.join('./config/dataflow/', f'config_tiny_{"_".join(loop_unrolling)}.yaml')

			# Update config
			config['loop_unrolling'] = '_'.join(loop_unrolling)

			# Save config
			yaml.dump(config, open(config_path, 'w+'), sort_keys=False)

			# Run simulator for this config
			os.system(f'source ./job_scripts/job_creator.sh --id {args.id} --df {"_".join(loop_unrolling)}')


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description='Input parameters',
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--id',
		metavar='',
		type=str,
		default='',
		help='ID for Slurm jobs')
	parser.add_argument('--main_config_path',
		metavar='',
		type=str,
		default='./config/config_tiny.yaml',
		help='path to the accelerator configuration file')
	parser.add_argument('--constants_path',
		metavar='',
		type=str,
		default='./constants/constants.yaml',
		help='path to the accelerator constants file')
	parser.add_argument('--logs_dir',
		metavar='',
		type=str,
		default='./results/dataflow/',
		help='directory to store results')
	parser.add_argument('--matmul_sizes',
		metavar='',
		type=str,
		default='64_64_64',
		help='sizes of matrices for multiplication')
	parser.add_argument('--test',
		dest='test',
		help='test on a matrix multiplication operation',
		action='store_true')
	parser.add_argument('--debug',
		dest='debug',
		help='print debugging statements',
		action='store_true')
	parser.set_defaults(debug=False, test=False)

	args = parser.parse_args()

	main(args)

