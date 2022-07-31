# Run evaluation on the GLUE tasks with dynamic pruning

# Author : Shikhar Tuli

import os
import sys

sys.path.append('../txf_design-space/transformers/src/')
sys.path.append('../txf_design-space/embeddings/')
sys.path.append('../txf_design-space/flexibert/')

import torch
import shlex
import argparse
import re
import json
import numpy as np
from utils.run_glue import main as run_glue

from load_all_glue_datasets import main as load_all_glue_datasets
from datasets import load_dataset, load_metric
from tokenize_glue_datasets import save_dataset
from matplotlib import pyplot as plt

sys.path.append('../txf_design-space/transformers/src/transformers')
from transformers import BertTokenizer
from transformers.models.bert.configuration_bert import BertConfig
from transformers.models.bert.modeling_modular_bert import BertModelModular, BertForMaskedLMModular, BertForSequenceClassificationModular
from transformers.models.bert.modeling_dpbert import DPBertModel, DPBertForMaskedLM, DPBertForSequenceClassification

import logging
#logging.disable(logging.INFO)
#logging.disable(logging.WARNING)


USE_NON_PRUNED = False
PREFIX_CHECKPOINT_DIR = "checkpoint"
GLUE_TASKS = ['cola', 'mnli', 'mrpc', 'qnli', 'qqp', 'rte', 'sst2', 'stsb', 'wnli']


def get_training_args(output_dir, task):

	training_args = f'--model_name_or_path {output_dir} \
		--task_name {task} \
		--do_eval \
		--logging_steps 50 \
		--max_seq_length 512 \
		--overwrite_output_dir \
		--output_dir {output_dir}'

	training_args = shlex.split(training_args)

	return training_args


def get_tokenizer_args(output_dir, task):

	training_args = f'--task_name {task} \
		--do_eval \
		--max_seq_length 512 \
		--output_dir {output_dir}\
		--overwrite_output_dir'

	training_args = shlex.split(training_args)

	return training_args


def main(args):
	"""Dynamic pruning front-end function"""
	assert args.task in GLUE_TASKS, f'GLUE task should be in: {GLUE_TASKS}'
	assert args.task == 'sst2', 'Only the SST2 task is supported right now'

	print(f'Output directory: {args.output_dir}')

	# Load all GLUE datasets
	load_all_glue_datasets()

	if not os.path.exists('./bert-base-uncased/pytorch_model.bin'):
		# Load tokenizer and model
		tokenizer = BertTokenizer.from_pretrained('howey/bert-base-uncased-sst2')
		tokenizer.save_pretrained('./bert-base-uncased/')
		
		# Initialize and save given model
		model = DPBertForSequenceClassification.from_pretrained('howey/bert-base-uncased-sst2')
		model.save_pretrained('./bert-base-uncased/')

	if not os.path.exists('./bert-base-uncased-weight_pruned/pytorch_model.bin'):
		# Load tokenizer and model
		tokenizer = BertTokenizer.from_pretrained('echarlaix/bert-base-uncased-sst2-acc91.1-d37-hybrid')
		tokenizer.save_pretrained('./bert-base-uncased-weight_pruned/')
		
		# Initialize and save given model
		model = DPBertForSequenceClassification.from_pretrained('echarlaix/bert-base-uncased-sst2-acc91.1-d37-hybrid')
		model.save_pretrained('./bert-base-uncased-weight_pruned/')

	os.makedirs(args.output_dir, exist_ok=True)
	results = []

	for pruning_threshold in np.arange(0, args.max_pruning_threshold, 0.005):
		print(f'Running inference with pruning threshold: {pruning_threshold}')
		result = {'pruning_threshold': pruning_threshold}

		# Make new output directory
		output_dir = os.path.join(args.output_dir, f'threshold_p{str(pruning_threshold)[2:]}')

		# Load and save tokenizer
		tokenizer = BertTokenizer.from_pretrained('./bert-base-uncased/' if pruning_threshold == 0 and USE_NON_PRUNED else './bert-base-uncased-weight_pruned')
		tokenizer.save_pretrained(output_dir)

		# Initialize and save given model
		model = DPBertForSequenceClassification.from_pretrained('./bert-base-uncased/' if pruning_threshold == 0 and USE_NON_PRUNED else './bert-base-uncased-weight_pruned')
		model.save_pretrained(output_dir)

		# Load and save new config
		config = BertConfig.from_pretrained('./bert-base-uncased/' if pruning_threshold == 0 and USE_NON_PRUNED else './bert-base-uncased-weight_pruned')
		config.pruning_threshold = pruning_threshold
		config.sparsity_file = os.path.join(output_dir, 'sparsity.json')
		config.save_pretrained(output_dir)

		if os.path.exists(config.sparsity_file): os.remove(config.sparsity_file)

		# Load model and prune weights
		model = DPBertForSequenceClassification.from_pretrained(output_dir)
		if args.prune_weights: 
			if pruning_threshold > 0:
				model.prune_weights()

				sparsity = json.load(open(config.sparsity_file))
				matrix_sizes, num_zeros = 0, 0
				for sp in sparsity:
					num_zeros += sp[0]
					matrix_sizes += sp[1]

				print(f'Resultant weight sparsity: {num_zeros / matrix_sizes : 0.03f}')
				result['weight_sparsity'] = num_zeros / matrix_sizes
			else:
				result['weight_sparsity'] = 0

		# Save (weight-pruned) model
		model.save_pretrained(output_dir)

		if os.path.exists(config.sparsity_file): os.remove(config.sparsity_file)

		# Run evaluation on the SST-2 task
		training_args = get_training_args(output_dir, args.task)
		metrics = run_glue(training_args)
		print(metrics)

		if pruning_threshold > 0:
			sparsity = json.load(open(config.sparsity_file))
			matrix_sizes, num_zeros = 0, 0
			for sp in sparsity:
				num_zeros += sp[0]
				matrix_sizes += sp[1]

			print(f'Resultant activation sparsity: {num_zeros / matrix_sizes : 0.03f}')
			result['activation_sparsity'] = num_zeros / matrix_sizes
		else:
			result['activation_sparsity'] = 0

		result['accuracy'] = metrics['eval_accuracy']

		results.append(result)
		json.dump(results, open(os.path.join(args.output_dir, 'results.json'), 'w+'))

	fig, ax1 = plt.subplots()
	ax1.set_xlabel('Pruning threshold')
	ax1.set_ylabel('Activation sparsity (%)')
	ax1.plot([result['pruning_threshold'] for result in results], [result['activation_sparsity'] * 100 for result in results])
	ax2 = ax1.twinx()
	ax2.set_ylabel('Accuracy on SST-2 task', color='tab:red')
	ax2.plot([result['pruning_threshold'] for result in results], [result['accuracy'] * 100 for result in results], color='tab:red')
	ax2.tick_params(axis='y', labelcolor='tab:red')
	plt.savefig(os.path.join(args.output_dir, 'results.pdf'), bbox_inches='tight')


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description='Input parameters for pretraining',
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--output_dir',
		metavar='',
		type=str,
		default='./bert-base-pruned/',
		help='path where finetuned model and its evaluation are stored')
	parser.add_argument('--task',
		metavar='',
		type=str,
		default='sst2',
		help='GLUE task to test pruning')
	parser.add_argument('--max_pruning_threshold',
		metavar='',
		type=float,
		default=0,
		help='maximum threshold for dynamic pruning')
	parser.add_argument('--prune_weights',
		dest='prune_weights',
		action='store_true')
	parser.set_defaults(prune_weights=False)

	args = parser.parse_args()

	main(args)

