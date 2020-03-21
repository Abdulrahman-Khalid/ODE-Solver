vsim work.fixed_addition
add wave -position end  sim:/fixed_addition/A
add wave -position end  sim:/fixed_addition/B
add wave -position end  sim:/fixed_addition/output
add wave -position end  sim:/fixed_addition/overFlow
add wave -position end  sim:/fixed_addition/result
force -freeze sim:/fixed_addition/A 0101010101010101 0
force -freeze sim:/fixed_addition/B 0011101010101001 0
run
force -freeze sim:/fixed_addition/A 1101010101010101 0
force -freeze sim:/fixed_addition/B 0011101010101001 0
run
force -freeze sim:/fixed_addition/A 0101010101010101 0
force -freeze sim:/fixed_addition/B 1011101010101001 0
run
force -freeze sim:/fixed_addition/A 1101010101010101 0
force -freeze sim:/fixed_addition/B 1011101010101001 0
run
force -freeze sim:/fixed_addition/A 1101010101010101 0
force -freeze sim:/fixed_addition/B 0101010101010101 0
run
force -freeze sim:/fixed_addition/A 0000000001010000 0
force -freeze sim:/fixed_addition/B 1111111110101111 0
run
force -freeze sim:/fixed_addition/A 1111111111111111 0
force -freeze sim:/fixed_addition/B 1111111111111111 0
run
force -freeze sim:/fixed_addition/A 1000000000000000 0
force -freeze sim:/fixed_addition/B 1000000000000000 0
run
force -freeze sim:/fixed_addition/A 0000000000000000 0
force -freeze sim:/fixed_addition/B 0000000000000000 0
run
force -freeze sim:/fixed_addition/A 1111111000001111 0
force -freeze sim:/fixed_addition/B 1010010111111111 0
run