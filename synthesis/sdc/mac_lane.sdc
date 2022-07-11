###################################################################

# Created by write_sdc on Wed Dec 19 18:57:51 2018

###################################################################
set sdc_version 2.0

set_units -time ps -resistance kOhm -capacitance fF -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name 1K -library 14nm_sg_345K_maxfan4_wire
set_max_leakage_power 0
create_clock [get_ports clk]  -period 1429  -waveform {0 714.5}
set_clock_uncertainty 50  [get_clocks clk]
set_max_delay 1429  -to [get_ports {f[19]}]
set_max_delay 1429  -to [get_ports {f[18]}]
set_max_delay 1429  -to [get_ports {f[17]}]
set_max_delay 1429  -to [get_ports {f[16]}]
set_max_delay 1429  -to [get_ports {f[15]}]
set_max_delay 1429  -to [get_ports {f[14]}]
set_max_delay 1429  -to [get_ports {f[13]}]
set_max_delay 1429  -to [get_ports {f[12]}]
set_max_delay 1429  -to [get_ports {f[11]}]
set_max_delay 1429  -to [get_ports {f[10]}]
set_max_delay 1429  -to [get_ports {f[9]}]
set_max_delay 1429  -to [get_ports {f[8]}]
set_max_delay 1429  -to [get_ports {f[7]}]
set_max_delay 1429  -to [get_ports {f[6]}]
set_max_delay 1429  -to [get_ports {f[5]}]
set_max_delay 1429  -to [get_ports {f[4]}]
set_max_delay 1429  -to [get_ports {f[3]}]
set_max_delay 1429  -to [get_ports {f[2]}]
set_max_delay 1429  -to [get_ports {f[1]}]
set_max_delay 1429  -to [get_ports {f[0]}]
