# Run tiled operations on corresponding hardware modules

import math
from ops import *
from tiled_ops import *

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


class Dataflow(Module):
	def __init__(self, module_name, constants):
		Module.__init__(self, module_name, constants['dataflow']['dynamic'], constants['dataflow']['leakage'], constants['dataflow']['area'])

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


class DMA(Module):
	def __init__(self, module_name, constants):
		Module.__init__(self, module_name, constants['dma']['dynamic'], constants['dma']['leakage'], constants['dma']['area'])

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


class LayerNorm(Module):
	def __init__(self, module_name, constants, width=16):
		Module.__init__(self, module_name, constants['layer_norm']['dynamic'], constants['layer_norm']['leakage'], constants['layer_norm']['area'])
		self.width = width

	def process(self, op):
		# TODO: check cycles based on RTL
		self.process_cycles = math.ceil(sum(op.input_size) * 1.0 / self.width)
		self.ready = False


class Softmax(Module):
	def __init__(self, module_name, constants, width=16):
		Module.__init__(self, module_name, constants['softmax']['dynamic'], constants['softmax']['leakage'], constants['softmax']['area'])
		self.width = width

	def process(self, op):
		# TODO: check cycles based on RTL
		self.process_cycles = math.ceil(sum(op.input_size) * 1.0 / self.width)
		self.ready = False


class Register(Module):
	def __init__(self, module_name, constants, depth):
		Module.__init__(self, module_name, constants['register']['dynamic'], constants['register']['leakage'], constants['register']['area'])
		self.depth = depth

	def process(self, op):
		self.process_cycles = 1
		self.ready = False


class PreSparsity(Module):
	def __init__(self, module_name, constants):
		Module.__init__(self, module_name, constants['pre_sparsity']['dynamic'], constants['pre_sparsity']['leakage'], constants['pre_sparsity']['area'])

	def process(op):
		self.process_cycles = 1
		self.ready = False


class PostSparsity(Module):
	def __init__(self, module_name, constants):
		Module.__init__(self, module_name, constants['post_sparsity']['dynamic'], constants['post_sparsity']['leakage'], constants['post_sparsity']['area'])

	def process(self, op):
		self.process_cycles = 1
		self.ready = False

class MACLane(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['dynamic'], constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['leakage'], constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['area'])
		self.num_macs = config['mac_per_lane']
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.overlap_factor = constants['overlap_factor']

		self.register = Register(f'{self.module_name}_reg', constants, 32)
		self.pre_sparsity = PreSparsity(f'{self.module_name}_pre-s', constants)
		self.post_sparsity = PostSparsity(f'{self.module_name}_post-s', constants)

	def process(self, op):
		# TODO: add activation and weight sparsity
		# TODO: add num_muls in corresponding tiled op
		self.process_cycles = math.ceil(op.num_muls * 1.0 / self.num_macs)
		self.ready = False

