vsim -gui work.fixed_add
# vsim -gui work.fixed_add 
# Start time: 23:13:45 on Mar 19,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.fixed_add(arch)
add wave -position insertpoint sim:/fixed_add/*
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ESLAM ELECTRONICS  Hostname: DESKTOP-EKFC7R1  ProcessID: 6360
#           Attempting to use alternate WLF file "./wlftii9azi".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftii9azi
force -freeze sim:/fixed_add/bin1 1100110110001101 0
force -freeze sim:/fixed_add/bin2 1111000010111001 0
run
force -freeze sim:/fixed_add/bin1 0000111111100110 0
force -freeze sim:/fixed_add/bin2 0001111111111111 0
run
force -freeze sim:/fixed_add/bin1 1100111111100110 0
force -freeze sim:/fixed_add/bin2 0001111111111111 0
run
