# Run tiled operations on corresponding hardware modules

import os
import sys
import math
import json
import numpy as np
from matplotlib import pyplot as plt
import matplotlib.gridspec as gridspec

from ops import *
from tiled_ops import *
from modules import *
from pe import ProcessingElement
from buffer import Buffer


class Accelerator(object):
	"""Accelerator class
	
	Attributes:
		pes (list): list of ProcessingElement objects
		activation_buffer (Buffer): Buffer class object for activations
		mask_buffer (Buffer): Buffer class object for binary masks
		weight_buffer (Buffer): Buffer class object for weights
	"""
	def __init__(self, config, constants):
		self.config = config
		self.constants = constants

		self.pes = []
		for p in range(config['pe']):
			self.pes.append(ProcessingElement(f'pe{p}', config, constants))

		self.activation_buffer = Buffer('activation', config, constants)
		self.weight_buffer = Buffer('weight', config, constants)
		self.mask_buffer = Buffer('mask', config, constants)

		self.area = 0
		for pe in self.pes:
			self.area += pe.area
		self.area = self.area + self.activation_buffer.area + self.weight_buffer.area + self.mask_buffer.area

		self.cycle = 0
		self.idx_done = 0

		# TODO: add main memory object with its leakage energy

	def set_required(self, compute_op):
		for data_name in compute_op.required_in_buffer:
			if self.activation_buffer.data_in_buffer(data_name):
				self.activation_buffer.get_data(data_name).required_in_buffer = True
			if self.weight_buffer.data_in_buffer(data_name):
				self.weight_buffer.get_data(data_name).required_in_buffer = True
			if self.mask_buffer.data_in_buffer(data_name):
				self.mask_buffer.get_data(data_name).required_in_buffer = True

	def set_not_required(self, compute_op):
		assert compute_op.done is True
		for data_name in compute_op.required_in_buffer:
			if self.activation_buffer.data_in_buffer(data_name):
				self.activation_buffer.get_data(data_name).required_in_buffer = False
			if self.weight_buffer.data_in_buffer(data_name):
				self.weight_buffer.get_data(data_name).required_in_buffer = False
			if self.mask_buffer.data_in_buffer(data_name):
				self.mask_buffer.get_data(data_name).required_in_buffer = False

	def all_resources_free(self):
		for pe in self.pes:
			for mac_lane in pe.mac_lanes:
				if not mac_lane.ready: return False
			for sftm in pe.softmax:
				if not sftm.ready: return False
			if not pe.layer_norm.ready: return False
			
		return True

	def num_mac_lanes_free(self):
		num_mac_lanes, num_free = 0, 0
		for pe in self.pes:
			for mac_lane in pe.mac_lanes:
				num_mac_lanes += 1
				if mac_lane.ready: num_free += 1
		return num_free, num_mac_lanes

	def num_ln_free(self):
		num_ln, num_free = 0, 0
		for pe in self.pes:
			num_ln += 1
			if pe.layer_norm.ready: num_free += 1
		return num_free, num_ln

	def num_sftm_free(self):
		num_sftm, num_free = 0, 0
		for pe in self.pes:
			for sftm in pe.softmax:
				num_sftm += 1
				if sftm.ready: num_free += 1
		return num_free, num_sftm

	def _fill_buffer(self, buffer_arr, num_ones):
		count = 0
		if num_ones > 0:
			for i in range(buffer_arr.shape[0]):
				for j in range(buffer_arr.shape[1]):
					buffer_arr[i, j] = 1
					count += 1
					if count == num_ones: return buffer_arr
		return buffer_arr

	def plot_utilization(self, utilization_dir, debug=False):
		if not os.path.exists(utilization_dir): os.makedirs(utilization_dir)

		accel_dict = {}

		fig = plt.figure()
		buff_grid, pe_grid_sup = gridspec.GridSpec(1, 2, hspace=0, wspace=0.05, width_ratios=[1, 4])
		pe_grid = gridspec.GridSpecFromSubplotSpec(1, 4, subplot_spec=pe_grid_sup, hspace=0, wspace=0)

		activation_buffer_size = int(self.config['activation_buffer_size'] * 16)
		weight_buffer_size = int(self.config['weight_buffer_size'] * 16)
		mask_buffer_size = int(self.config['mask_buffer_size'] * 16)

		act_buff, weight_buff, mask_buff = gridspec.GridSpecFromSubplotSpec(3, 1, 
			subplot_spec=buff_grid, hspace=0, wspace=0, height_ratios=[activation_buffer_size, weight_buffer_size, mask_buffer_size])

		num_ones = math.ceil(self.activation_buffer.used * 1.0 / self.activation_buffer.buffer_size * activation_buffer_size * 16)
		act_arr = np.zeros((activation_buffer_size, 16))
		act_arr = self._fill_buffer(act_arr, num_ones)

		accel_dict['activation_buffer_arr'] = act_arr.tolist()

		if debug: print(f'Activation buffer used: {self.activation_buffer.used * 100.0 / self.activation_buffer.buffer_size : 0.03f}%')

		act_ax = plt.Subplot(fig, act_buff)
		act_ax.imshow(act_arr, interpolation='none', aspect='auto', 
						  rasterized=True, cmap='Greys', vmin=0, vmax=1.5)
		act_ax.set_xticks([])
		act_ax.set_yticks([])
		fig.add_subplot(act_ax)

		num_ones = math.ceil(self.weight_buffer.used * 1.0 / self.weight_buffer.buffer_size * weight_buffer_size * 16)
		weight_arr = np.zeros((weight_buffer_size, 16))
		weight_arr = self._fill_buffer(weight_arr, num_ones)

		accel_dict['weight_buffer'] = weight_arr.tolist()

		if debug: print(f'Weight buffer used: {self.weight_buffer.used * 100.0 / self.weight_buffer.buffer_size : 0.03f}%')

		weight_ax = plt.Subplot(fig, weight_buff)
		weight_ax.imshow(weight_arr, interpolation='none', aspect='auto', 
						  rasterized=True, cmap='Greys', vmin=0, vmax=1.5)
		weight_ax.set_xticks([])
		weight_ax.set_yticks([])
		fig.add_subplot(weight_ax)

		num_ones = math.ceil(self.mask_buffer.used * 1.0 / self.mask_buffer.buffer_size * mask_buffer_size * 16)
		mask_arr = np.zeros((mask_buffer_size, 16))
		mask_arr = self._fill_buffer(mask_arr, num_ones)

		accel_dict['mask_buffer'] = mask_arr.tolist()

		if debug: print(f'Mask buffer used: {self.mask_buffer.used * 100.0 / self.mask_buffer.buffer_size : 0.03f}%')

		mask_ax = plt.Subplot(fig, mask_buff)
		mask_ax.imshow(mask_arr, interpolation='none', aspect='auto', 
						  rasterized=True, cmap='Greys', vmin=0, vmax=1.5)
		mask_ax.set_xticks([])
		mask_ax.set_yticks([])
		fig.add_subplot(mask_ax)

		mac_lanes_used, pe_count = 0, 0
		for pe_col in pe_grid:
			pes = gridspec.GridSpecFromSubplotSpec(len(self.pes)//4, 1, wspace=0, hspace=0,
				subplot_spec=pe_col)
			for pe in pes:
				height_ratios = [1, 1, 1] if self.config['lanes_per_pe'] < 8 else [2, 1, 1]
				mac_lanes_spec, sftm_spec, ln_spec = gridspec.GridSpecFromSubplotSpec(3, 1, wspace=0, hspace=0, 
					height_ratios=height_ratios, subplot_spec=pe)

				mac_lane_size = (1, len(self.pes[pe_count].mac_lanes)) if self.config['lanes_per_pe'] < 8 else (2, len(self.pes[pe_count].mac_lanes)//2)
				mac_lane_arr = np.zeros(mac_lane_size)
				mac_lane_count = 0
				for i in range(mac_lane_arr.shape[0]):
					for j in range(mac_lane_arr.shape[1]):
						mac_lane_arr[i, j] = 1 if not self.pes[pe_count].mac_lanes[mac_lane_count].ready else 0
						mac_lanes_used += mac_lane_arr[i, j]
						mac_lane_count += 1
				
				ax = plt.Subplot(fig, mac_lanes_spec)
				ax.imshow(mac_lane_arr, interpolation='none', aspect='auto', 
						  rasterized=True, cmap='Blues', vmin=0, vmax=1.5)
				ax.set_xticks(np.arange(-0.5, mac_lane_size[1], 1))
				ax.set_yticks(np.arange(-0.5, mac_lane_size[0], 1))
				ax.set_xticklabels([])
				ax.set_yticklabels([])
				ax.tick_params(axis=u'both', which=u'both',length=0)
				ax.grid(color='k', linewidth=0.5)
				fig.add_subplot(ax)

				sftm_arr = np.zeros((1, len(self.pes[pe_count].softmax)))
				sftm_count = 0
				for i in range(sftm_arr.shape[1]):
					sftm_arr[0, i] = 1 if not self.pes[pe_count].softmax[sftm_count].ready else 0
					sftm_count += 1

				ax = plt.Subplot(fig, sftm_spec)
				ax.imshow(sftm_arr, interpolation='none', aspect='auto', 
						  rasterized=True, cmap='Greens', vmin=0, vmax=1.5)
				ax.set_xticks(np.arange(-0.5, len(self.pes[pe_count].softmax), 1))
				ax.set_yticks(np.arange(-0.5, 1, 1))
				ax.set_xticklabels([])
				ax.set_yticklabels([])
				ax.tick_params(axis=u'both', which=u'both',length=0)
				ax.grid(color='k', linewidth=0.5)
				fig.add_subplot(ax)
				
				ln_arr = np.zeros((1, 1))
				ln_arr[0][0] = 1 if not self.pes[pe_count].layer_norm.ready else 0

				ax = plt.Subplot(fig, ln_spec)
				ax.imshow(ln_arr, interpolation='none', aspect='auto', 
						  rasterized=True, cmap='Purples', vmin=0, vmax=1.5)
				ax.set_xticks([])
				ax.set_yticks([])
				fig.add_subplot(ax)

				accel_dict[f'pe_{pe_count + 1}'] = {'mac_lanes': mac_lane_arr.tolist(), 'layer_norm': ln_arr.tolist(), 'softmax': sftm_arr.tolist()}

				pe_count += 1

		if debug: print(f'MAC Lanes used: {mac_lanes_used * 100.0 / len(self.pes) / len(self.pes[0].mac_lanes) : 0.03f}%')

		json.dump(accel_dict, open(os.path.join(utilization_dir, f'cycle_{self.cycle}.json'), 'w+'))

		fig.subplots_adjust(wspace=0, hspace=0)
		fig.suptitle(f'Cycle: {self.cycle}')
		plt.savefig(os.path.join(utilization_dir, f'cycle_{self.cycle}.pdf'), bbox_inches='tight', dpi=300)
		plt.close()

	def process_cycle(self, memory_ops, compute_ops, ops_to_set_required):
		total_pe_energy = [0, 0]
		for pe in self.pes:
			pe_energy = pe.process_cycle()
			total_pe_energy[0] += pe_energy[0]; total_pe_energy[1] += pe_energy[1]

		activation_buffer_energy = self.activation_buffer.process_cycle()
		weight_buffer_energy = self.weight_buffer.process_cycle()
		mask_buffer_energy = self.mask_buffer.process_cycle()

		# If a compute_op is done, its corresponding data is not required in buffer anymore
		for idx, compute_op in enumerate(compute_ops):
			if idx < self.idx_done:
				continue
			if type(compute_op) == list:
				for head_ops in compute_op:
					for head_idx, head_op in enumerate(head_ops):
						if head_op.done == True: 
							self.set_not_required(head_op)
						else:
							break
			else:
				if compute_op.done == True:
					self.set_not_required(compute_op)
					self.idx_done = idx
				else:
					break

		for op in ops_to_set_required:
			if type(op) == list:
				for head_op in op:
					self.set_required(head_op)
			elif op is not None:
				self.set_required(op)

		# All energy in nJ
		return tuple(total_pe_energy), activation_buffer_energy, weight_buffer_energy, mask_buffer_energy

	def can_assign(self, op_list):
		assert type(op_list) == list

		num_mac_lanes_free, num_mac_lanes = self.num_mac_lanes_free()
		num_ln_free, num_ln = self.num_ln_free()
		num_sftm_free, num_sftm = self.num_sftm_free()

		num_mac_lanes_to_assign, num_ln_to_assign, num_sftm_to_assign = 0, 0, 0

		for op in op_list:
			assert op.compute_op is True
			if isinstance(op, (MatrixMultOp, MatrixMultTiledOp, Conv1DOp, Conv1DTiledOp, NonLinearityOp, NonLinearityTiledOp)):
				num_mac_lanes_to_assign += 1
			elif isinstance(op, (LayerNormOp, LayerNormTiledOp)):
				num_ln_to_assign += 1
			elif isinstance(op, (SoftmaxOp, SoftmaxTiledOp)):
				num_sftm_to_assign += 1

		if num_mac_lanes_free < num_mac_lanes_to_assign or num_ln_free < num_ln_to_assign or num_sftm_free < num_sftm_to_assign:
			return False

		return True


	def assign_op(self, op):
		assert op.compute_op is True
		assigned_op = False

		for pe in self.pes:
			assigned_op = pe.assign_op(op)
			if assigned_op == True: break

		return assigned_op

