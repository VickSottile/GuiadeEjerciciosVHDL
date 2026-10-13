# Compilacion masiva para ModelSim
# En la consola de ModelSim:  do compilar.do
# (parado en la carpeta del proyecto)

vlib work
vmap work work

# ---- src (en orden de dependencias) ----
vcom src/01_sumador_1bit.vhd
vcom src/02_sumador_4bits.vhd
vcom src/03_sumrest_4bits.vhd
vcom src/04_mux2x1.vhd
vcom src/05_ffd.vhd
vcom src/06_registro_desp_est.vhd
vcom src/07_registro_desp_comp.vhd
vcom src/08_barrel_shifter.vhd
vcom src/09_barrel_shifter_mux.vhd
vcom src/10_contador4_est.vhd
vcom src/11_contador4_comp.vhd
vcom src/12_contador_n_est.vhd
vcom src/13_contador_n_comp.vhd
vcom src/14_comparador.vhd
vcom src/14_incrementador4.vhd
vcom src/14_registro_n.vhd
vcom src/14_contador_bcd_est.vhd
vcom src/15_contador_bcd_comp.vhd
vcom src/16_contador_bcd4.vhd
vcom src/17_gen_ena.vhd
vcom src/18_top_bcd_1seg.vhd

# ---- tb ----
vcom tb/tb_sumador_1bit.vhd
vcom tb/tb_sumador_4bits.vhd
vcom tb/tb_sumrest_4bits.vhd
vcom tb/tb_mux2x1.vhd
vcom tb/tb_ffd.vhd
vcom tb/tb_registro_desp.vhd
vcom tb/tb_barrel_shifter.vhd
vcom tb/tb_contador4.vhd
vcom tb/tb_contador_n.vhd
vcom tb/tb_contador_bcd.vhd
vcom tb/tb_contador_bcd4.vhd
vcom tb/tb_gen_ena.vhd
vcom tb/tb_top_bcd_1seg.vhd
