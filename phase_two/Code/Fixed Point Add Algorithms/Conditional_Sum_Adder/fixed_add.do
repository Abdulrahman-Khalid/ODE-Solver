vsim -gui work.Addition1(arch1)
add wave -position insertpoint sim:/Addition1/*

force -freeze sim:/Addition1/A 0011 0
force -freeze sim:/Addition1/B 0020 0
force -freeze sim:/Addition1/Cin 0 0
run

force -freeze sim:/Addition1/A 0400 0
force -freeze sim:/Addition1/B 0B54 0
force -freeze sim:/Addition1/Cin 0 0
run

force -freeze sim:/Addition1/A 1111 0
force -freeze sim:/Addition1/B 1111 0
force -freeze sim:/Addition1/Cin 1 0
run
