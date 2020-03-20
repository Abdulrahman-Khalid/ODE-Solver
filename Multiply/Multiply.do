vsim -gui work.Multiplication(arch)
add wave -position insertpoint sim:/Multiplication/*

force -freeze sim:/Multiplication/A 0011 0
force -freeze sim:/Multiplication/B 0020 0
run
force -freeze sim:/Multiplication/A 0400 0
force -freeze sim:/Multiplication/B 0B54 0
run
