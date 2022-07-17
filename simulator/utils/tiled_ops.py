# Hardware-implementable tiled operations (only for base operations) in the Transformer architecture


# TODO: Module assignment
class TiledOp(object):
	"""Class for a tiled operation"""
	def __init__(self, op_name):
		self.name = op_name
		self.done = False


class MemoryLoadTiledOp(TiledOp):
	"""Memory load tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix to be loaded
		data_type (str): type of data to fetch in ['activation', 'weight']
	"""
	def __init__(self, op_name, input_size, data_type):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size
		self.data_type = data_type


class MatrixMultTiledOp(TiledOp):
	"""Matrix multiplication tiled operation
	
	Attributes:
		input_1_size (tuple): size of the input_1 matrix
		input_2_size (tuple): size of the input_2 matrix
	"""
	def __init__(self, op_name, input_1_size, input_2_size):
		TiledOp.__init__(self, op_name)
		self.input_1_size = input_1_size
		self.input_2_size = input_2_size

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


class Conv1DTiledOp(TiledOp):
	"""1D convolution tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		kernel_size (tuple): size of the convolutional kernel
	"""
	def __init__(self, op_name, input_size, kernel_size):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size
		self.kernel_size = kernel_size


class LayerNormTiledOp(TiledOp):
	"""Layer normalization tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, op_name, input_size):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size


class NonLinearityTiledOp(TiledOp):
	"""Non-linearity tiled operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		type (str): type of non-linearity in ['relu', 'gelu']
	"""
	def __init__(self, op_name, input_size, type):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size
		self.type = type

class SoftmaxTiledOp(Op):
	"""Softmax tiled operation

	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, op_name, input_size):
		TiledOp.__init__(self, op_name)
		self.input_size = input_size

