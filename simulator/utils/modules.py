# Run tiled operations on corresponding hardware modules

import math
from ops import *
from tiled_ops import *

# TODO: make an Accelerator class that takes in a config and instantiates a bunch of modules
class Module(object):
	"""Parent module class
	
	Attributes:
		module_name (str): name of the given module
	    dynamic_power (float): dynamic power consumption in mW
	    leakage_power (float): leakage power consumption in mW
	    area (float): silicon area in um^2
	    process_cycles (int): number of cycles to process an input tile
	    ready (bool): if the module is ready for new input
	"""
	def __init__(self, module_name, dynamic_power, leakage_power, area):
		self.module_name = module_name
		self.dynamic_power = dynamic_power
		self.leakage_power = leakage_power
		self.area = area
		self.process_cycles = None 
		self.ready = True


class MacLane(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area, num_macs, activation_sparsity, weight_sparsity, overlap_factor):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)
		self.num_macs = num_macs
		self.activation_sparsity = activation_sparsity
		self.weight_sparsity = weight_sparsity
		self.overlap_factor = overlap_factor

	def process(self, op):
		# TODO: add activation and weight sparsity
		self.process_cycles = math.ceil(op.num_muls * 1.0 / self.num_macs)
		self.ready = False


class DataFlow(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


class DMA(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area, bandwidth):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)
		self.bandwidth = bandwidth

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


class FIFO(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area, depth):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)
		self.depth = depth

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


class LayerNorm(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area, width):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)
		self.width = width

	def process(self, op):
		# TODO: check cycles based on RTL
		self.process_cycles = math.ceil(sum(op.input_size) * 1.0 / self.width)
		self.ready = False


class Softmax(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area, width):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)
		self.width = width

	def process(self, op):
		# TODO: check cycles based on RTL
		self.process_cycles = math.ceil(sum(op.input_size) * 1.0 / self.width)
		self.ready = False


class PreSparsity(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)

	def process(op):
		self.process_cycles = 1
		self.ready = False


class PostSparsity(Module):
	def __init__(self, module_name, dynamic_power, leakage_power, area):
		Module.__init__(self, module_name, dynamic_power, leakage_power, area)

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


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
	    ddr_bandwidth (int): bandwidth of main memory in MB/s
	    process_cycles (int): Description
	    ready (bool): if the buffer is ready to take more input
	    used (int): amount of buffer currently in use
	    data (list): names of data elements currently in buffer
	"""
	def __init__(self, buffer_type, buffer_size, access_energy, leakage_power, area, activation_sparsity, weight_sparsity, IL, FL, ddr_bandwidth):
		self.buffer_type = buffer_type
		self.buffer_size = buffer_size
		self.access_energy = access_energy
		self.leakage_power = leakage_power
		self.area = area
		self.activation_sparsity = activation_sparsity
		self.weight_sparsity = weight_sparsity
		self.IL = IL
		self.FL = FL
		self.ddr_bandwidth = ddr_bandwidth
		self.process_cycles = 0
		self.ready = True
		self.used = 0
		self.data = []

		if self.buffer_type == 'activation':
			self.weight_factor = (1.0 - self.activation_sparsity)
		elif self.buffer_type == 'weight':
			self.weight_factor = (1.0 - self.weight_sparsity)

	def data_in_buffer(self, op):
		# TODO: change op to data class
		if op.op_name in [data.op_name for data in self.data]:
			return True
		else:
			return False

	def remove_data(self, op):
		self.data = [data for data in self.data if data.op_name != op.op_name]

	def load(self, op):
		if self.data_in_buffer(op):
			while self.used > self.buffer_size:
				# Remove oldest used data
				self.used -= self.data[0].input_size * (self.IL + self.FL) * self.weight_factor
				self.data.remove(self.data[0])
			self.data.append(op)
			self.used += op.input_size * (self.IL + self.FL) * self.weight_factor
			self.process_cycles = op.input_size * (self.IL + self.FL) * self.weight_factor / self.ddr_bandwidth
		else:
			# Latest used data in the end of the list
			self.data.remove(op); self.data.append(op)
			self.process_cycles = 0

	def store(self, op):
		assert self.data_in_buffer(op)
		self.data.used -= op.input_size * (self.IL + self.FL) * self.weight_factor
		self.data.remove(op)
		self.process_cycles = op.input_size * (self.IL + self.FL) * self.weight_factor / self.ddr_bandwidth
		
