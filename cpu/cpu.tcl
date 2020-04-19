proc bin_to_num { bin } {
    binary scan [binary format B* [format %032s $bin]] I val
    return $val
}

set inputFile ./input.json;
set outputFile ./output.txt;
# run c++ code
exec make clean ;
exec make;
exec ./cpu $inputFile $outputFile
# puts "__________________________START ENCODING__________________________"
# puts $file_data
# puts "___________________________END ENCODING__________________________"
#  read the file one line at a time
set fp [open $outputFile r]
while { [gets $fp data] >= 0 } {
    set bin [string range $data 1 31]
    set firstPacketBitType [string index $data 0]
    set cpuToIoBus "$firstPacketBitType$bin"
    puts "packet size = [set packetSize [bin_to_num $bin]]"
    puts "Meta Data of Row CPU to IO: $cpuToIoBus"
    # puts [string length $cpuToIoBus]
    #TODO SEND cpuToIoBus

    ######################
    set len [string length $data]
    set startIndx 32
    set endIndx [expr { $startIndx + 31}]
    set i 1
    while {$endIndx < $len} {
        set cpuToIoBus [string range $data $startIndx $endIndx]
        puts "CPU to IO #$i = $cpuToIoBus"
        # puts [string length $cpuToIoBus]
        #TODO SEND Packet
        ################
        set startIndx [expr {$endIndx + 1}] 
        set endIndx [expr {$startIndx + 31}] 
        set i [expr {$i +1}]
    }
    #TODO send packet bin to IO
    
    #TODO send packet bin to IO
}
close $fp
# set triggerVal [examine /trigger]


