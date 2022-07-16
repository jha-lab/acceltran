# Software operations in the Transformer architecture


# TODO: add tiling and module assignment

class Op(object):
	"""Class for a generic Transformer operation"""
	def __init__(self, op_name):
		self.name = op_name
		self.done = False


class MemoryLoadOp(Op):
	"""Memory load operation
	
	Attributes:
		data_type (str): type of data to fetch in ['activation', 'weight']
	"""
	def __init__(self, op_name, data_type):
		Op.__init__(self, op_name)
		self.data_type = data_type


class SelfAttentionOp(Op):
	"""Self-attention operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		type (str): type of self-attention in ['sdp', 'wma']
	"""
	def __init__(self, op_name, input_size, hidden_size, type):
		Op.__init__(self, op_name)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.type = type


class ConvOp(Op):
	"""1d convolution operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		kernel_size (int): size of the convolutional kernel
	"""
	def __init__(self, op_name, input_size, hidden_size, kernel_size):
		Op.__init__(self, op_name)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.kernel_size = kernel_size


class LinearTransformOp(Op):
	"""Linear transformation operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		type (scr): type of linear transformation in ['dct', 'dft']
	"""
	def __init__(self, op_name, input_size, hidden_size, type):
		Op.__init__(self, op_name)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.type = type


class FeedForwardOp(Op):
	"""Feed-forward neural network operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
	"""
	def __init__(self, op_name, input_size, hidden_size):
		Op.__init__(self, op_name)
		self.input_size = input_size
		self.hidden_size = hidden_size


class LayerNormOp(Op):
	"""Layer normalization operation
	
	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, op_name, input_size):
		Op.__init__(self, op_name)
		self.input_size = input_size


class NonLinearityOp(Op):
	"""Non-linearity operation
	
	Attributes:
		input_size (tuple): size of the input matrix
		type (str): type of non-linearity in ['relu', 'gelu']
	"""
	def __init__(self, op_name, input_size, type):
		Op.__init__(self, op_name)
		self.input_size = input_size
		self.type = type

class SoftmaxOp(Op):
	"""Softmax operation

	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, op_name, input_size):
		Op.__init__(self, op_name)
		self.input_size = input_size

