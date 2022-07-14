# Software blocks in the Transformer architecture


# TODO: add tiling and module assignment

class Block(object):
	"""Class for a generic Transformer block"""
	def __init__(self, block_name):
		self.name = block_name
		self.done = False


class MemoryLoadBlock(Block):
	"""Memory load block
	
	Attributes:
		data_type (str): type of data to fetch in ['activation', 'weight']
	"""
	def __init__(self, block_name, data_type):
		Block.__init__(self, block_name)
		self.data_type = data_type


class SelfAttentionBlock(Block):
	"""Self-attention block
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		type (str): type of self-attention in ['sdp', 'wma']
	"""
	def __init__(self, block_name, input_size, hidden_size, type):
		Block.__init__(self, block_name)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.type = type


class ConvBlock(Block):
	"""1d convolution block
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		kernel_size (int): size of the convolutional kernel
	"""
	def __init__(self, block_name, input_size, hidden_size, kernel_size):
		Block.__init__(self, block_name)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.kernel_size = kernel_size


class LinearTransformBlock(Block):
	"""Linear transformation block
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
		type (scr): type of linear transformation in ['dct', 'dft']
	"""
	def __init__(self, block_name, input_size, hidden_size, type):
		Block.__init__(self, block_name)
		self.input_size = input_size
		self.hidden_size = hidden_size
		self.type = type


class FeedForwardBlock(Block):
	"""Feed-forward neural network block
	
	Attributes:
		input_size (tuple): size of the input matrix
		hidden_size (int): hidden size of the attention head
	"""
	def __init__(self, block_name, input_size, hidden_size):
		Block.__init__(self, block_name)
		self.input_size = input_size
		self.hidden_size = hidden_size


class LayerNormBlock(Block):
	"""Layer normalization block
	
	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, block_name, input_size):
		Block.__init__(self, block_name)
		self.input_size = input_size


class NonLinearityBlock(Block):
	"""Non-linearity block
	
	Attributes:
		input_size (tuple): size of the input matrix
		type (str): type of non-linearity in ['relu', 'gelu']
	"""
	def __init__(self, block_name, input_size, type):
		Block.__init__(self, block_name)
		self.input_size = input_size
		self.type = type

class SoftmaxBlock(Block):
	"""Softmax block

	Attributes:
		input_size (tuple): size of the input matrix
	"""
	def __init__(self, block_name, input_size):
		Block.__init__(self, block_name)
		self.input_size = input_size

