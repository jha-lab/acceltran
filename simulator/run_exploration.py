# Run exploration of different PEs and buffer sizes

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
from copy import deepcopy
from matplotlib import pyplot as plt

sys.path.append('./src/')

from pe import *
from ops import *
from utils import *
from buffer import *
from tiled_ops import *
from accelerator import *
from dict2ops import main as dict2ops


SEQ_LENGTH = 128
DO_LOGGING = True
OVERWRITE_LOGS = True
gc.disable()


def main(args):
	"""Run design space exploration"""

	os.makedirs(args.logs_dir, exist_ok=True)
	os.makedirs('./config/exploration/', exist_ok=True)

	main_config = yaml.safe_load(open(args.main_config_path, 'r'))

	buffer_sizes = [10, 11, 12, 13, 14, 15, 16]
	pes = [16, 32, 64, 128, 256]

	for buffer_size in buffer_sizes:
		for pe in pes:
			print(f'Running simulator for buffer size: {buffer_size} an numer of PEs: {pe}')

			# Set local logs dir
			local_logs_dir = os.path.join(args.logs_dir, f'bert_tiny_edge_bs{buffer_size}_pe{pe}')

			if os.path.exists(os.path.join(local_logs_dir, 'metrics.pdf')):
				print('Results already stored')
				continue

			os.makedirs(local_logs_dir, exist_ok=True)
			output_file = os.path.join(local_logs_dir, 'debug_output.txt')

			# Copy main config
			config = deepcopy(main_config)
			config_path = os.path.join('./config/exploration/', f'config_tiny_bs{buffer_size}_pe{pe}.yaml')

			# Update config
			config['activation_buffer_size'] *= buffer_size / 13.0
			config['weight_buffer_size'] *= buffer_size / 13.0
			config['mask_buffer_size'] *= buffer_size / 13.0
			config['pe'] = pe

			# Modify batch size based on number of PEs
			config['scheduler']['compute_ops']['batch_size'] = int(pe / 64.0 * 8.0)

			# Save config
			yaml.dump(config, open(config_path, 'w+'), sort_keys=False)

			# Run simulator for this config
			os.system(f'source ./job_scripts/job_creator.sh --id {args.id} --bs {buffer_size} --pe {pe}')


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description='Input parameters for conversion',
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--id',
		metavar='',
		type=str,
		default='',
		help='ID for Slurm jobs')
	parser.add_argument('--model_dict_path',
		metavar='',
		type=str,
		default='./model_dicts/bert_tiny.json',
		help='path where the model dictionary file is stored')
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
	parser.add_argument('--plot_steps',
		metavar='',
		type=int,
		default=1000,
		help='number of cycles after which to plot')
	parser.add_argument('--logs_dir',
		metavar='',
		type=str,
		default='./results/exploration/',
		help='directory to store results')

	args = parser.parse_args()

	main(args)

