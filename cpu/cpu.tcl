delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver/RAM/RAM2
force -deposit /CLK 1 0, 0 50 -r 100
force -deposit /RST 1
run 100
force -deposit /RST 0
force -deposit /INT 1
force -deposit /LoadProcess 1
run 100
force -deposit /INT 0
force -deposit /LoadProcess 0

proc bin_to_num { bin } {
    binary scan [binary format B* [format %032s $bin]] I val
    return $val
}

set inputFile ./input.json;
set outputFile ./output.txt;
############################## run c++ code #############################
exec make clean ;
#  "__________________________START ENCODING__________________________"
exec make;
#  "___________________________END ENCODING__________________________"
#########################################################################
exec ./cpu $inputFile $outputFile
set fp [open $outputFile r]
set DoneLoading [examine -binary sim:/ODE_Solver/DoneLoading]
force -deposit /Enable 1; # Enable IO signal
while { [gets $fp data] >= 0 } {
    set bin [string range $data 1 31]
    set firstPacketBitType [string index $data 0]
    set cpuToIoBus "$firstPacketBitType$bin"
    puts "packet size = [set packetSize [bin_to_num $bin]]"
    puts "Meta Data of Row CPU to IO: $cpuToIoBus"
    set row [list]
    # puts [string length $cpuToIoBus]
    #TODO SEND cpuToIoBus

    lappend row $cpuToIoBus
    ######################
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
        set i [expr {$i +1}]
    }
    set $rowLength [llength $row]
    puts "Row Buses count = $rowLength"
    puts "Sending..."
    set idx 0
    while { $idx < $rowLength } {
        set Done_Reading_Bus [examine -binary sim:/ODE_Solver/Done_Reading_Bus]
        if {$Done_Reading_Bus == 1} {
            force -freeze sim:/ODE_Solver/CPU_Bus [lindex $row $idx] 0
            incr idx
        } 
	    run 100
    }
    force -deposit /Done_Row 1
    run 100
    force -deposit /Done_Row 0
}
force -deposit /Enable 0
run 100
close $fp