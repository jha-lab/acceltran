# Run tiled operations on corresponding hardware modules

import math
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
		self.pes = []
		for p in range(config['pe']):
			self.pes.append(ProcessingElement(f'pe{p}', config, constants))

		self.activation_buffer = Buffer('activation', config, constants)
		self.weight_buffer = Buffer('weight', config, constants)
		self.mask_buffer = Buffer('mask', config, constants)

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

	def all_macs_free(self):
		for pe in self.pes:
			for mac_lane in pe.mac_lanes:
				if not mac_lane.ready: return False
		return True

	def process_cycle(self, memory_ops, compute_ops):
		for pe in self.pes:
			pe.process_cycle()

		self.activation_buffer.process_cycle()
		self.weight_buffer.process_cycle()
		self.mask_buffer.process_cycle()

		# Mark operations as done if their corresponding modules are ready
		activation_memory_ops = [op for op in memory_ops if op.data_type == 'activation']
		weight_memory_ops = [op for op in memory_ops if op.data_type == 'weight']
		if self.activation_buffer.ready:
			for memory_op in activation_memory_ops:
				if memory_op.done == False:
					memory_op.done = True
					break
		if self.weight_buffer.ready:
			for memory_op in weight_memory_ops:
				if memory_op.done == False:
					memory_op.done = True
					break

		# If a compute_op is done, its corresponding data is not required in buffer anymore
		for compute_op in compute_ops:
			if compute_op.done == True:
				self.set_not_required(compute_op)
			else:
				break

	def assign_op(self, op):
		assert op.compute_op is True
		assigned_op = False

		for pe in self.pes:
			assigned_op = pe.assign_op(op)
			if assigned_op == True: break

		return assigned_op

