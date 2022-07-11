remove_design -all
#******************************************************************************
# Set the design paths
#******************************************************************************
set LIBS /home/yeyu/accelerator/Synthesis/library

# Define the libraries and search path
set search_path [concat $search_path ${LIBS}]
#set target_library ${LIBS}/tcbn65lptc.db
set target_library ${LIBS}/sg_338K.db
set synthetic_library dw_foundation.sldb
set link_library [concat "*" $target_library $synthetic_library]
#set symbol_library ${L180_GII}/umcl18g212t3.sdb

define_design_lib work_sg -path ./work_sg
set rtl_path "./top"
set netlist_path "./syn"
set rpt_path "./rpt"
set script_path "./script"
set search_path [concat $search_path $rtl_path $script_path]

set top_module "dataflow"
set period 1429
set uncertainty 50
set rpt_file "${top_module}.rpt"
set netlist_file "${top_module}.v"
set power_default_toggle_rate 0.1

set rpt_path [concat $rpt_path/$top_module]
#******************************************************************************
# Read RTL files
#******************************************************************************

analyze -library work_sg -format sv {FIFO.sv ReLU.sv filter.sv im2col_cpu_add_32dEe.v im2col_cpu_sdiv_3fYi.v max_pooling.sv pooling.sv sqrt_mul.sv update_output.sv L1.sv add.sv forward.sv im2col_cpu_add_32g8j.v im2col_cpu_sub_32eOg.v mean.sv post_sparsity.sv stochastic_rounding.sv L2.sv adder_tree.sv im2col_cpu.v im2col_cpu_data_col.v loss.sv mean_pooling.sv scalar.sv LFSR.sv backward.sv im2col_cpu_add_31hbi.v mac_lane.sv min_pooling.sv shifter.sv transposer.sv PE.sv dataflow.sv im2col_cpu_add_32bkb.v im2col_cpu_mul_32cud.v mask.sv mul.sv sparsity.sv update_mask.sv top.sv} 
#-define FPGA_SYN
#elaborate $top_module -architecture RTL -library work_asg_338K 
elaborate $top_module -library work_sg
#-parameters "N=4"
check_design

set_max_delay -to [all_outputs] $period
set_size_only
# Make the blocks instantiated from the same reference unique
uniquify

#******************************************************************************
# generate clocks
#******************************************************************************

set clock_name "clk"

create_clock -name $clock_name -period $period $clock_name
set_clock_uncertainty $uncertainty $clock_name
set_dont_touch_network $clock_name

#set_dont_touch_network rst
#set_input_delay 250 -clock clk -max [all_inputs]
#set_input_delay 250 -clock clk -min [all_inputs]

#******************************************************************************
# compile setup and compile
#******************************************************************************

set_max_leakage_power 0.000000; # Optimize for minimum leakage
set_wire_load_model -name "1K"
set_wire_load_mode top

#Add buffers on inputs passed directly to outputs, or outputs passed directly
#to inputs
set compile_fix_multiple_port_nets true;

compile -map_effort high
ungroup -all -flatten
compile
check_design
write_file -format verilog -output "$netlist_path/$netlist_file"

#******************************************************************************
# generate  reports
#******************************************************************************
source report.tcl

quit
