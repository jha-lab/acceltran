# Run tiled operations on corresponding hardware modules

import math
import inspect
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

	def process_cycle(self):
		if self.process_cycles is None or self.process_cycles == 0:
			self.ready = True
		else:
			self.process_cycles -= 1
			self.ready = False

		for member in inspect.getmembers(self):
			if isinstance(member, Module):
				member.process_cycle()
				if not member.ready: self.ready = False

		if self.ready and self.assigned_op is not None:
			self.assigned_op.done = True


class Dataflow(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['dataflow']['dynamic'], constants['dataflow']['leakage'], constants['dataflow']['area'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class DMA(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['dma']['dynamic'], constants['dma']['leakage'], constants['dma']['area'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class LayerNorm(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['dynamic'], constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['leakage'], constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['area'])
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = math.ceil(op.input_size[0] * (op.input_size[1] + op.input_size[2]) * (1 - self.activation_sparsity))
		self.ready = False

		self.assigned_op = op


class Softmax(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['dynamic'], constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['leakage'], constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['area'])
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = math.ceil(op.input_size[0] * (op.input_size[2]) * (1 - self.activation_sparsity))
		self.ready = False

		self.assigned_op = op


class Register(Module):
	def __init__(self, module_name, config, constants, depth):
		Module.__init__(self, module_name, constants['register']['dynamic'], constants['register']['leakage'], constants['register']['area'])
		self.depth = depth
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class PreSparsity(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['pre_sparsity']['dynamic'], constants['pre_sparsity']['leakage'], constants['pre_sparsity']['area'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class PostSparsity(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['post_sparsity']['dynamic'], constants['post_sparsity']['leakage'], constants['post_sparsity']['area'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class MACLane(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['dynamic'], constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['leakage'], constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['area'])
		self.num_macs = config['mac_per_lane']
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.overlap_factor = constants['overlap_factor']
		self.assigned_op = None

		self.register = Register(f'{self.module_name}_reg', config, constants, 32)
		self.pre_sparsity = PreSparsity(f'{self.module_name}_pre-s', config, constants)
		self.post_sparsity = PostSparsity(f'{self.module_name}_post-s', config, constants)

	def assign_op(self, op):
		self.process_cycles = math.ceil(op.num_muls * 1.0 / self.num_macs * (1 - self.activation_sparsity))
		self.ready = False

		self.assigned_op = op

		self.register.assign_op(op)
		self.pre_sparsity.assign_op(op)
		self.post_sparsity.assign_op(op)

