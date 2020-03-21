vsim work.phase_one_tb
add wave -position end  sim:/phase_one_tb/clk
add wave -position end  sim:/phase_one_tb/A
add wave -position end  sim:/phase_one_tb/B
add wave -position end  sim:/phase_one_tb/add_output
add wave -position end  sim:/phase_one_tb/mult_output
add wave -position end  sim:/phase_one_tb/add_overflow
add wave -position end  sim:/phase_one_tb/mult_overflow
run 200 ns