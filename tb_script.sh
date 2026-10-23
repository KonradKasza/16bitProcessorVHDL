ghdl -a --std=08 alu.vhd Rejestry.vhd busint.vhd control.vhd tb_procesor.vhd
ghdl -e --std=08 tb_procesor
ghdl -r --std=08 tb_procesor --vcd=tb_procesor.vcd
