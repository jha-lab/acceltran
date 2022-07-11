#!/bin/bash
#SBATCH -N 1   # node count
#SBATCH -t 48:00:00
dc_shell -f 14nm_sg.tcl                        
