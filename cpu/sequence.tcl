puts "start clk"
puts "RST -> 1"
puts "Run 100"
puts "RST -> 0"
puts "INT -> 1"
puts "LoadProcess -> 1"
puts "Enable -> 0"
puts "Run 100"
puts "INT -> 0"
puts "LoadProcess -> 0"

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
puts "Enable -> 1"
puts "Run 100"
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
    puts $row
    set rowLength [llength $row]
    puts "__________________________________________________________________"
    puts "Row Buses count = $rowLength"
    puts "Sending..."
    set idx 0
    while { $idx < $rowLength } {
        set cpuToIoBus [lindex $row $idx]
        puts "CPU to IO #[expr $idx+1] = $cpuToIoBus"
        incr idx
        puts "Run 100"
    }
    puts "Done_Row -> 1"
    puts "Run 100"
    puts "Done_Row -> 0"
    puts "__________________________________________________________________"
}
puts "Enable -> 0"
puts "Run 100"
close $fp
