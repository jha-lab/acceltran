# Software operations in the Transformer architecture

import math
from tiled_ops import *


class Op(object):
	"""Class for a generic Transformer operation"""
	def __init__(self, op_name, config):
		self.name = op_name
		self.config = config
		self.base_op = False
		self.done = False

	def transpose_size(self, matrix_size):
		return (matrix_size[0], matrix_size[2], matrix_size[1])

# TODO: check if we need a MemoryStoreOp
class MemoryLoadOp(Op):
	"""Memory load base operation
	
	Attributes:
		input_size (tuple): size of the input matrix to be loaded
		data_type (str): type of data to fetch in ['activation', 'weight']
	"""
	def __init__(self, op_name, config, input_size, data_type):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.data_type = data_type
		self.base_op = True

	def tile_op(self):
		"""Tile a memory load operation
		
		Returns:
		    self.tiled_ops (list): list of MemoryLoadTiledOps
		"""
		self.tiled_ops = [MemoryLoadTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', (self.config['tile_x'], self.config['tile_y'])) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile_y']))]

		return self.tiled_ops


class MatrixMultOp(Op):
    """Matrix multiplication base operation

	Attributes:
		input_1_size (tuple): size of the input_1 matrix
		input_2_size (tuple): size of the input_2 matrix
    """
    def __init__(self, op_name, input_1_size, input_2_size):
		Op.__init__(self, op_name)
		self.input_1_size = input_1_size
		self.input_2_size = input_2_size
		self.base_op = True

		self.check_input_sizes()

	def check_input_sizes(self):
		"""Check if input matrices can be multiplied
		
		Raises:
		    ValueError: if input matrices can't be multiplied
		"""
		if self.input_1_size[0] != self.input_2_size[0] or self.input_1_size[2] != self.input_2_size[1]:
			raise ValueError(f'Input matrices of sizes: {self.input_1_size} and {self.input_2_size} can\'t be multiplied')

	def output_size(self):
		"""Get the size of the output matrix
		
		Returns:
		    output_size (tuple): size of the output matrix
		"""
		return (self.input_1_size[0], self.input_1_size[1], self.input_2_size[2])

	def tile_op(self):
		"""Implement tiled matrix multiplication

		Returns:
			self.tiled_ops (list): list of MatrixMultTiledOps
		"""
		num_tiles_b = math.ceil(self.input_1_size[0] * 1.0 / self.config['tile_b'])
		num_tiles_1_x = math.ceil(self.input_1_size[1] * 1.0 / self.config['tile_x'])
		num_tiles_1_y = math.ceil(self.input_1_size[2] * 1.0 / self.config['tile_y'])
		num_tiles_2_x = math.ceil(self.input_2_size[1] * 1.0 / self.config['tile_x'])
		num_tiles_2_y = math.ceil(self.input_2_size[2] * 1.0 / self.config['tile_y'])

		assert num_tiled_1_y == num_tiles_2_x

		tile_size = (self.config['tile_b'], self.config['tile_x'], self.config['tile_y'])

		self.tiled_ops = []
		for b in range(num_tiles_b):
			for i in range(num_tiles_1_x):
				for j in range(num_tiles_2_y):
					for k in range(num_tiles_2_x):
						op_name = f'{self.op_name}_b{b}_i{i}_j{j}_k{k}'
						self.tiled_ops.append(MatrixMultTiledOp(op_name, tile_size, tile_size))

		return self.tiled_ops


class Conv1DOp(Op):
    """1D convolution base operation

	Attributes:
		input_size (tuple): size of the input matrix
		kernel_size (tuple): size of the convolutional kernel
    """
    def __init__(self, op_name, input_size, kernel_size):
		Op.__init__(self, op_name)
		self.input_size = input_size
		self.kernel_size = kernel_size
		self.base_op = True

	def tile_op(self):
		"""Implement tiled convolution operation (neglect halos)

		Returns:
			self.tiled_ops (list): list of Conv1DTiledOps
		"""
		num_tiles_b = math.ceil(self.input_size[0] * 1.0 / self.config['tile_b'])
		num_tiles_x = math.ceil(self.input_size[1] * 1.0 / self.config['tile_x'])
		num_tiles_y = math.ceil(self.input_size[2] * 1.0 / self.config['tile_y'])

		tile_size = (self.config['tile_b'], self.config['tile_x'], self.config['tile_y'])
		kernel_size = (self.config['tile_b'], self.kernel_size, self.config['tile_y'])

		self.tiled_ops = []
		for b in range(num_tiles_b):
			for i in range(num_tiles_x):
				for j in range(num_tiles_y):
					op_name = f'{self.op_name}_b{b}_i{i}_j{j}'
					self.tiled_ops.append(Conv1DTiledOp(op_name, tile_size, kernel_size))

		return self.tiled_ops


