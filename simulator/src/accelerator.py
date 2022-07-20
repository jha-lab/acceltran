# Run tiled operations on corresponding hardware modules

import math
from ops import *
from tiled_ops import *
from modules import *
from pe import ProcessingElement
from buffer import Buffer


class Accelerator(object):
	"""Accelerator class
	
	Attributes:
		pes (list): list of ProcessingElement objects
		activation_buffer (Buffer): Buffer class object for activations
		mask_buffer (Buffer): Buffer class object for binary masks
		weight_buffer (Buffer): Buffer class object for weights
	"""
	def __init__(self, config, constants):
		self.pes = []
		for p in range(config['pe']):
			self.pes.append(ProcessingElement(f'pe{p}', config, constants))

		self.activation_buffer = Buffer('activation', config, constants)
		self.weight_buffer = Buffer('weight', config, constants)
		self.mask_buffer = Buffer('mask', config, constants)

		# TODO: add main memory object with its leakage energy
