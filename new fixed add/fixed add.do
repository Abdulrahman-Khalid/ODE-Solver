vsim -gui work.fixed_add
# vsim -gui work.fixed_add 
# Start time: 21:32:48 on Mar 20,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.fixed_add(arch)
add wave -position insertpoint sim:/fixed_add/*
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ESLAM ELECTRONICS  Hostname: DESKTOP-EKFC7R1  ProcessID: 6360
#           Attempting to use alternate WLF file "./wlftzht8wb".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftzht8wb
force -freeze sim:/fixed_add/bin1 0101010101010101 0
force -freeze sim:/fixed_add/bin2 0011101010101001 0
run
force -freeze sim:/fixed_add/bin1 1101010101010101 0
force -freeze sim:/fixed_add/bin2 0011101010101001 0
run
force -freeze sim:/fixed_add/bin1 0101010101010101 0
force -freeze sim:/fixed_add/bin2 1011101010101001 0
run
force -freeze sim:/fixed_add/bin1 1101010101010101 0
force -freeze sim:/fixed_add/bin2 1011101010101001 0
run
force -freeze sim:/fixed_add/bin1 1101010101010101 0
force -freeze sim:/fixed_add/bin2 0101010101010101 0
run
force -freeze sim:/fixed_add/bin1 0000000001010000 0
force -freeze sim:/fixed_add/bin2 1111111110101111 0
run
force -freeze sim:/fixed_add/bin1 1111111111111111 0
force -freeze sim:/fixed_add/bin2 1111111111111111 0
run
force -freeze sim:/fixed_add/bin1 1000000000000000 0
force -freeze sim:/fixed_add/bin2 1000000000000000 0
run
force -freeze sim:/fixed_add/bin1 0000000000000000 0
force -freeze sim:/fixed_add/bin2 0000000000000000 0
run
force -freeze sim:/fixed_add/bin1 1111111000001111 0
force -freeze sim:/fixed_add/bin2 1010010111111111 0
run