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

sys.path.append('./src/')

from pe import *
from ops import *
from utils import *
from buffer import *
from tiled_ops import *
from simulator import *
from accelerator import *
from dict2ops import main as dict2ops


SEQ_LENGTH = 128
DEBUG = False
OVERWRITE_PLOT_STEPS_WITH_DEBUG = False
OVERWRITE_LOGS = True


def main(model_dict: dict, config: dict, constants: dict, design_space: dict, logs_dir: str, plot_steps: int, plot_utilization=True, first_layer_only=False, fast=False, debug=False):

	if fast == False:
		simulate(model_dict, config, constants, design_space, logs_dir, plot_steps, plot_utilization, first_layer_only, debug)
	else:
		simulate_fast(model_dict, config, constants, design_space, logs_dir, plot_steps, plot_utilization, first_layer_only, debug)
	

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
		default='./config/config_tiny.yaml',
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
	parser.add_argument('--plot_steps',
		metavar='',
		type=int,
		default=1,
		help='number of cycles after which to plot')
	parser.add_argument('--logs_dir',
		metavar='',
		type=str,
		default='./results/bert_tiny/',
		help='directory to store results')
	parser.add_argument('--do_not_plot_utilization',
		dest='plot_utilization',
		help='do not plot accelerator utilization',
		action='store_false')
	parser.add_argument('--first_layer_only',
		dest='first_layer_only',
		help='only simulate the first layer',
		action='store_true')
	parser.add_argument('--fast',
		dest='fast',
		help='fast and approximate simuulation',
		action='store_true')
	parser.add_argument('--debug',
		dest='debug',
		help='print debugging statements',
		action='store_true')
	parser.set_defaults(debug=DEBUG, fast=False, plot_utilization=True, first_layer_only=False)

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

	if args.debug and OVERWRITE_PLOT_STEPS_WITH_DEBUG: 
		args.plot_steps = 1
		print(f'{color.WARNING}Plotting steps set to 1 in debugging mode{color.ENDC}')

	if os.path.exists(args.logs_dir) and OVERWRITE_LOGS: shutil.rmtree(args.logs_dir)
	os.makedirs(os.path.join(args.logs_dir, 'metrics')); os.makedirs(os.path.join(args.logs_dir, 'utilization'))

	main(model_dict, config, constants, design_space, args.logs_dir, args.plot_steps, args.plot_utilization, args.first_layer_only, args.fast, args.debug)

