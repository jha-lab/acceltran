# Convert a Transformer dictionary in FlexiBERT 2.0 framework to 
# software compute operations

import os
import sys
import json
import argparse
import yaml
from ops import *


SEQ_LENGTH = 512


def main(model_dict: dict, config: dict, debug=False):
	"""Convert model dictionary to software compute operations"""
	assert 'p' not in model_dict.keys(), 'Only model dictionaries in FlexiBERT 2.0 are supported'

	batch_size = config['batch_size']

	ops = []

	for layer in range(model_dict['l']):
		layer_hidden_size = model_dict['h'][layer]
		for i, attention_head in enumerate(model_dict['o'][layer]):
			type, param, hidden = attention_head.split('_')

			op_name = attention_head + '_' + str(layer) + '_' + str(i + 1)
			input_size = (batch_size, SEQ_LENGTH, layer_hidden_size)
			
			if type == 'sa':
				ops.append(SelfAttentionOp(op_name, input_size, hidden_size=hidden, type=param))
				ops.append(SoftmaxOp(f'sftm_{layer}_{(i+1)}', input_size))
			elif type == 'c':
				ops.append(ConvOp(op_name, input_size, hidden_size=hidden, kernel_size=int(param)))
			elif type == 'l':
				ops.append(LinearTransformOp(op_name, input_size, hidden_size=hidden, type=param))

			if debug: print(f'Added operation with name: {op_name}')

		ops.append(LayerNormOp(f'ln_{layer}_1', input_size=(batch_size, SEQ_LENGTH, layer_hidden_size)))

		last_hidden_size = layer_hidden_size
		for i, hidden in enumerate(model_dict['f'][layer]):
			op_name = 'ff' + '_' + str(layer) + '_' + str(i + 1)
			input_size = (batch_size, SEQ_LENGTH, last_hidden_size)
			ops.append(FeedForwardOp(op_name, input_size, hidden_size=hidden))
			ops.append(NonLinearityOp(f'nl_{layer}_{(i+1)}', input_size, type='gelu'))
			last_hidden_size = hidden

			if debug: print(f'Added operation with name: {op_name}')

			if i == len(model_dict['f'][layer]) - 1:
				op_name = 'ff' + '_' + str(layer) + '_' + str(i + 2)
				input_size = (batch_size, SEQ_LENGTH, last_hidden_size)
				ops.append(FeedForwardOp(op_name, input_size, hidden_size=layer_hidden_size))
				ops.append(NonLinearityOp(f'nl_{layer}_{(i+1)}', input_size, type='gelu'))

				if debug: print(f'Added operation with name: {op_name}')

		ops.append(LayerNormOp(f'ln_{layer}_2', input_size=(batch_size, SEQ_LENGTH, layer_hidden_size)))

		projection_head = True

		if layer == model_dict['l'] - 1:
			projection_head = False
		elif layer_hidden_size == model_dict['h'][layer + 1]:
			projection_head = False

		if projection_head:
			op_name = 'ff' + '_' + str(layer) + '_' + 'proj'
			input_size = (batch_size, SEQ_LENGTH, layer_hidden_size)
			ops.append(FeedForwardOp(op_name, input_size, hidden_size=model_dict['h'][layer + 1]))
			ops.append(NonLinearityOp(f'nl_{layer}_{(i+1)}', input_size, type='gelu'))

			if debug: print(f'Added operation with name: {op_name}')


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description='Input parameters for conversion',
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--model_dict_path',
		metavar='',
		type=str,
		help='path where the model dictionary file is stored')
	parser.add_argument('--config_path',
		metavar='',
		type=str,
		help='path to the configuration file')
	parser.add_argument('--debug',
		dest='debug',
		help='print debugging statements',
		action='store_true')
	parser.set_defaults(debug=False)

	args = parser.parse_args()

	if os.path.exists(args.model_dict_path):
		model_dict = json.load(open(args.model_dict_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.model_dict_path}')

	if os.path.exists(args.config_path):
		config = yaml.safe_load(open(args.config_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.config_path}')

	main(model_dict, config, args.debug)
