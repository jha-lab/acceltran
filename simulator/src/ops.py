# Software operations in the Transformer architecture

import math
from tiled_ops import *


class Op(object):
	"""Class for a generic Transformer operation"""
	def __init__(self, op_name, config):
		self.op_name = op_name
		self.config = config
		self.base_op = False
		self.done = False

		# List of data names required in buffer for the current operation
		self.required_in_buffer = [] 

	def __repr__(self):
		return self.op_name

	@staticmethod
	def transpose_size(matrix_size):
		return (matrix_size[0], matrix_size[2], matrix_size[1])


class Data(object):
	"""Class for a generic data block"""
	def __init__(self, data_name, data_size, data_type, overwrite=False):
		self.data_name = data_name
		self.data_size = data_size
		self.data_type = data_type
		self.overwrite = overwrite
		self.required_in_buffer = False


class MemoryLoadOp(Op):
	"""Memory load (from main memory to buffer) base operation
	
	Attributes:
		input_size (tuple): size of the input matrix to be loaded
		data_type (str): type of data to fetch in ['activation', 'weight']
		compute_op (bool): if the operation is a compute operation (only for base operation)
	"""
	def __init__(self, op_name, config, input_size, data_type):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.data_type = data_type
		self.compute_op = False
		self.base_op = True

	def convert_to_data(self):
		return Data(data_name=self.op_name, data_size=math.prod(self.input_size), data_type=self.data_type)

	def tile_op(self):
		"""Tile a memory load operation
		
		Returns:
			self.tiled_ops (list): list of MemoryLoadTiledOps
		"""
		self.tiled_ops = [MemoryLoadTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', (self.config['tile']['tile_x'], self.config['tile']['tile_y']), self.data_type) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile']['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile']['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile']['tile_y']))]

		return self.tiled_ops


class MemoryStoreOp(Op):
	"""Memory store (from PEs to buffer) base operation
	
	Attributes:
		input_size (tuple): size of the input matrix to be loaded
		data_type (str): type of data to fetch in ['activation', 'weight']
		compute_op (bool): if the operation is a compute operation (only for base operation)
		overwrite (bool): if an activation/weight is being overwridden
	"""
	def __init__(self, op_name, config, input_size, data_type, overwrite=False):
		Op.__init__(self, op_name, config)
		self.input_size = input_size
		self.data_type = data_type
		self.overwrite = overwrite
		self.compute_op = False
		self.base_op = True

	def convert_to_data(self):
		return Data(data_name=self.op_name, data_size=math.prod(self.input_size), data_type=self.data_type, overwrite=self.overwrite)

	def tile_op(self):
		"""Tile a memory load operation
		
		Returns:
			self.tiled_ops (list): list of MemoryLoadTiledOps
		"""
		self.tiled_ops = [MemoryStoreTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', (self.config['tile']['tile_x'], self.config['tile']['tile_y']), self.data_type) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile']['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile']['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile']['tile_y']))]

		return self.tiled_ops


