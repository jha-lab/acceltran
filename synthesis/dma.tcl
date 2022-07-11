remove_design -all
#******************************************************************************
# Set the design paths
#******************************************************************************
set LIBS /home/yeyu/accelerator/Synthesis/library

# Define the libraries and search path
set search_path [concat $search_path ${LIBS}]
#set target_library ${LIBS}/tcbn65lptc.db
set target_library ${LIBS}/14nm_sg_345K.db
set synthetic_library dw_foundation.sldb
set link_library [concat "*" $target_library $synthetic_library]
#set symbol_library ${L180_GII}/umcl18g212t3.sdb

define_design_lib DMA -path ./DMA
set rtl_path "./dma"
set netlist_path "./netlists"
set rpt_path "./reports"
set script_path "./script"
set search_path [concat $search_path $rtl_path $script_path]
set sdc_path "./sdc"
set db_path "./ddc"

set top_module "dma_axi64"
# the period of the clk input, unit: ps
set period 1429
set uncertainty 50
set rpt_file "${top_module}.rpt"
set netlist_file "${top_module}.v"
set power_default_toggle_rate 0.1

set rpt_path [concat $rpt_path/$top_module]
#******************************************************************************
# Read RTL files
#******************************************************************************

analyze -library DMA -format verilog {dma_axi64.v dma_axi64_core0_axim_timeout.v dma_axi64_core0_ch_fifo.v dma_axi64_core0_ch_remain.v dma_axi64_dual_core.v prgen_min3.v dma_axi64_apb_mux.v dma_axi64_core0_axim_wdata.v dma_axi64_core0_ch_fifo_ctrl.v dma_axi64_core0_ch_wr_slicer.v dma_axi64_reg.v prgen_mux8.v dma_axi64_ch_reg_params.v dma_axi64_core0_axim_wr.v dma_axi64_core0_ch_fifo_ptr.v dma_axi64_core0_channels.v dma_axi64_reg_core0.v prgen_or8.v dma_axi64_core0.v dma_axi64_core0_ch.v dma_axi64_core0_ch_offsets.v dma_axi64_core0_channels_apb_mux.v dma_axi64_reg_params.v prgen_rawstat.v dma_axi64_core0_arbiter.v dma_axi64_core0_ch_calc.v dma_axi64_core0_ch_outs.v dma_axi64_core0_channels_mux.v prgen_delay.v prgen_scatter8_1.v dma_axi64_core0_axim_cmd.v dma_axi64_core0_ch_calc_addr.v dma_axi64_core0_ch_periph_mux.v dma_axi64_core0_ctrl.v prgen_demux8.v prgen_stall.v dma_axi64_core0_axim_rd.v dma_axi64_core0_ch_calc_joint.v dma_axi64_core0_ch_rd_slicer.v dma_axi64_core0_top.v prgen_fifo.v prgen_swap_32.v dma_axi64_core0_axim_rdata.v dma_axi64_core0_ch_calc_size.v dma_axi64_core0_ch_reg.v dma_axi64_core0_wdt.v prgen_joint_stall.v prgen_swap_64.v dma_axi64_core0_axim_resp.v dma_axi64_core0_ch_empty.v dma_axi64_core0_ch_reg_size.v prgen_min2.v} 
#-define FPGA_SYN
#elaborate $top_module -architecture RTL -library work_asg_338K 
elaborate $top_module -library DMA
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

set filename [format "%s%s"  $top_module ".sdc"]
write_sdc "$sdc_path/$filename"

set filename [format "%s%s"  $top_module ".ddc"]
write -f ddc -hier -output "$db_path/$filename"
#******************************************************************************
# generate  reports
#******************************************************************************
source report.tcl

quit
