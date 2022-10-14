# Buffer class for the Accelerator

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
		self.main_memory_block_size = constants['main_memory']['block_size']
		self.access_energy = constants[f'{buffer_type}_buffer']['energy'] * math.sqrt(config[f'{buffer_type}_buffer_size'])
		self.block_size = constants[f'{buffer_type}_buffer']['block_size']
		self.leakage_power = constants[f'{buffer_type}_buffer']['leakage'] * config[f'{buffer_type}_buffer_size']
		self.area = constants[f'{buffer_type}_buffer']['area'] * config[f'{buffer_type}_buffer_size']
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.IL = constants['bits']['IL']
		self.FL = constants['bits']['FL']
		self.main_memory_bandwidth = constants['main_memory']['bandwidth'][config['main_memory']['mode']]
		self.bandwidth = constants[f'{buffer_type}_buffer']['bandwidth']
		self.clock_frequency = constants['clock_frequency']
		self.process_cycles = 0
		self.ready = True
		self.used = 0
		self.data = []
		self.data_being_added = None
		self.energy_per_cycle = None

		if self.buffer_type == 'activation':
			self.weight_factor = (self.IL + self.FL) * (1.0 - self.activation_sparsity)
		elif self.buffer_type == 'weight':
			self.weight_factor = (self.IL + self.FL) * (1.0 - self.weight_sparsity)
		elif self.buffer_type == 'mask':
			self.weight_factor = 1.0

	def data_in_buffer(self, data):
		if isinstance(data, (Data, TiledData)):
			data_name = data.data_name
		elif type(data) == str:
			data_name = data
		else:
			raise ValueError(f'Input data is not of correct type: {type(data)}')

		if self.data_being_added is not None: 
			data_being_added_name = self.data_being_added[0].data_name
		else:
			data_being_added_name = ''
		if data_name in [d.data_name for d in self.data] and data_name != data_being_added_name:
			return True
		else:
			return False

	def get_data(self, data_name):
		for data in self.data:
			if data.data_name == data_name: return data

		return None

	def remove(self, data):
		self.data = [d for d in self.data if d.data_name != data.data_name]

	def can_store(self, data):
		if self.buffer_size < data.data_size * self.weight_factor:
			raise RuntimeError(f'Data is larger than what the {self.buffer_type} buffer can store')
		elif self.buffer_size - self.used >= data.data_size * self.weight_factor:
			return True
		else:
			self.required_data_size = 0
			for data in self.data:
				if data.required_in_buffer: self.required_data_size += data.data_size
			if self.buffer_size - self.required_data_size * self.weight_factor > data.data_size * self.weight_factor:
				return True
		return False

	def load(self, data):
		assert self.data_being_added == None

		removed_old_data = False
		if self.data_in_buffer(data):
			self.process_cycles = 0
		else:
			for d in self.data:
				if self.used + data.data_size * self.weight_factor <= self.buffer_size:
					break
				elif not d.required_in_buffer: 
					# Remove oldest used data if not required
					self.used -= d.data_size * self.weight_factor
					self.remove(d)
					removed_old_data = True
			assert self.used + data.data_size * self.weight_factor <= self.buffer_size
			self.data.append(data)
			self.data_being_added = (data, 'load')
			self.used += data.data_size * self.weight_factor
			self.process_cycles = math.ceil(data.data_size * self.weight_factor / self.main_memory_bandwidth)
			self.energy_per_cycle = self.main_memory_energy * data.data_size * (1 - self.weight_sparsity) / self.main_memory_block_size / self.process_cycles
			self.ready = False

		return removed_old_data

	def store(self, data):
		assert self.data_being_added == None

		removed_old_data = False
		if self.data_in_buffer(data):
			self.process_cycles = 0
		else:
			if data.overwrite: data.data_size = 0
			for d in self.data:
				if self.used + data.data_size * self.weight_factor <= self.buffer_size:
					break
				elif not d.required_in_buffer: 
					# Remove oldest used data if not required
					self.used -= d.data_size * self.weight_factor
					self.remove(d)
					removed_old_data = True
			assert self.used + data.data_size * self.weight_factor <= self.buffer_size
			self.data.append(data)
			self.data_being_added = (data, 'store')
			self.used += data.data_size * self.weight_factor
			
			self.process_cycles = math.ceil(data.data_size * self.weight_factor / self.bandwidth)
			self.energy_per_cycle = self.access_energy * data.data_size / self.block_size / self.process_cycles
			self.ready = False

		return removed_old_data

	def store_in_main_memory(self, data):
		assert self.data_in_buffer(data)
		self.data.used -= data.data_size * self.weight_factor
		self.data.remove(data)
		self.process_cycles = math.ceil(data.data_size * self.weight_factor / self.bandwidth)

	def process_cycle(self, num_cycles=1):
		if self.process_cycles is None or self.process_cycles == 0:
			self.data_being_added = None
			self.ready = True
			return (0, 0) # if not used, the module is power-gated resulting in no leakage power
		else:
			cycles_done = min(self.process_cycles, num_cycles)
			self.process_cycles = max(self.process_cycles - num_cycles, 0)
			self.ready = True if self.process_cycles == 0 else False
			if self.ready: self.data_being_added = None
			
			assert self.energy_per_cycle is not None
			
			return (cycles_done * self.energy_per_cycle, cycles_done * self.leakage_power / self.clock_frequency) # unit: nJ

