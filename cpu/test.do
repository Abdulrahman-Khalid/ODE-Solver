vsim work.timer_tb
add wave -position end  sim:/timer_tb/clk
add wave -position end  sim:/timer_tb/input
add wave -position end  sim:/timer_tb/enable
add wave -position end  sim:/timer_tb/output
run 600 ns