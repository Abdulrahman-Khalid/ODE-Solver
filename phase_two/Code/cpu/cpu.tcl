vsim -gui work.ode_solver
delete wave *

add wave /ode_solver/io_recv/*
add wave /ode_solver/io_send/*
# add wave -position end  /ode_solver/io_send/line__21/*

set time 0
set cycleTime 100
force -deposit /ode_solver/CLK 1 0, 0 [expr {$cycleTime/2}] -r $cycleTime
force -deposit /ode_solver/RST 1

run $cycleTime; set time [expr {$time + $cycleTime}];
force -deposit /ode_solver/RST 0
force -deposit /ode_solver/Enable_Receiving_IO 0
force -deposit /ode_solver/enable_output_IO 0
run $cycleTime; set time [expr {$time + $cycleTime}];

proc bin_to_num { bin } {
    binary scan [binary format B* [format %032s $bin]] I val
    return $val
}

set inputFile ../cpu/input.json;
set outputFile ../cpu/output.txt;
############################## run c++ code #############################
# exec make clean ;
# exec make;
#  "__________________________START ENCODING__________________________"
# exec ./cpu $inputFile $outputFile
#  "___________________________END ENCODING__________________________"
########################################################################
set fp [open $outputFile r]
force -deposit /Enable_Receiving_IO 1; # Enable IO signal
while { [gets $fp data] >= 0 } {
    set bin [string range $data 1 31]
    set firstPacketBitType [string index $data 0]
    set cpuToIoBus "$firstPacketBitType$bin"
    puts "packet size = [set packetSize [bin_to_num $bin]]"
    puts "Meta Data of Row CPU to IO: $cpuToIoBus"
    set row [list]
    lappend row $cpuToIoBus
    set len [string length $data]
    set startIndx 32
    set endIndx [expr { $startIndx + 31}]
    set i 1
    while {$endIndx < $len} {
        set cpuToIoBus [string range $data $startIndx $endIndx]
        puts "CPU to IO #$i = $cpuToIoBus"
        lappend row $cpuToIoBus
        set startIndx [expr {$endIndx + 1}] 
        set endIndx [expr {$startIndx + 31}] 
        incr i
    }
    set rowLength [llength $row]
    puts "Row Buses count = $rowLength"
    puts "Sending..."
    # send packet meta data
    set idx 0
    if { $idx < $rowLength } {
        force -deposit /ode_solver/Done_Row 1
        force -freeze sim:/ODE_Solver/CPU_Bus 2'b[lindex $row $idx] 0
        run $cycleTime; set time [expr {$time + $cycleTime}];
        force -deposit /ode_solver/Done_Row 0
        incr idx
    }
    # send packets as on bus
    while { $idx < $rowLength } {
        set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
        if {$Done_Reading_Bus == 1} {
            force -freeze sim:/ODE_Solver/CPU_Bus 2'b[lindex $row $idx] 0
            incr idx
        }
        run $cycleTime; set time [expr {$time + $cycleTime}];
    }
    set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
    while { $Done_Reading_Bus == 0} {
        run $cycleTime; set time [expr {$time + $cycleTime}];
        set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
    }
}
force -freeze sim:/ODE_Solver/Enable_Receiving_IO 0 0;
noforce sim:/ode_solver/CPU_Bus

force -deposit /ode_solver/INT 1
force -deposit /ode_solver/load_process 1
run $cycleTime; set time [expr {$time + $cycleTime}];

#TODO to be removed later
force -freeze sim:/ODE_Solver/enable_output_IO 1 0; 
########################
puts "____________________________Waiting for the outcput____________________________"
set Result_Ready [examine -binary sim:/ODE_Solver/enable_output_IO]
while {$Result_Ready == 0} {
    run $cycleTime; set time [expr {$time + $cycleTime}];
    set Result_Ready [examine -binary sim:/IO_Output/enable_output_IO]
}
puts "_________________________________Output Ready_________________________________"
puts "____________________________________Result___________________________________"
set Result_Ready [examine -binary sim:/ODE_Solver/enable_output_IO]
set done_output_data [examine -binary sim:/ODE_Solver/done_output_data]
set resultVectorBus [list]
set halfCycle [expr {$cycleTime/2}]
while {$Result_Ready == 1} {
    # run $halfCycle; set time [expr {$time + $halfCycle}];
    run $cycleTime; set time [expr {$time + $cycleTime}];
    set ioToCpuBus [examine -binary sim:/ODE_Solver/CPU_Bus]
    # run $halfCycle; set time [expr {$time + $halfCycle}];
    set Result_Ready [examine -binary sim:/ODE_Solver/enable_output_IO]
    set done_output_data [examine -binary sim:/ODE_Solver/done_output_data]
    if {$done_output_data == 1} {
        break
    }
    lappend resultVectorBus $ioToCpuBus
}
puts "_______________________________Output Meta Data_______________________________"
puts "From loading data inputs to output the results"
puts "It token the processor ($time ns) with ([expr {$time/$cycleTime}] cycles)"
puts "Output : $resultVectorBus"

set outputFile [open temp.txt w]
set i 0
set MS32 0
set LS32 0
set end [expr [llength $resultVectorBus]-1];
# output buses of IO output module in form of 64 bit in file called temp.txt 
while { $i < $end } {
    set MS32 [string range [lindex $resultVectorBus $i] 4 35]
    incr i
    set LS32 [string range [lindex $resultVectorBus $i] 4 35]
    incr i
    puts $outputFile "$MS32$LS32"
}
close $outputFile
close $fp
