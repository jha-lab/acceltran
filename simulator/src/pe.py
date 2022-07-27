# Processing Element class for the Accelerator

import math
from ops import *
from tiled_ops import *
from modules import *


class ProcessingElement(object):
	"""Processing Element class
	
	Attributes:
		pe_name (str): name of the given PE
		mac_lanes (list): list of MACLane objects
		dataflow (Dataflow): Dataflow module object
		dma (DMA): DMA module object
		layer_norm (LayerNorm): LayerNorm module object
		softmax (Softmax): Softmax module object
	"""
	def __init__(self, pe_name, config, constants):
		self.pe_name = pe_name

		self.mac_lanes = []
		for n in range(config['lanes_per_pe']):
			self.mac_lanes.append(MACLane(f'{self.pe_name}_maclane{(n + 1)}', config, constants))

		self.dataflow = Dataflow(f'{self.pe_name}_df', config, constants)
		self.dma = DMA(f'{self.pe_name}_dma', config, constants)

		self.layer_norm = LayerNorm(f'{self.pe_name}_ln', config, constants)
		self.softmax = Softmax(f'{self.pe_name}_sftm', config, constants)

		self.area = 0
		for mac_lane in self.mac_lanes:
			self.area += mac_lane.area
		self.area = self.area + self.dataflow.area + self.dma.area + self.layer_norm.area + self.softmax.area

	def process_cycle(self):
		total_energy = [0, 0]
		for mac_lane in self.mac_lanes:
			mac_lane_energy = mac_lane.process_cycle()
			total_energy[0] += mac_lane_energy[0]; total_energy[1] += mac_lane_energy[1]

		dataflow_energy = self.dataflow.process_cycle()
		dma_energy = self.dma.process_cycle()
		layer_norm_energy = self.layer_norm.process_cycle()
		softmax_energy = self.softmax.process_cycle()

		for i in [0, 1]:
			total_energy[i] = total_energy[i] + dataflow_energy[i] + dma_energy[i] + layer_norm_energy[i] + softmax_energy[i]

		return tuple(total_energy) # unit: nJ

	def assign_op(self, op):
		assert op.compute_op is True
		assigned_op = False

		if isinstance(op, (MatrixMultOp, MatrixMultTiledOp, Conv1DOp, Conv1DTiledOp, NonLinearityOp, NonLinearityTiledOp)):
			for mac_lane in self.mac_lanes:
				if mac_lane.ready:
					mac_lane.assign_op(op)
					assigned_op = True
					break
		elif isinstance(op, (LayerNormOp, LayerNormTiledOp)):
			if self.layer_norm.ready:
				self.layer_norm.assign_op(op)
				assigned_op = True
		elif isinstance(op, (SoftmaxOp, SoftmaxTiledOp)):
			if self.softmax.ready:
				self.softmax.assign_op(op)
				assigned_op = True
		else:
			raise ValueError(f'Invalid operation: {op.op_name} of type: {type(op)}')

		return assigned_op

