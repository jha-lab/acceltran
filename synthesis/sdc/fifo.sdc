###################################################################

# Created by write_sdc on Wed Dec 19 16:49:00 2018

###################################################################
set sdc_version 2.0

set_units -time ps -resistance kOhm -capacitance fF -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name 1K -library 14nm_sg_345K_maxfan4_wire
set_max_leakage_power 0
create_clock [get_ports clk]  -period 1429  -waveform {0 714.5}
set_clock_uncertainty 50  [get_clocks clk]
set_max_delay 1429  -to [get_ports empty]
set_max_delay 1429  -to [get_ports full]
set_max_delay 1429  -to [get_ports {data_out[19]}]
set_max_delay 1429  -to [get_ports {data_out[18]}]
set_max_delay 1429  -to [get_ports {data_out[17]}]
set_max_delay 1429  -to [get_ports {data_out[16]}]
set_max_delay 1429  -to [get_ports {data_out[15]}]
set_max_delay 1429  -to [get_ports {data_out[14]}]
set_max_delay 1429  -to [get_ports {data_out[13]}]
set_max_delay 1429  -to [get_ports {data_out[12]}]
set_max_delay 1429  -to [get_ports {data_out[11]}]
set_max_delay 1429  -to [get_ports {data_out[10]}]
set_max_delay 1429  -to [get_ports {data_out[9]}]
set_max_delay 1429  -to [get_ports {data_out[8]}]
set_max_delay 1429  -to [get_ports {data_out[7]}]
set_max_delay 1429  -to [get_ports {data_out[6]}]
set_max_delay 1429  -to [get_ports {data_out[5]}]
set_max_delay 1429  -to [get_ports {data_out[4]}]
set_max_delay 1429  -to [get_ports {data_out[3]}]
set_max_delay 1429  -to [get_ports {data_out[2]}]
set_max_delay 1429  -to [get_ports {data_out[1]}]
set_max_delay 1429  -to [get_ports {data_out[0]}]
