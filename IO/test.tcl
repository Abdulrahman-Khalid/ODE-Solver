vsim -gui work.ODE_Solver
add wave -position insertpoint sim:/IO_Receive/*
force -freeze sim:/ODE_Solver/CPU_Bus 00000008 0
force -freeze sim:/ODE_Solver/Enable_Receiving_IO 1 0
force -freeze sim:/ODE_Solver/CLK 1 0, 0 {50 ns} -r 100
run
force -freeze sim:/ODE_Solver/CPU_Bus 0a0a0a0a 0
run 1300
force -freeze sim:/ODE_Solver/CPU_Bus 0a0a0000 0
force -freeze sim:/ODE_Solver/CPU_Bus 20 0
force -freeze sim:/ODE_Solver/Done_Row 1 0
run
force -freeze sim:/ODE_Solver/Done_Row 0 0
run 400