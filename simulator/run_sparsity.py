# Run sparsity tests

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
	os.makedirs('./constants/sparsity/', exist_ok=True)

	main_constants = yaml.safe_load(open(args.main_constants_path, 'r'))
	results_tiny = json.load(open('../pruning/results/bert-tiny_sst2_dp/results.json'))
	sparsities = [result['activation_sparsity'] for result in results_tiny[1::4]]

	for sparsity in sparsities:
		print(f'Running simulator with sparsity: {sparsity * 100 : 0.03f}%')

		# Set local logs dir
		local_logs_dir = os.path.join(args.logs_dir, f'bert_tiny_edge_sp{round(sparsity * 100)}')

		if os.path.exists(os.path.join(local_logs_dir, 'metrics.pdf')):
			print('Results already stored')
			continue

		os.makedirs(local_logs_dir, exist_ok=True)

		# Copy main constants
		constants = deepcopy(main_constants)
		constants_path = os.path.join('./constants/sparsity/', f'constants_sp{round(sparsity * 100)}.yaml')

		# Update constants
		constants['sparsity']['activation'] = sparsity

		# Save constants
		yaml.dump(constants, open(constants_path, 'w+'), sort_keys=False)

		# Run simulator for this constants
		os.system(f'source ./job_scripts/job_creator.sh --id {args.id} --sp {round(sparsity * 100)}')


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
	parser.add_argument('--config_path',
		metavar='',
		type=str,
		default='./config/config_tiny.yaml',
		help='path to the accelerator configuration file')
	parser.add_argument('--main_constants_path',
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
		default='./results/sparsity/',
		help='directory to store results')

	args = parser.parse_args()

	main(args)

