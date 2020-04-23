vsim -gui work.ode_solver
delete wave *
# add wave -unsigned *

# add wave -unsigned /ode_solver/mem1/RAM_data
add wave /ode_solver/io_recv/*

set numOfBuses 23
set numOfBusesSent 0
set exitCode 0

set time 0
set cycleTime 100
force -deposit /ode_solver/CLK 1 0, 0 [expr {$cycleTime/2}] -r $cycleTime
force -deposit /ode_solver/RST 1

run $cycleTime; set time [expr {$time + $cycleTime}];
force -deposit /ode_solver/RST 0
force -deposit /ode_solver/INT 1
force -deposit /ode_solver/load_process 1
force -deposit /ode_solver/Enable_Receiving_IO 0
run $cycleTime; set time [expr {$time + $cycleTime}];
force -deposit /ode_solver/INT 0
force -deposit /ode_solver/load_process 0

proc bin_to_num { bin } {
    binary scan [binary format B* [format %032s $bin]] I val
    return $val
}

set inputFile ./input.json;
set outputFile ./output.txt;
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
        if {$numOfBusesSent >= $numOfBuses} {
            set exitCode 1 
        }
        incr numOfBusesSent
        force -deposit /ode_solver/Done_Row 1
        force -freeze sim:/ODE_Solver/CPU_Bus 2'b[lindex $row $idx] 0
        run $cycleTime; set time [expr {$time + $cycleTime}];
        force -deposit /ode_solver/Done_Row 0
        incr idx
    }
    if { exitCode == 1} {
        break
    }
    # send packets as on bus
    while { $idx < $rowLength } {
        set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
        if {$Done_Reading_Bus == 1} {
            if {$numOfBusesSent >= $numOfBuses} {
                set exitCode 1 
            }
            incr numOfBusesSent
            force -freeze sim:/ODE_Solver/CPU_Bus 2'b[lindex $row $idx] 0
            incr idx
        }
        run $cycleTime; set time [expr {$time + $cycleTime}];
    }
    set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
    while { $Done_Reading_Bus == 0} {
        if {$numOfBusesSent >= $numOfBuses} {
            set exitCode 1 
        }
        incr numOfBusesSent
        run $cycleTime; set time [expr {$time + $cycleTime}];
        set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
    }
    if { exitCode == 1} {
        break
    }
}
force -freeze sim:/ODE_Solver/enable_output_IO 0 0; 

#TODO to be removed later
force -freeze sim:/ODE_Solver/enable_output_IO 1 0; 
########################