class MatrixMultOp(Op):
	"""Matrix multiplication base operation

	Attributes:
		input_1_size (tuple): size of the input_1 matrix
		input_2_size (tuple): size of the input_2 matrix
		compute_op (bool): if the operation is a compute operation (only for base operation)
		required_in_buffer (list): list of data object names required in buffer (only for base operation which is also a compute operation)
		mode (str): mode of operation in ['fwd', 'bwd']
	"""
	def __init__(self, op_name, config, required_in_buffer, input_1_size, input_2_size, mode='fwd'):
		Op.__init__(self, op_name, config)
		self.required_in_buffer = required_in_buffer
		self.input_1_size = input_1_size
		self.input_2_size = input_2_size
		self.mode = mode
		self.compute_op = True
		self.base_op = True

		self.loop_unrolling = config['loop_unrolling']

		self.check_input_sizes()
		self.num_muls = input_1_size[0] * input_1_size[1] * input_1_size[2] * input_2_size[2]

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
		num_tiles_b = math.ceil(self.input_1_size[0] * 1.0 / self.config['tile']['tile_b'])
		num_tiles_1_x = math.ceil(self.input_1_size[1] * 1.0 / self.config['tile']['tile_x'])
		num_tiles_1_y = math.ceil(self.input_1_size[2] * 1.0 / self.config['tile']['tile_y'])
		num_tiles_2_x = math.ceil(self.input_2_size[1] * 1.0 / self.config['tile']['tile_x'])
		num_tiles_2_y = math.ceil(self.input_2_size[2] * 1.0 / self.config['tile']['tile_y'])

		assert num_tiles_1_y == num_tiles_2_x

		tile_size = (self.config['tile']['tile_b'], self.config['tile']['tile_x'], self.config['tile']['tile_y'])

		loop_order = self.loop_unrolling.split('_')
		num_tiles = []
		for order in loop_order:
			if order == 'b': num_tiles.append(num_tiles_b)
			if order == 'i': num_tiles.append(num_tiles_1_x)
			if order == 'j': num_tiles.append(num_tiles_2_y)
			if order == 'k': num_tiles.append(num_tiles_2_x)

		self.tiled_ops = []
		for l0 in range(num_tiles[0]):
			for l1 in range(num_tiles[1]):
				for l2 in range(num_tiles[2]):
					for l3 in range(num_tiles[3]):
						b, i, j, k = eval(f'l{loop_order.index("b")}'), eval(f'l{loop_order.index("i")}'), eval(f'l{loop_order.index("j")}'), eval(f'l{loop_order.index("k")}')
						op_name = f'{self.op_name}_b{b}_i{i}_j{j}_k{k}'
						self.tiled_ops.append(MatrixMultTiledOp(op_name, self.required_in_buffer, tile_size, tile_size, mode=self.mode))

		return self.tiled_ops


class Conv1DOp(Op):
	"""1D convolution base operation

	Attributes:
		input_size (tuple): size of the input matrix
		kernel_size (int): size of the convolutional kernel
		compute_op (bool): if the operation is a compute operation (only for base operation)
		required_in_buffer (list): list of data object names required in buffer (only for base operation which is also a compute operation)
	"""
	def __init__(self, op_name, config, required_in_buffer, input_size, kernel_size, stride=1, mode='fwd'):
		Op.__init__(self, op_name, config)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.kernel_size = kernel_size
		self.stride = stride
		self.mode = mode
		self.compute_op = True
		self.base_op = True

		self.loop_unrolling = config['loop_unrolling']

		self.num_muls = input_size[0] * input_size[1] * math.floor((input_size[2] - kernel_size) * 1.0 / stride)

	def tile_op(self):
		"""Implement tiled convolution operation (neglect halos)

		Returns:
			self.tiled_ops (list): list of Conv1DTiledOps
		"""
		num_tiles_b = math.ceil(self.input_size[0] * 1.0 / self.config['tile']['tile_b'])
		num_tiles_x = math.ceil(self.input_size[1] * 1.0 / self.config['tile']['tile_x'])
		num_tiles_y = math.ceil(self.input_size[2] * 1.0 / self.config['tile']['tile_y'])

		tile_size = (self.config['tile']['tile_b'], self.config['tile']['tile_x'], self.config['tile']['tile_y'])
		# kernel_size = (self.config['tile']['tile_b'], self.kernel_size, self.config['tile']['tile_y'])

		loop_order = self.loop_unrolling.split('_')
		loop_order.remove('k')
		num_tiles = []
		for order in loop_order:
			if order == 'b': num_tiles.append(num_tiles_b)
			if order == 'i': num_tiles.append(num_tiles_x)
			if order == 'j': num_tiles.append(num_tiles_y)

		self.tiled_ops = []
		for l0 in range(num_tiles[0]):
			for l1 in range(num_tiles[1]):
				for l2 in range(num_tiles[2]):
					b, i, j = eval(f'l{loop_order.index("b")}'), eval(f'l{loop_order.index("i")}'), eval(f'l{loop_order.index("j")}')
					op_name = f'{self.op_name}_b{b}_i{i}_j{j}'
					self.tiled_ops.append(Conv1DTiledOp(op_name, self.required_in_buffer, tile_size, self.kernel_size, self.stride, self.mode))

		return self.tiled_ops


