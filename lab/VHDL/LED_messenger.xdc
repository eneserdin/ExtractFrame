set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN T22 [get_ports messenger_clk]
set_property PACKAGE_PIN U22 [get_ports messenger_data]
set_property IOSTANDARD LVCMOS33 [get_ports messenger_clk]
set_property IOSTANDARD LVCMOS33 [get_ports messenger_data]
create_clock -period 10.000 -name clk -waveform {0.000 5.000}
create_clock -period 10.000 -name clk_1 -waveform {0.000 5.000} [get_ports clk]
set_input_delay -clock [get_clocks clk_1] -min -add_delay 2.000 [get_ports {switch[*]}]
set_input_delay -clock [get_clocks clk_1] -max -add_delay 2.000 [get_ports {switch[*]}]
set_output_delay -clock [get_clocks clk_1] -min -add_delay 0.000 [get_ports messenger_clk]
set_output_delay -clock [get_clocks clk_1] -max -add_delay 2.000 [get_ports messenger_clk]
set_property PACKAGE_PIN T18 [get_ports {switch[0]}]
set_property PACKAGE_PIN R16 [get_ports {switch[1]}]
set_property PACKAGE_PIN H22 [get_ports {switch[2]}]
set_property PACKAGE_PIN F21 [get_ports {switch[3]}]
set_property PACKAGE_PIN H19 [get_ports {switch[4]}]
set_property PACKAGE_PIN H18 [get_ports {switch[5]}]
set_property PACKAGE_PIN H17 [get_ports {switch[6]}]
set_property PACKAGE_PIN M15 [get_ports {switch[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[2]}]
set_property IOSTANDARD LVTTL [get_ports {switch[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[6]}]