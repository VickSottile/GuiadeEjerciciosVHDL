# Guia de VHDL - Circuitos Logicos Programables - CESE - UBA

## Estudiante: Victoria Soledad Sottile 

Resolucion de la guia de VHDL (CESE). Cada ejercicio reutiliza lo que se hizo en los anteriores.

## Estructura

- `src/` : codigo de los circuitos (el numero es el ejercicio)
- `tb/`  : testbenches
- `constraints/` : archivo .xdc de la Arty Z7-10 para el ej 18
- `compilar.do` : script para compilar todo en ModelSim

## Ejercicios

| Ej | Archivo | Testbench |
|----|---------|-----------|
| 1  | `01_sumador_1bit.vhd` | `tb_sumador_1bit` |
| 2  | `02_sumador_4bits.vhd` (usa el 1) | `tb_sumador_4bits` |
| 3  | `03_sumrest_4bits.vhd` (usa el 2) | `tb_sumrest_4bits` |
| 4  | `04_mux2x1.vhd` | `tb_mux2x1` |
| 5  | `05_ffd.vhd` | `tb_ffd` |
| 6  | `06_registro_desp_est.vhd` (usa el 5) | `tb_registro_desp` |
| 7  | `07_registro_desp_comp.vhd` | `tb_registro_desp` |
| 8  | `08_barrel_shifter.vhd` | `tb_barrel_shifter` |
| 9  | `09_barrel_shifter_mux.vhd` (usa el 4) | `tb_barrel_shifter` |
| 10 | `10_contador4_est.vhd` (usa el 5) | `tb_contador4` |
| 11 | `11_contador4_comp.vhd` | `tb_contador4` |
| 12 | `12_contador_n_est.vhd` (usa el 5) | `tb_contador_n` |
| 13 | `13_contador_n_comp.vhd` | `tb_contador_n` |
| 14 | `14_*.vhd` (registro, incrementador, comparador, contador BCD) | `tb_contador_bcd` |
| 15 | `15_contador_bcd_comp.vhd` | `tb_contador_bcd` |
| 16 | `16_contador_bcd4.vhd` (usa el 14) | `tb_contador_bcd4` |
| 17 | `17_gen_ena.vhd` | `tb_gen_ena` |
| 18 | `18_top_bcd_1seg.vhd` (usa el 17 y el 14) | `tb_top_bcd_1seg` |

Cuando dos ejercicios hacen lo mismo (estructural vs comportamiento) uso un solo testbench
que instancia los dos y los compara contra un modelo.

## Simular con ModelSim

Desde la consola de ModelSim, parado en la carpeta del proyecto:

```
do compilar.do
vsim work.tb_contador4
add wave -r /*
run -all
```

`compilar.do` compila todo en orden de dependencias (hay que respetarlo, si no `vcom`
no encuentra las entidades que se instancian). Los testbenches terminan solos con un `report`.
Si algo falla se imprime un `error` con el detalle.



## Notas

- El barrel shifter hace desplazamiento logico a la derecha (entran ceros).
- Placa: Arty Z7-10 (Vivado). Para el ej 18 el top es `top_bcd_1seg` y el archivo de pines
  es `constraints/arty_z7_10.xdc`:
  - `clk`: clock de 125 MHz (pin H16), por eso `F_CLK = 125_000_000` por defecto
  - `rst`: BTN0
  - `ena_gral`: SW0
  - `leds`: LD0 a LD3
- Botones, switches y leds de la Arty Z7 son activos en alto.
- Para el testbench del ej 18 uso `F_CLK = 4` para no simular demasiados ciclos.

