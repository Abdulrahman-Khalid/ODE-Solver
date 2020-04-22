vsim -gui work.io_receive
# vsim 
# Start time: 02:03:10 on Apr 22,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.io_receive(arch)
add wave -position insertpoint sim:/io_receive/*
force -freeze sim:/io_receive/RST 1 0
force -freeze sim:/io_receive/CLK 1 0, 0 {50 ns} -r 100
run
force -freeze sim:/io_receive/RST 0 0
force -freeze sim:/io_receive/Done_Row 1 0
force -freeze sim:/io_receive/Enable_Receiving_IO 1 0
force -freeze sim:/io_receive/CPU_Bus 00000008 0
run



force -freeze sim:/io_receive/Done_Row 0 0
force -freeze sim:/io_receive/CPU_Bus 30303030 0
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 300 ns  Iteration: 0  Instance: /io_receive
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 300 ns  Iteration: 0  Instance: /io_receive
run
run
run
run

