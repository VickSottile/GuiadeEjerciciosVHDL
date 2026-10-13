## Restricciones para el ej 18 (top_bcd_1seg) en la Arty Z7-10

## Clock de 125 MHz (el del PHY de ethernet)
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }]

## rst -> BTN0 (activo en alto)
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { rst }]

## ena_gral -> SW0
set_property -dict { PACKAGE_PIN M20 IOSTANDARD LVCMOS33 } [get_ports { ena_gral }]

## leds -> LD0 a LD3
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports { leds[0] }]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { leds[1] }]
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { leds[2] }]
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { leds[3] }]
