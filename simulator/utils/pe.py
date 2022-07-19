# Run tiled operations on corresponding hardware modules

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

    	self.dataflow = Dataflow(f'{self.pe_name}_df', constants)
    	self.dma = DMA(f'{self.pe_name}_dma', constants)

    	self.layer_norm = LayerNorm(f'{self.pe_name}_ln', constants)
    	self.softmax = Softmax(f'{self.pe_name}_sftm', constants)

