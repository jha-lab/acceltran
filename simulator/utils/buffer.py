# Run tiled operations on corresponding hardware modules

import math
from ops import *
from tiled_ops import *
from modules import *


class Buffer(object):
	"""Buffer class
	
	Attributes:
		buffer_type (str): type of buffer in ['activation', 'weight', 'mask']
		buffer_size (float): size of buffer in MBs
	    access_energy (float): energy per access from the main memory in nJ
	    leakage_power (float): leakage power consumption
	    area (float): buffer areat in um^2
	    activation_sparsity (float): sparsity in activations
	    weight_sparsity (float): sparsity in weights
	    IL (int): number of bits for the integer part
	    FL (int): number of bits for the fractional part
	    bandwidth (int): bandwidth of main memory in MB/s
	    process_cycles (int): Description
	    ready (bool): if the buffer is ready to take more input
	    used (int): amount of buffer currently in use
	    data (list): names of data elements currently in buffer
	"""
	def __init__(self, buffer_type, config, constants):
		self.buffer_type = buffer_type
		self.buffer_size = config[f'{buffer_type}_buffer_size'] * 1024 * 1024 * 8
		self.main_memory_energy = constants['main_memory']['energy'][f'{config["main_memory"]["type"]}_{config["main_memory"]["banks"]}_{config["main_memory"]["ranks"]}_{config["main_memory"]["channels"]}']
		self.access_energy = constants[f'{buffer_type}_buffer']['energy']
		self.leakage_power = constants[f'{buffer_type}_buffer']['leakage']
		self.area = onstants[f'{buffer_type}_buffer']['area']
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.IL = config['bits']['IL']
		self.FL = config['bits']['FL']
		self.bandwidth = constants['main_memory']['bandwidth']
		self.process_cycles = 0
		self.ready = True
		self.used = 0
		self.data = []

		if self.buffer_type == 'activation':
			self.weight_factor = (1.0 - self.activation_sparsity)
		elif self.buffer_type == 'weight':
			self.weight_factor = (1.0 - self.weight_sparsity)

	def data_in_buffer(self, data):
		if data.data_name in [d.data_name for d in self.data]:
			return True
		else:
			return False

	def remove_data(self, data):
		self.data = [d for d in self.data if d.data_name != data.data_name]

	def load(self, data):
		if self.data_in_buffer(data):
			while self.used > self.buffer_size:
				# Remove oldest used data
				self.used -= self.data[0].data_size * (self.IL + self.FL) * self.weight_factor
				self.data.remove(self.data[0])
			self.data.append(data)
			self.used += data.data_size * (self.IL + self.FL) * self.weight_factor
			self.process_cycles = data.data_size * (self.IL + self.FL) * self.weight_factor / self.bandwidth
		else:
			# Latest used data in the end of the list
			self.data.remove(data); self.data.append(data)
			self.process_cycles = 0

	def store(self, data):
		assert self.data_in_buffer(data)
		self.data.used -= data.data_size * (self.IL + self.FL) * self.weight_factor
		self.data.remove(data)
		self.process_cycles = data.data_size * (self.IL + self.FL) * self.weight_factor / self.bandwidth

