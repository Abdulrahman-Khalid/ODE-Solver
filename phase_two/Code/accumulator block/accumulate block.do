vsim -gui work.accumulator_block
# vsim -gui work.accumulator_block 
# Start time: 04:53:57 on Apr 24,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_bit(body)
# Loading ieee.numeric_bit_unsigned(body)
# Loading ieee.numeric_std(body)
# Loading work.accumulator_block(behavioral)
# Loading work.carry_look_ahead_generic(behavioral)
# Loading work.partial_full_adder(behavioral)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.reg(reg)
add wave -position insertpoint sim:/accumulator_block/*
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ESLAM ELECTRONICS  Hostname: DESKTOP-EKFC7R1  ProcessID: 6360
#           Attempting to use alternate WLF file "./wlftbq250y".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftbq250y
force -freeze sim:/accumulator_block/x 0000000000000011 0
force -freeze sim:/accumulator_block/y 0000000000000010 0
force -freeze sim:/accumulator_block/clr 1 0
force -freeze sim:/accumulator_block/load 1 0
run
force -freeze sim:/accumulator_block/clr 0 0
run
force -freeze sim:/accumulator_block/y 0000000000000001 0
run
force -freeze sim:/accumulator_block/y 0000000000000000 0
run
force -freeze sim:/accumulator_block/y 0000000000000011 0
run
force -freeze sim:/accumulator_block/y 1111111111111101 0
run
force -freeze sim:/accumulator_block/x 1111111111111111 0
run

