vsim -gui work.ram2
# vsim -gui work.ram2 
# Start time: 01:28:51 on Apr 17,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.ram2(ram_arch)
add wave -position insertpoint  \
sim:/ram2/word_size \
sim:/ram2/address_width \
sim:/ram2/RAM_size \
sim:/ram2/CLK \
sim:/ram2/WR1 \
sim:/ram2/WR2 \
sim:/ram2/WRIO \
sim:/ram2/PORT1EN \
sim:/ram2/PORT2EN \
sim:/ram2/PORT3EN \
sim:/ram2/address_Euler1 \
sim:/ram2/address_Euler2 \
sim:/ram2/address_IO \
sim:/ram2/data_Euler2OUT \
sim:/ram2/data_Euler1OUT \
sim:/ram2/data_IOOUT \
sim:/ram2/data_Euler1IN \
sim:/ram2/data_IOIN \
sim:/ram2/RAM_data
# (vsim-4077) Logging very large object: /ram2/RAM_data 
force -freeze sim:/ram2/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/ram2/PORT1EN 1 0
force -freeze sim:/ram2/PORT2EN 0 0
force -freeze sim:/ram2/PORT3EN 0 0
force -freeze sim:/ram2/address_Euler1 00000000000011 0
force -freeze sim:/ram2/data_Euler1IN 00000000111100001111000011110000 0
force -freeze sim:/ram2/WR1 1 0
run
noforce sim:/ram2/data_Euler1
force -freeze sim:/ram2/PORT1EN 0 0
force -freeze sim:/ram2/PORT2EN 1 0
force -freeze sim:/ram2/address_Euler2 00000000000011 0
force -freeze sim:/ram2/WR2 0 0
run
	force -freeze sim:/ram2/WRIO 0 0
	force -freeze sim:/ram2/PORT3EN 1 0
	force -freeze sim:/ram2/address_IO 00000000000011 0
run
force -freeze sim:/ram2/address_Euler1 00000000000010 0
force -freeze sim:/ram2/PORT1EN 1 0
force -freeze sim:/ram2/data_Euler1 11111100111100001111000011110000 0
force -freeze sim:/ram2/PORT3EN 1 0
force -freeze sim:/ram2/PORT1EN 1 0
force -freeze sim:/ram2/address_Euler2 00000000000100 0
force -freeze sim:/ram2/WR2 1 0
force -freeze sim:/ram2/WR2 0 0
force -freeze sim:/ram2/WRIO 1 0
force -freeze sim:/ram2/address_IO 00000000000111 0
force -freeze sim:/ram2/data_IO 00000000111100001111000011110000 0
run
force -freeze sim:/ram2/PORT3EN 0 0
noforce sim:/ram2/data_IO
noforce sim:/ram2/data_Euler1
force -freeze sim:/ram2/PORT1EN 1 0
force -freeze sim:/ram2/WR1 0 0
run
force -freeze sim:/ram2/PORT2EN 0 0
force -freeze sim:/ram2/address_Euler1 00000000000111 0
run
force -freeze sim:/ram2/PORT2EN 1 0
force -freeze sim:/ram2/address_Euler1 00000000000110 0
force -freeze sim:/ram2/address_Euler2 00000000000111 0
run
force -freeze sim:/ram2/WR1 1 0
force -freeze sim:/ram2/address_Euler2 00000000000100 0
run
run
force -freeze sim:/ram2/data_Euler1 00011111000000000000000000000000 0
run