vsim -gui work.stepalgo 
add wave -position insertpoint sim:/stepalgo/*
force -freeze sim:/stepalgo/h_in 0000000010000000 0
force -freeze sim:/stepalgo/L 0000001000000000 0
force -freeze sim:/stepalgo/e 0000010100000000 0
force -freeze sim:/stepalgo/test 0000010100000000 0
force -freeze sim:/stepalgo/reset 1 0
force -freeze sim:/stepalgo/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/stepalgo/EN 1 0
run
force -freeze sim:/stepalgo/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run