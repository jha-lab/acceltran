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
import math
import numpy as np
from utils.run_glue import main as run_glue
from utils.run_squad import main as run_squad
from utils import run_squad_legacy
import time
import platform

from load_all_glue_datasets import main as load_all_glue_datasets
from datasets import load_dataset, load_metric
from tokenize_glue_datasets import save_dataset
from matplotlib import pyplot as plt

sys.path.append('../txf_design-space/transformers/src/transformers')
from transformers import BertTokenizer
from transformers.models.bert.configuration_bert import BertConfig
from transformers.models.bert.modeling_modular_bert import BertModelModular, BertForMaskedLMModular, BertForSequenceClassificationModular
from transformers.models.bert.modeling_dpbert import DPBertModel, DPBertForMaskedLM, DPBertForSequenceClassification, DPBertForQuestionAnswering

import logging
#logging.disable(logging.INFO)
#logging.disable(logging.WARNING)


USE_NON_PRUNED = True
PREFIX_CHECKPOINT_DIR = "checkpoint"
GLUE_TASKS = ['cola', 'mnli', 'mrpc', 'qnli', 'qqp', 'rte', 'sst2', 'stsb', 'wnli']
MAX_K = {'sst2': 512, 'squad_v2': 384}


def get_training_args(output_dir, task, throughput_test=None):
	if throughput_test is not None:
		if throughput_test == 'cpu':
			training_args = f'--model_name_or_path {output_dir} \
				--task_name sst2 \
				--do_eval \
				--logging_steps 50 \
				--max_seq_length 512 \
				--overwrite_output_dir \
				--per_device_eval_batch_size 64 \
				--max_val_samples 256 \
				--no_cuda \
				--output_dir {output_dir}'
		else:
			training_args = f'--model_name_or_path {output_dir} \
			--task_name sst2 \
			--do_eval \
			--logging_steps 50 \
			--max_seq_length 512 \
			--overwrite_output_dir \
			--per_device_eval_batch_size 64 \
			--max_val_samples 256 \
			--output_dir {output_dir}'
	elif task == 'sst2':
		training_args = f'--model_name_or_path {output_dir} \
			--task_name sst2 \
			--do_eval \
			--logging_steps 50 \
			--max_seq_length 512 \
			--overwrite_output_dir \
			--per_device_eval_batch_size 64 \
			--output_dir {output_dir}'
	elif task == 'squad_v2':
		training_args = f'--model_name_or_path {output_dir} \
			--dataset_name squad_v2 \
			--version_2_with_negative \
			--do_eval \
			--logging_steps 50 \
			--max_seq_length 384 \
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
	assert args.task in ['sst2', 'squad_v2'], 'Only the SST2 and SQuAD v2 tasks are supported right now'
	assert args.model_name in ['bert-tiny', 'bert-base'], 'Only BERT-Tiny and BERT-Base are supported right now'

	# Load all GLUE datasets
	load_all_glue_datasets()

	if args.task == 'sst2':
		if args.model_name == 'bert-base':
			if not os.path.exists('./models/bert-base-sst2/pytorch_model.bin'):
				# Load tokenizer and model
				tokenizer = BertTokenizer.from_pretrained('howey/bert-base-uncased-sst2')
				tokenizer.save_pretrained('./models/bert-base-sst2/')
				
				# Initialize and save given model
				model = DPBertForSequenceClassification.from_pretrained('howey/bert-base-uncased-sst2')
				model.save_pretrained('./models/bert-base-sst2/')
			tokenizer = BertTokenizer.from_pretrained('./models/bert-base-sst2/')
			model = DPBertForSequenceClassification.from_pretrained('./models/bert-base-sst2/')
			if not os.path.exists('./models/bert-base-sst2-weight_pruned/pytorch_model.bin'):
				# Load tokenizer and model
				tokenizer = BertTokenizer.from_pretrained('echarlaix/bert-base-uncased-sst2-acc91.1-d37-hybrid')
				tokenizer.save_pretrained('./models/bert-base-sst2-weight_pruned/')
				
				# Initialize and save given model
				model = DPBertForSequenceClassification.from_pretrained('echarlaix/bert-base-uncased-sst2-acc91.1-d37-hybrid')
				model.save_pretrained('./models/bert-base-sst2-weight_pruned/')
			tokenizer_wp = BertTokenizer.from_pretrained('./models/bert-base-sst2-weight_pruned/')
			model_wp = DPBertForSequenceClassification.from_pretrained('./models/bert-base-sst2-weight_pruned/')
		elif args.model_name == 'bert-tiny':
			if not os.path.exists('./models/bert-tiny-sst2/pytorch_model.bin'):
				# Load tokenizer and model
				tokenizer = BertTokenizer.from_pretrained('philschmid/tiny-bert-sst2-distilled')
				tokenizer.save_pretrained('./models/bert-tiny-sst2/')
				
				# Initialize and save given model
				model = DPBertForSequenceClassification.from_pretrained('philschmid/tiny-bert-sst2-distilled')
				model.save_pretrained('./models/bert-tiny-sst2/')
			tokenizer = BertTokenizer.from_pretrained('./models/bert-tiny-sst2/')
			model = DPBertForSequenceClassification.from_pretrained('./models/bert-tiny-sst2/')
	elif args.task == 'squad_v2':
		if args.model_name == 'bert-base':
			if not os.path.exists('./models/bert-base-squad_v2/pytorch_model.bin'):
				# Load tokenizer and model
				tokenizer = BertTokenizer.from_pretrained('deepset/bert-base-uncased-squad2')
				tokenizer.save_pretrained('./models/bert-base-squad_v2/')
				
				# Initialize and save given model
				model = DPBertForQuestionAnswering.from_pretrained('deepset/bert-base-uncased-squad2')
				model.save_pretrained('./models/bert-base-squad_v2/')
			tokenizer = BertTokenizer.from_pretrained('./models/bert-base-squad_v2/')
			model = DPBertForQuestionAnswering.from_pretrained('./models/bert-base-squad_v2/')
		elif args.model_name == 'bert-tiny':
			if not os.path.exists('./models/bert-tiny-squad_v2/pytorch_model.bin'):
				# Load tokenizer and model
				tokenizer = BertTokenizer.from_pretrained('mrm8488/bert-tiny-finetuned-squadv2')
				tokenizer.save_pretrained('./models/bert-tiny-squad_v2/')
				
				# Initialize and save given model
				model = DPBertForQuestionAnswering.from_pretrained('mrm8488/bert-tiny-finetuned-squadv2')
				model.save_pretrained('./models/bert-tiny-squad_v2/')
			tokenizer = BertTokenizer.from_pretrained('./models/bert-tiny-squad_v2/')
			model = DPBertForQuestionAnswering.from_pretrained('./models/bert-tiny-squad_v2/')

	if args.throughput_test is not None:
		assert args.task == 'sst2', 'Only SST-2 task supported for throughput test'

		output_dir = f'./results/throughput/{args.model_name}_{args.throughput_test}'
		os.makedirs(output_dir, exist_ok=True)

		# Set p and k for 30% activation sparsity
		cases = [(0.01, 512), (0, 16)]

		results = []
		if os.path.exists(os.path.join(output_dir, 'results.json')):
			results = json.load(open(os.path.join(output_dir, 'results.json')))

		for p, k in cases:
			print(f'Running inference with pruning threshold: {p}, and \'k\': {k}')
			result = {'pruning_threshold': p, 'k': k}

			# Make new output directory
			temp_dir = os.path.join(output_dir, f'threshold_p{str(p)[2:]}_k{int(k)}')
			if p in [result['pruning_threshold'] for result in results] and k in [result['k'] for result in results]:
				print(f'Results already stored')
				continue

			# Load and save tokenizer
			temp_tokenizer = tokenizer
			if args.model_name == 'bert-base' and not USE_NON_PRUNED:
				temp_tokenizer = tokenizer_wp
			temp_tokenizer.save_pretrained(temp_dir)

			# Initialize and save given model
			temp_model = model
			if args.model_name == 'bert-base' and not USE_NON_PRUNED:
				temp_model = model_wp
			temp_model.save_pretrained(temp_dir)

			# Load and save new config
			config = BertConfig.from_pretrained(temp_dir)
			config.pruning_threshold = p
			config.k = k
			config.sparsity_file = None
			config.save_pretrained(temp_dir)

			# Load model
			temp_model = DPBertForSequenceClassification.from_pretrained(temp_dir)

			# Run evaluation on the SST-2 task or the SQuAD task
			training_args = get_training_args(temp_dir, args.task, args.throughput_test)
			start_time = time.time()
			metrics = run_glue(training_args)
			end_time = time.time()
			print(metrics)

			result['throughput'] = 256 / (end_time - start_time)
			print(f'Throughput: {256 / (end_time - start_time)} seq/sec')

			results.append(result)
			json.dump(results, open(os.path.join(output_dir, 'results.json'), 'w+'))

		return


	output_dir = os.path.join('./results/' if USE_NON_PRUNED else './results/nn_pruning/', f'{args.model_name}_{args.task}_{"dp" if args.max_pruning_threshold > 0 else "top-k"}{"_wp" if args.prune_weights else ""}')

	print(f'Output directory: {output_dir}')

	os.makedirs(output_dir, exist_ok=True)
	results = []
	if os.path.exists(os.path.join(output_dir, 'results.json')):
		results = json.load(open(os.path.join(output_dir, 'results.json')))

	if args.min_k > MAX_K[args.task]: args.min_k = MAX_K[args.task]

	if args.min_k < MAX_K[args.task] and args.max_pruning_threshold == 0:
		logk = math.log(args.min_k, 2)
		ks = list(np.logspace(logk, 9, num=10, base=2))
		pruning_thresholds = [0 for _ in range(len(ks))]
	elif args.max_pruning_threshold > 0 and args.min_k == MAX_K[args.task]:
		pruning_thresholds = list(np.arange(0, args.max_pruning_threshold, 0.005))
		ks = [MAX_K[args.task] for _ in range(len(pruning_thresholds))]
	else:
		raise ValueError(f'Either min_k has to be {MAX_K[args.task]} or max_pruning_threshold has to be zero')

	for p, k in zip(pruning_thresholds, ks):
		print(f'Running inference with pruning threshold: {p}, and \'k\': {k}')
		result = {'pruning_threshold': p, 'k': k}

		# Make new output directory
		temp_dir = os.path.join(output_dir, f'threshold_p{str(p)[2:]}_k{int(k)}')
		if p in [result['pruning_threshold'] for result in results] and k in [result['k'] for result in results]:
			print(f'Results already stored')
			continue

		# Load and save tokenizer
		temp_tokenizer = tokenizer
		if args.task == 'sst2' and args.model_name == 'bert-base' and not USE_NON_PRUNED:
			temp_tokenizer = tokenizer_wp
		temp_tokenizer.save_pretrained(temp_dir)

		# Initialize and save given model
		temp_model = model
		if args.task == 'sst2' and args.model_name == 'bert-base' and not USE_NON_PRUNED:
			temp_model = model_wp
		temp_model.save_pretrained(temp_dir)

		# Load and save new config
		config = BertConfig.from_pretrained(temp_dir)
		config.pruning_threshold = p
		config.k = k
		config.sparsity_file = os.path.join(temp_dir, 'sparsity.json')
		config.save_pretrained(temp_dir)

		if os.path.exists(config.sparsity_file): os.remove(config.sparsity_file)

		# Load model and prune weights
		if args.prune_weights: 
			assert k == MAX_K[args.task], f'Weight pruning not supported in top-k pruning'

			# Do weight pruning with fixed threshold
			config.pruning_threshold = 0.025
			config.save_pretrained(temp_dir)

			if args.task == 'sst2':
				temp_model = DPBertForSequenceClassification.from_pretrained(temp_dir)
			else:
				temp_model = DPBertForQuestionAnswering.from_pretrained(temp_dir)

			if config.pruning_threshold > 0:
				temp_model.prune_weights()

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
		temp_model.save_pretrained(temp_dir)

		# Update config
		config.pruning_threshold = p
		config.save_pretrained(temp_dir)

		# Load model
		if args.task == 'sst2':
			temp_model = DPBertForSequenceClassification.from_pretrained(temp_dir)
		else:
			temp_model = DPBertForQuestionAnswering.from_pretrained(temp_dir)

		if os.path.exists(config.sparsity_file): 
			os.rename(config.sparsity_file, os.path.join(temp_dir, 'weight_sparsity.json'))

		# Run evaluation on the SST-2 task or the SQuAD task
		training_args = get_training_args(temp_dir, args.task)
		metrics = run_glue(training_args) if args.task == 'sst2' else run_squad_legacy.evaluate(training_args, temp_model, tokenizer)
		print(metrics)

		if p > 0 or k < MAX_K[args.task]:
			sparsity = json.load(open(config.sparsity_file))
			matrix_sizes, num_zeros = 0, 0
			for sp in sparsity:
				num_zeros += sp[0]
				matrix_sizes += sp[1]

			print(f'Resultant activation sparsity: {num_zeros / matrix_sizes : 0.03f}')
			result['activation_sparsity'] = num_zeros / matrix_sizes
		else:
			result['activation_sparsity'] = 0

		if args.task == 'sst2':
			result['accuracy'] = metrics['eval_accuracy'] 
		else:
			result['f1'] = metrics['f1']

		results.append(result)
		json.dump(results, open(os.path.join(output_dir, 'results.json'), 'w+'))

	fig, ax1 = plt.subplots()
	ax2 = ax1.twinx()
	ax1.set_ylabel('Accuracy on SST-2 task (%)' if args.task == 'sst2' else 'F1 Score on SQuAD-v2', color='k')
	metric = 'accuracy' if args.task == 'sst2' else 'f1'
	mult = 100.0 if args.task == 'sst2' else 1.0
	ax1.plot([result['pruning_threshold' if args.max_pruning_threshold > 0 else 'k'] for result in results], [result[metric] * mult for result in results], color='k')
	
	ax2.set_xlabel('Pruning threshold' if args.max_pruning_threshold > 0 else 'Top "k"')
	ax2.set_ylabel('Activation sparsity (%)')
	ax2.tick_params(axis='y', labelcolor='tab:red')
	ax2.plot([result['pruning_threshold' if args.max_pruning_threshold > 0 else 'k'] for result in results], [result['activation_sparsity'] * 100 for result in results], color='tab:red')

	if args.min_k < MAX_K[args.task]:
		ax1.set_xscale('log', basex=2); ax2.set_xscale('log', basex=2)
		ax1.set_xticks([1, 2, 4, 8, 16, 32, 64, 128, 256, 512])
		ax1.set_xticklabels([1, 2, 4, 8, 16, 32, 64, 128, 256, 512])
	plt.savefig(os.path.join(output_dir, 'results.pdf'), bbox_inches='tight')


if __name__ == '__main__':
	parser = argparse.ArgumentParser(
		description='Input parameters for pretraining',
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--task',
		metavar='',
		type=str,
		default='sst2',
		help='Task to test pruning')
	parser.add_argument('--model_name',
		metavar='',
		type=str,
		default='bert-base',
		help='BERT model')
	parser.add_argument('--max_pruning_threshold',
		metavar='',
		type=float,
		default=0,
		help='maximum threshold for dynamic pruning')
	parser.add_argument('--min_k',
		metavar='',
		type=float,
		default=512,
		help='maximum \'k\' in top-k pruning')
	parser.add_argument('--prune_weights',
		dest='prune_weights',
		action='store_true',
		help='to prune weights of the model')
	parser.add_argument('--throughput_test',
		metavar='',
		type=str,
		default=None,
		help='target platform for throughput test (overrides other flags)')
	parser.set_defaults(prune_weights=False)

	args = parser.parse_args()

	main(args)

