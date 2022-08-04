# Convert a Transformer dictionary in FlexiBERT 2.0 framework to 
# software compute operations

import os
import sys
import json
import argparse
import yaml
from tqdm import tqdm
from ops import *


SEQ_LENGTH = 512
VOCAB_SIZE = 30522


def main(model_dict: dict, config: dict, tile_compute_ops=False, tile_memory_ops=False, debug=False):
	"""Convert model dictionary to software compute operations"""
	assert 'p' not in model_dict.keys(), 'Only model dictionaries in FlexiBERT 2.0 are supported'

	batch_size = config['batch_size']

	ops = []
	ops.append(MemoryStoreOp('word_emb', config, (VOCAB_SIZE, model_dict['h'][0]), 'weight'))
	ops.append(MemoryStoreOp('pos_emb', config, (SEQ_LENGTH, model_dict['h'][0]), 'weight'))

	for layer in range(model_dict['l']):
		layer_hidden_size = model_dict['h'][layer]
		multihead_ops = []
		for i, attention_head in enumerate(model_dict['o'][layer]):
			type, param, hidden = attention_head.split('_')

			op_name = attention_head + '_' + str(layer + 1) + '_' + str(i + 1)
			input_size = (batch_size, SEQ_LENGTH, layer_hidden_size)
			
			if type == 'sa':
				multihead_ops.append(SelfAttentionOp(op_name, config, input_size, hidden_size=int(hidden), type=param))
			elif type == 'c':
				multihead_ops.append(ConvOp(op_name, config, input_size, hidden_size=int(hidden), kernel_size=int(param)))
			elif type == 'l':
				multihead_ops.append(LinearTransformOp(op_name, config, input_size, hidden_size=int(hidden), type=param))

			if debug: print(f'Added operation with name: {op_name}')

		ops.append(multihead_ops)

		ops.append(LayerNormOp(f'ln_{layer}_1', config, [], input_size=(batch_size, SEQ_LENGTH, layer_hidden_size)))

		last_hidden_size = layer_hidden_size
		for i, hidden in enumerate(model_dict['f'][layer]):
			op_name = 'ff' + '_' + str(layer + 1) + '_' + str(i + 1)
			input_size = (batch_size, SEQ_LENGTH, last_hidden_size)
			ops.append(FeedForwardOp(op_name, config, input_size, hidden_size=hidden))
			ops.append(NonLinearityOp(f'nl_{layer}_{(i+1)}', config, [f'{op_name}_f-s'], input_size, type=config['non_linearity']))
			last_hidden_size = hidden

			if debug: print(f'Added operation with name: {op_name}')

			if i == len(model_dict['f'][layer]) - 1:
				op_name = 'ff' + '_' + str(layer + 1) + '_' + str(i + 2)
				input_size = (batch_size, SEQ_LENGTH, last_hidden_size)
				ops.append(FeedForwardOp(op_name, config, input_size, hidden_size=layer_hidden_size))
				ops.append(NonLinearityOp(f'nl_{layer}_{(i+1)}', config, [f'{op_name}_f-s'], input_size, type=config['non_linearity']))

				if debug: print(f'Added operation with name: {op_name}')

		ops.append(LayerNormOp(f'ln_{layer}_2', config, [], input_size=(batch_size, SEQ_LENGTH, layer_hidden_size)))

		projection_head = True

		if layer == model_dict['l'] - 1:
			projection_head = False
		elif layer_hidden_size == model_dict['h'][layer + 1]:
			projection_head = False

		if projection_head:
			op_name = 'ff' + '_' + str(layer + 1) + '_' + 'proj'
			input_size = (batch_size, SEQ_LENGTH, layer_hidden_size)
			ops.append(FeedForwardOp(op_name, config, input_size, hidden_size=model_dict['h'][layer + 1]))
			ops.append(NonLinearityOp(f'nl_{layer}_{(i+1)}', config, [f'{op_name}_f-s'], input_size, type=config['non_linearity']))

			if debug: print(f'Added operation with name: {op_name}')

	memory_ops, compute_ops = [], []
	num_ops = 0
	for op in tqdm(ops, desc='Tiling operations'):
		if isinstance(op, list):
			memory_multihead_ops, compute_multihead_ops = [], []
			for head_op in op:
				memory_head_ops, compute_head_ops = [], []
				if head_op.base_op:
					if head_op.compute_op:
						compute_head_ops.extend(head_op.tile_op() if tile_compute_ops else [head_op])
					else:
						memory_head_ops.extend(head_op.tile_op() if tile_memory_ops else [head_op])
				else:
					head_op.convert_to_base_ops()
					for base_op in head_op.base_ops:
						if base_op.compute_op:
							compute_head_ops.extend(base_op.tile_op() if tile_compute_ops else [base_op])
						else:
							memory_head_ops.extend(base_op.tile_op() if tile_memory_ops else [base_op])
				if memory_head_ops: 
					num_ops += len(memory_head_ops)
					memory_multihead_ops.append(memory_head_ops)
				if compute_head_ops: 
					num_ops += len(compute_head_ops)
					compute_multihead_ops.append(compute_head_ops)
			memory_ops.append(memory_multihead_ops); compute_ops.append(compute_multihead_ops)
		else:
			if op.base_op:
				if op.compute_op:
					new_ops = op.tile_op() if tile_compute_ops else [op]
					num_ops += len(new_ops)
					compute_ops.extend(new_ops)
				else:
					new_ops = op.tile_op() if tile_memory_ops else [op]
					num_ops += len(new_ops)
					memory_ops.extend(new_ops)
			else:
				op.convert_to_base_ops()
				for base_op in op.base_ops:
					if base_op.compute_op:
						new_ops = base_op.tile_op() if tile_compute_ops else [base_op]
						num_ops += len(new_ops)
						compute_ops.extend(new_ops)
					else:
						new_ops = base_op.tile_op() if tile_memory_ops else [base_op]
						num_ops += len(new_ops)
						memory_ops.extend(new_ops)

	if debug:
		print(f'Number of operations: {num_ops}')

	return memory_ops, compute_ops, num_ops


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
	parser.add_argument('--tile_ops',
		dest='tile_ops',
		help='tile software operations',
		action='store_true')
	parser.add_argument('--debug',
		dest='debug',
		help='print debugging statements',
		action='store_true')
	parser.set_defaults(debug=False)
	parser.set_defaults(tile_ops=False)

	args = parser.parse_args()

	if os.path.exists(args.model_dict_path):
		model_dict = json.load(open(args.model_dict_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.model_dict_path}')

	if os.path.exists(args.config_path):
		config = yaml.safe_load(open(args.config_path, 'r'))
	else:
		raise FileNotFoundError(f'Couldn\'t find JSON file for given path: {args.config_path}')

	main(model_dict, config, args.tile_ops, args.debug)