class LayerNormOp(Op):
	"""Layer normalization operation
	
	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, op_name, config, input_size):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.base_op = True

	def tile_op(self):
		"""Implement tiled layer normalization

		Returns:
			self.tiled_ops (list): list of LayerNormTiledOps
		"""
		self.tiled_ops = [LayerNormTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', (self.config['tile_x'], self.config['tile_y'])) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile_y']))]

		return self.tiled_ops


class NonLinearityOp(Op):
	"""Non-linearity operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		type (str): type of non-linearity in ['relu', 'gelu']
	"""
	def __init__(self, op_name, config, input_size, type):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.type = type
		self.base_op = True

	def tile_op(self):
		"""Implement tiled non-linearity

		Returns:
			self.tiled_ops (list): list of NonLinearityTiledOps
		"""
		self.tiled_ops = [NonLinearityTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', (self.config['tile_x'], self.config['tile_y'])) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile_y']))]

		return self.tiled_ops


class SoftmaxOp(Op):
	"""Softmax operation

	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, op_name, config, input_size):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.base_op = True

	def tile_op(self):
		"""Implement tiled softmax

		Returns:
			self.tiled_ops (list): list of SoftmaxTiledOps
		"""
		self.tiled_ops = [SoftmaxTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', (self.config['tile_x'], self.config['tile_y'])) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile_y']))]

		return self.tiled_ops


