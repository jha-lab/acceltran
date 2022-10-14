# Hardware-implementable tiled operations (only for base operations) in the Transformer architecture

import math


class TiledOp(object):
	"""Class for a tiled operation"""
	def __init__(self, op_name):
		self.op_name = op_name
		self.done = False


class TiledData(object):
	"""Class for a tiled data block"""
	def __init__(self, data_name, data_size, data_type):
		self.data_name = data_name
		self.data_size = data_size
		self.data_type = data_type
		self.required_in_buffer = False


class MemoryLoadTiledOp(TiledOp):
	"""Memory load (from main memory to buffer) tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix to be loaded
		data_type (str): type of data to fetch in ['activation', 'weight']
		compute_op (bool): if the operation is a compute operation
	"""
	def __init__(self, op_name, input_size, data_type):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size
		self.data_type = data_type
		self.compute_op = False

	def convert_to_data(self):
		return TiledData(data_name=self.op_name, data_size=math.prod(self.input_size), data_type=self.data_type)


class MemoryStoreTiledOp(TiledOp):
	"""Memory store (from PEs to buffer) tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix to be loaded
		data_type (str): type of data to fetch in ['activation', 'weight']
		compute_op (bool): if the operation is a compute operation
	"""
	def __init__(self, op_name, input_size, data_type):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size
		self.data_type = data_type
		self.compute_op = False

	def convert_to_data(self):
		return TiledData(data_name=self.op_name, data_size=math.prod(self.input_size), data_type=self.data_type)


class MatrixMultTiledOp(TiledOp):
	"""Matrix multiplication tiled operation
	
	Attributes:
		input_1_size (tuple): size of the input_1 matrix
		input_2_size (tuple): size of the input_2 matrix
		compute_op (bool): if the operation is a compute operation
		required_in_buffer (list): list of data object names required in buffer
		mode (str): mode of operation in ['fwd', 'bwd']
	"""
	def __init__(self, op_name, required_in_buffer, input_1_size, input_2_size, mode='fwd'):
		TiledOp.__init__(self, op_name)
		self.required_in_buffer = required_in_buffer
		self.input_1_size = input_1_size
		self.input_2_size = input_2_size
		self.mode = mode
		self.compute_op = True
		
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


class Conv1DTiledOp(TiledOp):
	"""1D convolution tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		kernel_size (tuple): size of the convolutional kernel
		compute_op (bool): if the operation is a compute operation
		required_in_buffer (list): list of data object names required in buffer 
		mode (str): mode of operation in ['fwd', 'bwd']
	"""
	def __init__(self, op_name, required_in_buffer, input_size, kernel_size, stride, mode='fwd'):
		TiledOp.__init__(self, op_name)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.kernel_size = kernel_size
		self.stride = stride
		self.mode = mode
		self.compute_op = True

		self.num_muls = input_size[0] * input_size[1] * math.floor((input_size[2] - kernel_size) * 1.0 / stride)


class LayerNormTiledOp(TiledOp):
	"""Layer normalization tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		compute_op (bool): if the operation is a compute operation 
		required_in_buffer (list): list of data object names required in buffer 
	"""
	def __init__(self, op_name, required_in_buffer, input_size):
		TiledOp.__init__(self, op_name)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.compute_op = True


class NonLinearityTiledOp(TiledOp):
	"""Non-linearity tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		type (str): type of non-linearity in ['relu', 'gelu']
		compute_op (bool): if the operation is a compute operation 
		required_in_buffer (list): list of data object names required in buffer 
	"""
	def __init__(self, op_name, required_in_buffer, input_size, type):
		TiledOp.__init__(self, op_name)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.type = type
		self.compute_op = True


class SoftmaxTiledOp(TiledOp):
	"""Softmax tiled operation

	Attributes:
		input_size (tuple): size of the input matrix
		compute_op (bool): if the operation is a compute operation 
		required_in_buffer (list): list of data object names required in buffer 
	"""
	def __init__(self, op_name, required_in_buffer, input_size):
		TiledOp.__init__(self, op_name)
		self.required_in_buffer = required_in_buffer
		self.input_size = input_size
		self.compute_op = True