class LayerNormOp(Op):
	"""Layer normalization operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		compute_op (bool): if the operation is a compute operation (only for base operation)
		required_in_buffer (list): list of data object names required in buffer (only for base operation which is also a compute operation)
	"""
	def __init__(self, op_name, config, required_in_buffer, input_size):
		Op.__init__(self, op_name, config)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.compute_op = True
		self.base_op = True

	def tile_op(self):
		"""Implement tiled layer normalization

		Returns:
			self.tiled_ops (list): list of LayerNormTiledOps
		"""
		self.tiled_ops = [LayerNormTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', self.required_in_buffer, (self.config['tile']['tile_b'], self.config['tile']['tile_x'], self.config['tile']['tile_y'])) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile']['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile']['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile']['tile_y']))]

		return self.tiled_ops


class NonLinearityOp(Op):
	"""Non-linearity operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		type (str): type of non-linearity in ['relu', 'gelu']
		required_in_buffer (list): list of data object names required in buffer (only for base operation which is also a compute operation)
	"""
	def __init__(self, op_name, config, required_in_buffer, input_size, type):
		Op.__init__(self, op_name, config)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.type = type
		self.compute_op = True
		self.base_op = True

	def tile_op(self):
		"""Implement tiled non-linearity

		Returns:
			self.tiled_ops (list): list of NonLinearityTiledOps
		"""
		self.tiled_ops = [NonLinearityTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', self.required_in_buffer, (self.config['tile']['tile_b'], self.config['tile']['tile_x'], self.config['tile']['tile_y']), self.type) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile']['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile']['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile']['tile_y']))]

		return self.tiled_ops


