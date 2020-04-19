delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver/RAM/RAM2
set time 0
set cycleTime 100
force -deposit /CLK 1 0, 0 [expr {$cycleTime/2}] -r $cycleTime
force -deposit /RST 1

run $cycleTime; set time [expr {$time + $cycleTime}];
force -deposit /RST 0
force -deposit /INT 1
force -deposit /LoadProcess 1
force -deposit /Enable 0
run $cycleTime; set time [expr {$time + $cycleTime}];
force -deposit /INT 0
force -deposit /LoadProcess 0

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
exec ./cpu $inputFile $outputFile
#  "___________________________END ENCODING__________________________"
#########################################################################
set fp [open $outputFile r]
force -deposit /Enable 1; # Enable IO signal
run $cycleTime; set time [expr {$time + $cycleTime}];
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
    set idx 0
    while { $idx < $rowLength } {
        set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
        if {$Done_Reading_Bus == 1} {
            force -freeze sim:/ODE_Solver/CPU_Bus [lindex $row $idx] 0
            incr idx
        } 
        run $cycleTime; set time [expr {$time + $cycleTime}];
    }
    force -deposit /Done_Row 1
    run $cycleTime; set time [expr {$time + $cycleTime}];
    force -deposit /Done_Row 0
}
force -deposit /Enable 0
run $cycleTime
run $cycleTime; set time [expr {$time + $cycleTime}];
puts "____________________________Waiting for the outcput____________________________"
set Result_Ready [examine -binary sim:/ODE_Solver/Result_Ready]
while {$Result_Ready == 0} {
    run $cycleTime; set time [expr {$time + $cycleTime}];
    set Result_Ready [examine -binary sim:/ODE_Solver/Result_Ready]
}
puts "_________________________________Output Ready_________________________________"
puts "_______________________________Output Meta Data_______________________________"
puts "From loading data inputs to output the results"
puts "It token the processor ($time ns) with ([expr {$time/$cycleTime}] cycles)"
puts "____________________________________Result___________________________________"
set resultVectorBus [list]
while {$Result_Ready == 1} {
    set ioToCpuBus [examine -binary sim:/ODE_Solver/CPU_Bus]
    lappend resultVectorBus $ioToCpuBus
    run $cycleTime; set time [expr {$time + $cycleTime}];
    set Result_Ready [examine -binary sim:/ODE_Solver/Result_Ready]
}
puts "Output : $resultVectorBus"
close $fp