class SelfAttentionOp(Op):
	"""Self-attention operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		type (str): type of self-attention in ['sdp', 'wma']
	"""
	def __init__(self, op_name, config, input_size, hidden_size, type):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.type = type

	def convert_to_base_ops(self):
		"""Convert operation to base operations"""
		self.base_ops = []

		# Load input activation
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...'), self.config, self.input_size, 'activation')

		# Load weight matrices
		weight_size = (self.input_size[0], self.input_size[2], hidden_size)
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_q...'), self.config, weight_size, 'weight')
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_k...'), self.config, weight_size, 'weight')
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_v...'), self.config, weight_size, 'weight')

		# Get query, key, and value matrices
		query_op = MatrixMultOp(f'{self.op_name}_q', self.config, self.input_size, weight_size)
		key_op = MatrixMultOp(f'{self.op_name}_k', self.config, self.input_size, weight_size)
		value_op = MatrixMultOp(f'{self.op_name}_v', self.config, self.input_size, weight_size)

		self.base_ops.extend([query_op, key_op, value_op])

		query_size, key_size, value_size = query_op.output_size(), key_op.output_size(), value_op.output_size()

		key_transposed_size = self.transpose_size(key_size)

		# Implement weighted multiplicative attention
		if self.type == 'wma':
			wma_size = (key_transposed_size[0], key_transposed_size[1], key_transposed_size[1])
			self.blocks.append(MemoryLoadOp(f'{self.op_name}_wma...'), self.config, wma_size, 'weight')

			mult_key_op = MatrixMultOp(f'{self.op_name}_wma', self.config, wma_size, key_transposed_size)
			self.base_ops.append(mult_key_op)

			mult_key_size = mult_key_op.output_size()

			assert mult_key_size == key_transposed_size
		else:
			mult_key_size = key_transposed_size

		# Implement scaled dot-product
		sdp_1_op = MatrixMultOp(f'{self.op_name}_sdp-qk', self.config, query_size, mult_key_size)
		self.base_ops.append(sdp_1_op)

		sdp_1_size = sdp_1_op.output_size()

		# Implement softmax function
		self.base_ops.append(SoftmaxOp()f'{self.op_name}_sftm', self.config, sdp_1_size)

		# Multiply with value matrix
		sdp_2_op = MatrixMultOp(f'{self.op_name}_sdp-v', self.config, sdp_1_size, value_size)
		self.base_ops.append(sdp_2_op)

		sdp_2_size = sdp_2_op.output_size()

		# Multiply with output matrix
		out_weight_size = (self.input_size[0], self.input_size[2], hidden_size)
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_o...', self.config, out_weight_size, 'weight'))

		out_op = MatrixMultOp(f'{self.op_name}_o', self.config, sdp_2_size, out_weight_size)
		self.base_ops.append(out_op)

		output_size = out_op.output_size()
		assert output_size == self.input_size

	# TODO: check if tiled loading would be better than loading full matrix
	def tile_op(self, tile_memory_load=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if not self.base_ops: self.convert_to_base_ops()

		self.tiled_ops = []
		for op in self.base_ops:
			if isinstance(op, MemoryLoadOp):
				if tiled_memory_load: self.tiled_ops.extend(op.tile_ops())
			else:
				self.tiled_ops.extend(op.tile_ops())


class ConvOp(Op):
	"""Convolution operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		kernel_size (int): size of the convolutional kernel
	"""
	def __init__(self, op_name, config, input_size, hidden_size, kernel_size):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.kernel_size = kernel_size
		self.base_op = True

	def convert_to_base_ops(self):
		"""Convert operation to base operations"""
		self.base_ops = []

		# Load input activation
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...'), self.config, self.input_size, 'activation')

		# Load convolution matrix
		conv_matrix_size = (self.input_size[0], self.kernel_size, self.input_size[2])
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_c...'), self.config, conv_matrix_size, 'weight')

		conv_op = Conv1DOp(f'{self.op_name}_c', self.config, self.input_size, self.kernel_size)
		self.base_ops.append(conv_op)

		output_size = conv_op.output_size()
		assert output_size == self.input_size

	def tile_op(self, tile_memory_load=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if not self.base_ops: self.convert_to_base_ops()

		self.tiled_ops = []
		for op in self.base_ops:
			if isinstance(op, MemoryLoadOp):
				if tiled_memory_load: self.tiled_ops.extend(op.tile_ops())
			else:
				self.tiled_ops.extend(op.tile_ops())


class LinearTransformOp(Op):
	"""Linear transformation operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		type (scr): type of linear transformation in ['dct', 'dft']
	"""
	def __init__(self, op_name, config, input_size, hidden_size, type):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.type = type

	def convert_to_base_ops(self):
		"""Convert operation to base operations"""
		self.base_ops = []

		# Load input activation
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...'), self.config, self.input_size, 'activation')

		# Load Vandermonde matrix
		vandermonde_size = (self.input_size[0], self.input_size[1], self.input_size[1])
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_l...'), self.config, vandermonde_size, 'weight')

		lt_op = MatrixMultOp(f'{self.op_name}_l', self.config, vandermonde_size, self.input_size)
		self.base_ops.append(lt_op)

		output_size = lt_op.output_size()
		assert output_size == self.input_size

	def tile_op(self, tile_memory_load=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if not self.base_ops: self.convert_to_base_ops()

		self.tiled_ops = []
		for op in self.base_ops:
			if isinstance(op, MemoryLoadOp):
				if tiled_memory_load: self.tiled_ops.extend(op.tile_ops())
			else:
				self.tiled_ops.extend(op.tile_ops())


class FeedForwardOp(Op):
	"""Feed-forward neural network operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
	"""
	def __init__(self, op_name, config, input_size, hidden_size):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.hidden_size = hidden_size

	def convert_to_base_ops(self):
		"""Convert operation to base operations"""
		self.base_ops = []

		# Load input activation
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...'), self.config, self.input_size, 'activation')

		# Load linear matrix
		ff_size = (self.input_size[0], self.input_size[2], self.hidden_size)
		self.base_ops.append(MemoryLoadOp(f'{self.op_name}_f...'), self.config, ff_size, 'weight')

		ff_op = MatrixMultOp(f'{self.op_name}_l', self.config, self.input_size, ff_size)
		self.base_ops.append(ff_op)

	def tile_op(self, tile_memory_load=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if not self.base_ops: self.convert_to_base_ops()

		self.tiled_ops = []
		for op in self.base_ops:
			if isinstance(op, MemoryLoadOp):
				if tiled_memory_load: self.tiled_ops.extend(op.tile_ops())
			else:
				self.tiled_ops.extend(op.tile_ops())