class SoftmaxOp(Op):
	"""Softmax operation

	Attributes:
		input_size (tuple): size of the input matrix
		compute_op (bool): if the operation is a compute operation (only for base operation)
		required_in_buffer (list): list of data object names required in buffer (only for base operation which is also a compute operation)
	"""
	def __init__(self, op_name, config, required_in_buffer, input_size):
		Op.__init__(self, op_name, config)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.compute_op = True
		self.base_op = True

	def tile_op(self):
		"""Implement tiled softmax

		Returns:
			self.tiled_ops (list): list of SoftmaxTiledOps
		"""
		self.tiled_ops = [SoftmaxTiledOp(f'{self.op_name}_b{b}_x{x}_y{y}', self.required_in_buffer, (self.config['tile']['tile_x'], self.config['tile']['tile_y'])) for b in range(math.ceil(self.input_size[0] * 1.0 / self.config['tile']['tile_b'])) for x in range(math.ceil(self.input_size[1] * 1.0 / self.config['tile']['tile_x'])) for y in range(math.ceil(self.input_size[2] * 1.0 / self.config['tile']['tile_y']))]

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
		self.fwd_base_ops = []
		self.bwd_base_ops = []

	def convert_to_fwd_base_ops(self):
		"""Convert operation to forward base operations"""
		self.fwd_base_ops = []

		# Input activations are assumed to be in the activation buffer for throughput calculation (i.e., only loaded once)
		## self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_inp-l', self.config, self.input_size, 'activation'))

		# Load weight matrices
		self.weight_size = (self.input_size[0], self.input_size[2], self.hidden_size)
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_q-l', self.config, self.weight_size, 'weight'))
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_k-l', self.config, self.weight_size, 'weight'))
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_v-l', self.config, self.weight_size, 'weight'))

		# Get query, key, and value matrices
		query_op = MatrixMultOp(f'{self.op_name}_q', self.config, [f'{self.op_name}_q-l'], self.input_size, self.weight_size)
		key_op = MatrixMultOp(f'{self.op_name}_k', self.config, [f'{self.op_name}_k-l'], self.input_size, self.weight_size)
		value_op = MatrixMultOp(f'{self.op_name}_v', self.config, [f'{self.op_name}_v-l'], self.input_size, self.weight_size)

		self.fwd_base_ops.extend([query_op, key_op, value_op])

		self.query_size, self.key_size, self.value_size = query_op.output_size(), key_op.output_size(), value_op.output_size()

		self.key_transposed_size = Op.transpose_size(self.key_size)

		# Store key, query and value matrices in buffer
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_q-s', self.config, self.query_size, 'activation'))
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_k-s', self.config, self.key_size, 'activation'))
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_v-s', self.config, self.value_size, 'activation'))

		# Implement weighted multiplicative attention
		if self.type == 'wma':
			self.wma_size = (self.key_transposed_size[0], self.key_transposed_size[1], self.key_transposed_size[1])
			self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_wma-l', self.config, self.wma_size, 'weight'))

			mult_key_op = MatrixMultOp(f'{self.op_name}_wma', self.config, [f'{self.op_name}_wma-l', f'{self.op_name}_k-s', f'{self.op_name}_q-s', f'{self.op_name}_v-s'],  self.wma_size, self.key_transposed_size)
			self.fwd_base_ops.append(mult_key_op)

			# Store key matrix in buffer onto the same old position
			self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_k-s', self.config, self.key_size, 'activation'))

			self.mult_key_size = mult_key_op.output_size()

			assert self.mult_key_size == self.key_transposed_size
		else:
			self.mult_key_size = self.key_transposed_size

		# Implement scaled dot-product
		sdp_1_op = MatrixMultOp(f'{self.op_name}_sdp-qk', self.config, [f'{self.op_name}_q-s', f'{self.op_name}_k-s', f'{self.op_name}_v-s'], self.query_size, self.mult_key_size)
		self.fwd_base_ops.append(sdp_1_op)

		self.sdp_1_size = sdp_1_op.output_size()

		# Store scaled dot-product output
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_sdp-qk-s', self.config, self.sdp_1_size, 'activation'))

		# Implement softmax function
		self.fwd_base_ops.append(SoftmaxOp(f'{self.op_name}_sftm', self.config, [f'{self.op_name}_sdp-qk-s', f'{self.op_name}_v-s'], self.sdp_1_size))

		# Store sotfmax output
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_sftm-s', self.config, self.sdp_1_size, 'activation'))

		# Multiply with value matrix
		sdp_2_op = MatrixMultOp(f'{self.op_name}_sdp-v', self.config, [f'{self.op_name}_v-s', f'{self.op_name}_sftm-s'],  self.sdp_1_size, self.value_size)
		self.fwd_base_ops.append(sdp_2_op)

		self.sdp_2_size = sdp_2_op.output_size()

		# Store value matrix multiplication output
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_sdp-v-s', self.config, self.sdp_2_size, 'activation'))

		# Multiply with output matrix
		self.out_weight_size = (self.input_size[0], self.hidden_size, self.input_size[2])
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_o-l', self.config, self.out_weight_size, 'weight'))

		out_op = MatrixMultOp(f'{self.op_name}_o', self.config, [f'{self.op_name}_o-l', f'{self.op_name}_sdp-v-s'], self.sdp_2_size, self.out_weight_size)
		self.fwd_base_ops.append(out_op)

		self.output_size = out_op.output_size()
		assert self.output_size == self.input_size

		# Store attenion-head output matrix
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_o-s', self.config, self.input_size, 'activation'))

	def convert_to_bwd_base_ops(self):
		"""Convert operation to backward base operations"""
		self.bwd_base_ops = []

		if not self.fwd_base_ops: self.convert_to_fwd_base_ops()

		# Incoming gradients are assumed to be in the activation buffer
		del_out_size = (self.sdp_2_size[0], self.sdp_2_size[1], self.output_size[2])

		# Get weight update matrix (del_W = x_[i-1].T * del_i)
		out_op = MatrixMultOp(f'{self.op_name}_o[wgt]', self.config, [], Op.transpose_size(self.sdp_2_size), del_out_size, mode='bwd')
		self.bwd_base_ops.append(out_op)

		assert self.out_weight_size == out_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_o[wgt]-s', self.config, self.out_weight_size, 'weight', overwrite=True))

		# Find gradient from out_op (del_i = del_[i+1] * W_[i+1].T)
		del_sdp_2_op = MatrixMultOp(f'{self.op_name}_sdp-v[del]', self.config, [f'{self.op_name}_o[wgt]'], del_out_size, Op.transpose_size(out_op.output_size()), mode='bwd') 
		del_sdp_2_size = del_sdp_2_op.output_size()
		self.bwd_base_ops.append(del_sdp_2_op)

		assert del_sdp_2_size == (self.sdp_1_size[0], self.sdp_1_size[1], self.value_size[2])

		# Get weight update matrix for value matrix
		sdp_2_op = MatrixMultOp(f'{self.op_name}_sdp-v[wgt]', self.config, [f'{self.op_name}_sdp-v[del]'], Op.transpose_size(self.sdp_1_size), del_sdp_2_size, mode='bwd')
		self.bwd_base_ops.append(sdp_2_op)

		assert self.value_size == sdp_2_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_sdp-v[wgt]-s', self.config, self.value_size, 'weight', overwrite=True))

		# Find gradient from sdp_2_op towards mult_key
		del_sdp_1_k_op = MatrixMultOp(f'{self.op_name}_sdp-qk_k[del]', self.config, [f'{self.op_name}_sdp-v[wgt]'], del_sdp_2_size, Op.transpose_size(sdp_2_op.output_size()), mode='bwd')
		del_sdp_1_k_size = del_sdp_1_k_op.output_size()
		self.bwd_base_ops.append(del_sdp_1_k_op)

		# Get weight update matrix for mult_key
		sdp_1_k_op = MatrixMultOp(f'{self.op_name}_sdp_qk_k[wgt]', self.config, [f'{self.op_name}_sdp-qk_k[del]'], Op.transpose_size(self.query_size), del_sdp_1_k_size, mode='bwd')
		self.bwd_base_ops.append(sdp_1_k_op)

		assert self.mult_key_size == sdp_1_k_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_sdp_qk_k[wgt]-s', self.config, self.mult_key_size, 'weight', overwrite=True))

		# Find gradient from sdp_2_op towards query output 
		del_sdp_1_q_op = MatrixMultOp(f'{self.op_name}_sdp-qk_q[del]', self.config, [f'{self.op_name}_sdp-v[wgt]'], Op.transpose_size(sdp_2_op.output_size()), del_sdp_2_size, mode='bwd')
		del_sdp_1_q_size = del_sdp_1_q_op.output_size()
		self.bwd_base_ops.append(del_sdp_1_q_op)

		# Get weight update matrix for the query output 
		sdp_1_q_op = MatrixMultOp(f'{self.op_name}_sdp_qk_q[wgt]', self.config, [f'{self.op_name}_sdp-qk_q[del]'], Op.transpose_size(self.mult_key_size), del_sdp_1_q_size, mode='bwd')
		self.bwd_base_ops.append(sdp_1_q_op)

		assert self.query_size == sdp_1_q_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_sdp_qk_q[wgt]-s', self.config, self.query_size, 'weight', overwrite=True))

		if self.type == 'wma':
			# Find gradient from sdp_1_op towards wma matrix
			del_wma_op = MatrixMultOp(f'{self.op_name}_wma[del]', self.config, [f'{self.op_name}_sdp-qk_k[del]'], sdp_1_k_op.output_size(), del_sdp_1_k_size, mode='bwd')
			del_wma_size = del_wma_op.output_size()
			self.bwd_base_ops.append(del_wma_op)

			# Get weight update matrix for wma matrix
			wma_op = MatrixMultOp(f'{self.op_name}_wma[wgt]', self.config, [f'{self.op_name}_wma[del]'], del_wma_size, Op.transpose_size(self.key_transposed_size), mode='bwd')
			self.bwd_base_ops.append(wma_op)

			assert self.wma_size == wma_op.output_size()

			self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_wma[wgt]-s', self.config, self.wma_size, 'weight', overwrite=True))

		# Find the gradient from query output to query matrix
		del_query_op = MatrixMultOp(f'{self.op_name}_q[del]', self.config, [f'{self.op_name}_sdp_qk_q[wgt]'], del_sdp_1_q_size, Op.transpose_size(sdp_1_q_op.output_size()), mode='bwd')
		del_query_size = del_query_op.output_size()
		self.bwd_base_ops.append(del_query_op)

		# Get weight update matrix for query matrix
		query_op = MatrixMultOp(f'{self.op_name}_q[wgt]', self.config, [f'{self.op_name}_q[del]'], Op.transpose_size(self.input_size), Op.transpose_size(del_query_size), mode='bwd')
		self.bwd_base_ops.append(query_op)

		assert self.weight_size == query_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_q[wgt]-s', self.config, self.weight_size, 'weight', overwrite=True))

		# Find the gradient from query output to key matrix
		del_key_op = MatrixMultOp(f'{self.op_name}_k[del]', self.config, [f'{self.op_name}_sdp_qk_k[wgt]'], del_sdp_1_k_size, Op.transpose_size(sdp_1_k_op.output_size()), mode='bwd')
		del_key_size = del_key_op.output_size()
		self.bwd_base_ops.append(del_key_op)

		# Get weight update matrix for key matrix
		key_op = MatrixMultOp(f'{self.op_name}_k[wgt]', self.config, [f'{self.op_name}_k[del]'], Op.transpose_size(self.input_size), del_key_size, mode='bwd')
		self.bwd_base_ops.append(key_op)

		assert self.weight_size == key_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_k[wgt]-s', self.config, self.weight_size, 'weight', overwrite=True))

		# Find the gradient from query output to value matrix
		del_value_op = MatrixMultOp(f'{self.op_name}_v[del]', self.config, [f'{self.op_name}_sdp_v[wgt]'], del_sdp_2_size, Op.transpose_size(sdp_2_op.output_size()), mode='bwd')
		del_value_size = del_value_op.output_size()
		self.bwd_base_ops.append(del_value_op)

		# Get weight update matrix for value matrix
		value_op = MatrixMultOp(f'{self.op_name}_v[wgt]', self.config, [f'{self.op_name}_v[del]'], Op.transpose_size(self.input_size), del_value_size, mode='bwd')
		self.bwd_base_ops.append(value_op)

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_v[wgt]-s', self.config, self.weight_size, 'weight', overwrite=True))

	def tile_op(self, direction, tile_memory_ops=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if direction == 'fwd':
			if not self.fwd_base_ops: self.convert_to_fwd_base_ops()
			base_ops = self.fwd_base_ops
		else:
			if not self.bwd_base_ops: self.convert_to_bwd_base_ops()
			base_ops = self.bwd_base_ops

		self.tiled_ops = []
		for op in base_ops:
			if isinstance(op, (MemoryLoadOp, MemoryStoreOp)):
				if tile_memory_ops: 
					self.tile_op.extend(op.tile_op())
				else:
					self.tile_op.append(op)
			else:
				self.tile_op.extend(op.tile_op())

		return self.tiled_ops


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
		self.fwd_base_ops = []
		self.bwd_base_ops = []

	def convert_to_fwd_base_ops(self):
		"""Convert operation to forward base operations"""
		self.fwd_base_ops = []

		# Input activations are assumed to be in the activation buffer
		## self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...', self.config, self.input_size, 'activation'))

		# Load convolution matrix
		self.conv_matrix_size = (self.input_size[0], self.kernel_size, self.input_size[2])
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_c-l', self.config, self.conv_matrix_size, 'weight'))

		conv_op = Conv1DOp(f'{self.op_name}_c', self.config, [f'{self.op_name}_c-l'], self.input_size, self.kernel_size)
		self.fwd_base_ops.append(conv_op)

		# Store attenion-head output matrix
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_c-s', self.config, self.input_size, 'activation'))

	def convert_to_bwd_base_ops(self):
		"""Convert operation to backward base operations"""
		self.bwd_base_ops = []

		if not self.fwd_base_ops: self.convert_to_fwd_base_ops()

		# Size of the gradients should match the input
		output_grad_size = self.input_size

		conv_op = Conv1DOp(f'{self.op_name}_c[wgt]', self.config, [], output_grad_size, self.input_size[1], mode='bwd')
		self.bwd_base_ops.append(conv_op)

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_c[wgt]-s', self.config, self.conv_matrix_size, 'weight', overwrite=True))

	def tile_op(self, direction, tile_memory_ops=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if direction == 'fwd':
			if not self.fwd_base_ops: self.convert_to_fwd_base_ops()
			base_ops = self.fwd_base_ops
		else:
			if not self.bwd_base_ops: self.convert_to_bwd_base_ops()
			base_ops = self.bwd_base_ops

		self.tiled_ops = []
		for op in base_ops:
			if isinstance(op, (MemoryLoadOp, MemoryStoreOp)):
				if tile_memory_ops: 
					self.tile_op.extend(op.tile_op())
				else:
					self.tile_op.append(op)
			else:
				self.tile_op.extend(op.tile_op())

		return self.tiled_ops

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
		self.fwd_base_ops = []
		self.bwd_base_ops = []

	def convert_to_fwd_base_ops(self):
		"""Convert operation to forward base operations"""
		self.fwd_base_ops = []

		# Input activations are assumed to be in the activation buffer
		## self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...', self.config, self.input_size, 'activation'))

		# Load Vandermonde matrix
		vandermonde_size = (self.input_size[0], self.input_size[1], self.input_size[1])
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_l-l', self.config, vandermonde_size, 'weight'))

		lt_op = MatrixMultOp(f'{self.op_name}_l', self.config, [f'{self.op_name}_l-l'], vandermonde_size, self.input_size)
		self.fwd_base_ops.append(lt_op)

		output_size = lt_op.output_size()
		assert output_size == self.input_size

		# Store attenion-head output matrix
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_l-s', self.config, self.input_size, 'activation'))

	def convert_to_bwd_base_ops(self):
		"""Convert operation to backward base operations"""
		self.bwd_base_ops = []

		if not self.fwd_base_ops: self.convert_to_fwd_base_ops()

		# No learning in linear transform

	def tile_op(self, direction, tile_memory_ops=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if direction == 'fwd':
			if not self.fwd_base_ops: self.convert_to_fwd_base_ops()
			base_ops = self.fwd_base_ops
		else:
			if not self.bwd_base_ops: self.convert_to_bwd_base_ops()
			base_ops = self.bwd_base_ops

		self.tiled_ops = []
		for op in base_ops:
			if isinstance(op, (MemoryLoadOp, MemoryStoreOp)):
				if tile_memory_ops: 
					self.tile_op.extend(op.tile_op())
				else:
					self.tile_op.append(op)
			else:
				self.tile_op.extend(op.tile_op())

		return self.tiled_ops

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
		self.fwd_base_ops = []
		self.bwd_base_ops = []

	def convert_to_fwd_base_ops(self):
		"""Convert operation to forward base operations"""
		self.fwd_base_ops = []

		# Input activations are assumed to be in the activation buffer
		## self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_inp...', self.config, self.input_size, 'activation'))

		# Load linear matrix
		self.ff_weight_size = (self.input_size[0], self.input_size[2], self.hidden_size)
		self.fwd_base_ops.append(MemoryLoadOp(f'{self.op_name}_f-l', self.config, self.ff_weight_size, 'weight'))

		ff_op = MatrixMultOp(f'{self.op_name}_f', self.config, [f'{self.op_name}_f-l'], self.input_size, self.ff_weight_size)
		self.fwd_base_ops.append(ff_op)

		ff_size = ff_op.output_size()

		# Store attenion-head output matrix
		self.fwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_f-s', self.config, ff_size, 'activation'))

	def convert_to_bwd_base_ops(self):
		"""Convert operation to backward base operations"""
		self.bwd_base_ops = []

		if not self.fwd_base_ops: self.convert_to_fwd_base_ops()

		# Incoming gradients are assumed to be in the activation buffer
		del_f_size = (self.input_size[0], self.input_size[1], self.ff_weight_size[2])

		# Get weight update matrix (del_W = x_[i-1].T * del_i)
		ff_op = MatrixMultOp(f'{self.op_name}_f[wgt]', self.config, [], Op.transpose_size(self.input_size), del_f_size, mode='bwd')
		self.bwd_base_ops.append(ff_op)

		assert self.ff_weight_size == ff_op.output_size()

		self.bwd_base_ops.append(MemoryStoreOp(f'{self.op_name}_f[wgt]-s', self.config, self.ff_weight_size, 'weight', overwrite=True))

	def tile_op(self, direction, tile_memory_ops=False):
		"""Implement tiled operations

		Returns:
			self.tiled_ops (list): list of tiled base ops
		"""
		if direction == 'fwd':
			if not self.fwd_base_ops: self.convert_to_fwd_base_ops()
			base_ops = self.fwd_base_ops
		else:
			if not self.bwd_base_ops: self.convert_to_bwd_base_ops()
			base_ops = self.bwd_base_ops

		self.tiled_ops = []
		for op in base_ops:
			if isinstance(op, (MemoryLoadOp, MemoryStoreOp)):
				if tile_memory_ops: 
					self.tile_op.extend(op.tile_op())
				else:
					self.tile_op.append(op)
			else:
				self.tile_op.extend(op.tile_op())

		return self.tiled_ops

