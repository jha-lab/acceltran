# Run tiled operations on corresponding hardware modules

import re
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
	def __init__(self, module_name, dynamic_power, leakage_power, area, clock_frequency):
		self.module_name = module_name
		self.dynamic_power = dynamic_power
		self.leakage_power = leakage_power
		self.area = area
		self.clock_frequency = clock_frequency
		self.process_cycles = None 
		self.buffer_energy = 0
		self.ready = True

	def process_cycle(self):
		if self.process_cycles is None or self.process_cycles == 0:
			self.ready = True
		else:
			self.process_cycles -= 1
			self.ready = False

		submodule_dynamic_energy, submodule_leakage_energy = 0, 0

		for member in inspect.getmembers(self):
			if isinstance(member, Module):
				dyn, leak = member.process_cycle()
				submodule_dynamic_energy += dyn; submodule_leakage_energy += leak
				if not member.ready: self.ready = False

		if self.ready and self.assigned_op is not None:
			self.assigned_op.done = True

		if self.ready:
			return (0, 0) # if not used, the module is power-gated resulting in no leakage power
		else:
			return (self.dynamic_power / self.clock_frequency + submodule_dynamic_energy + self.buffer_energy, self.leakage_power / self.clock_frequency + submodule_leakage_energy) # unit: nJ


class Dataflow(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['dataflow']['dynamic'], constants['dataflow']['leakage'], constants['dataflow']['area'], constants['clock_frequency'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class DMA(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['dma']['dynamic'], constants['dma']['leakage'], constants['dma']['area'], constants['clock_frequency'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class LayerNorm(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['dynamic'], constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['leakage'], constants['layer_norm'][f'tile_{config["tile"]["tile_x"]}']['area'], constants['clock_frequency'])
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = math.ceil(op.input_size[0] * (op.input_size[1] + op.input_size[2]) * (1 - self.activation_sparsity))
		self.ready = False

		self.assigned_op = op


class Softmax(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['dynamic'], constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['leakage'], constants['softmax'][f'tile_{config["tile"]["tile_x"]}']['area'], constants['clock_frequency'])
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = math.ceil(op.input_size[0] * (op.input_size[1]) * (1 - self.activation_sparsity))
		self.ready = False

		self.assigned_op = op


class FIFO(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['fifo']['dynamic'], constants['fifo']['leakage'], constants['fifo']['area'], constants['clock_frequency'])
		self.activation_sparsity = constants['sparsity']['activation']
		self.depth = constants['fifo']['depth']
		self.assigned_op = None
		self.b, self.i, self.j, self.k = None, None, None, None
		self.access_energy = constants['activation_buffer']['energy'] * math.sqrt(config['activation_buffer_size'])
		self.block_size = constants['activation_buffer']['block_size']

	def assign_op(self, op):
		self.process_cycles = 0
		self.buffer_energy = 0

		same_prev_op = False
		if self.assigned_op is not None and op.op_name[:op.op_name.find('_b')] == self.assigned_op.op_name[:self.assigned_op.op_name.find('_b')]:
			same_prev_op = True

		# Exploit data re-use
		if isinstance(op, MatrixMultTiledOp):
			b = int(re.search('b([0-9]+)', op.op_name).group()[1:])
			i = int(re.search('i([0-9]+)', op.op_name).group()[1:])
			j = int(re.search('j([0-9]+)', op.op_name).group()[1:])
			k = int(re.search('k([0-9]+)', op.op_name).group()[1:])
			if not (self.b == b and self.i == i and self.k == k) or not same_prev_op:
				self.process_cycles += math.ceil(math.prod(op.input_1_size) * (1 - self.activation_sparsity) / self.depth)
				self.buffer_energy += self.access_energy * math.prod(op.input_1_size) / self.block_size 
			if not (self.b == b and self.k == k and self.j == j) or not same_prev_op:
				self.process_cycles += math.ceil(math.prod(op.input_2_size) * (1 - self.activation_sparsity) / self.depth)
				self.buffer_energy += self.access_energy * math.prod(op.input_2_size) / self.block_size 
			self.b, self.i, self.j, self.k = b, i, j, k
		elif isinstance(op, Conv1DTiledOp):
			b = int(re.search('b([0-9]+)', op.op_name).group()[1:])
			i = int(re.search('i([0-9]+)', op.op_name).group()[1:])
			j = int(re.search('j([0-9]+)', op.op_name).group()[1:])
			if not (self.b == b and self.i == i and self.j == j):
				self.process_cycles += math.ceil(math.prod(op.input_size) * (1 - self.activation_sparsity) / self.depth)
				self.buffer_energy += self.access_energy * math.prod(op.input_size) / self.block_size 
				if not same_prev_op:
					self.process_cycles += math.ceil(op.kernel_size / self.depth)
					self.buffer_energy += self.access_energy * op.kernel_size / self.block_size 
			self.b, self.i, self.j, self.k = b, i, j, None
		else:
			if isinstance(op, (NonLinearityOp, NonLinearityTiledOp, LayerNormOp, LayerNormTiledOp, SoftmaxOp, SoftmaxTiledOp)):
				self.process_cycles += math.ceil(math.prod(op.input_size) * (1 - self.activation_sparsity) / self.depth)
				self.buffer_energy += self.access_energy * math.prod(op.input_size) / self.block_size 
			else:
				self.process_cycles += math.ceil(op.num_muls * (1 - self.activation_sparsity) / self.depth)
				self.buffer_energy += self.access_energy * math.prod(op.num_muls) / self.block_size
			self.b, self.i, self.j, self.k = None, None, None, None

		self.ready = False

		self.buffer_energy = self.buffer_energy / self.process_cycles if self.process_cycles != 0 else 0

		self.assigned_op = op


class PreSparsity(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['pre_sparsity']['dynamic'], constants['pre_sparsity']['leakage'], constants['pre_sparsity']['area'], constants['clock_frequency'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class PostSparsity(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['post_sparsity']['dynamic'], constants['post_sparsity']['leakage'], constants['post_sparsity']['area'], constants['clock_frequency'])
		self.assigned_op = None

	def assign_op(self, op):
		self.process_cycles = 1
		self.ready = False

		self.assigned_op = op


class MACLane(Module):
	def __init__(self, module_name, config, constants):
		Module.__init__(self, module_name, constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['dynamic'], constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['leakage'], constants['lane'][f'mac_per_lane_{config["mac_per_lane"]}'][config['non_linearity']]['area'], constants['clock_frequency'])
		self.num_macs = config['mac_per_lane']
		self.activation_sparsity = constants['sparsity']['activation']
		self.weight_sparsity = constants['sparsity']['weight']
		self.overlap_factor = constants['overlap_factor']
		self.assigned_op = None

		self.fifo = FIFO(f'{self.module_name}_fifo', config, constants)
		self.pre_sparsity = PreSparsity(f'{self.module_name}_pre-s', config, constants)
		self.post_sparsity = PostSparsity(f'{self.module_name}_post-s', config, constants)

	def assign_op(self, op):
		if isinstance(op, (NonLinearityOp, NonLinearityTiledOp)):
			self.process_cycles = 1
		else:
			self.process_cycles = math.ceil(op.num_muls * 1.0 / self.num_macs * (1 - self.activation_sparsity))
		self.ready = False

		self.assigned_op = op

		self.fifo.assign_op(op)
		self.pre_sparsity.assign_op(op)
		self.post_sparsity.assign_op(op)

