# Test backward pass in AccelTran

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


def main():

	config = yaml.safe_load(open('./config/config_base.yaml'))
	model_dict = json.load(open('./model_dicts/bert_tiny.json'))

	op = SelfAttentionOp('test', config, input_size=(4, 128, 768), hidden_size=64, type='wma')

	# Test forward and backward operation creation
	op.convert_to_fwd_base_ops()
	op.convert_to_bwd_base_ops()

	op = ConvOp('test', config, input_size=(4, 128, 768), hidden_size=64, kernel_size=5)

	# Test forward and backward operation creation
	op.convert_to_fwd_base_ops()
	op.convert_to_bwd_base_ops()

	op = FeedForwardOp('test', config, input_size=(4, 128, 768), hidden_size=1024)

	# Test forward and backward operation creation
	op.convert_to_fwd_base_ops()
	op.convert_to_bwd_base_ops()

	# Test backward operations
	dict2ops(model_dict, config)
	

if __name__ == '__main__':
	main()

