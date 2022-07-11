###################################################################

# Created by write_sdc on Wed Dec 19 20:17:19 2018

###################################################################
set sdc_version 2.0

set_units -time ps -resistance kOhm -capacitance fF -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name 1K -library 14nm_sg_345K_maxfan4_wire
set_max_leakage_power 0
set_max_delay 1429  -to [get_ports ap_done]
set_max_delay 1429  -to [get_ports ap_idle]
set_max_delay 1429  -to [get_ports ap_ready]
