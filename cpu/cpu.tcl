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
    set startIndx 0
    set endIndx 31
    # puts $data
    # set i 0
    set bin [string range $data $startIndx $endIndx]
    puts "packet size = [set packetSize [bin_to_num $bin]]"
    #TODO SEND Packet Size

    ######################
    set len [string length $data]
    set startIndx [expr {$endIndx + 1}]
    set endIndx [expr {$endIndx + $packetSize}]
    set i 1
    while {$endIndx < $len} {
        set packet [string range $data $startIndx $endIndx]
        puts "packet #$i = $packet"
        #TODO SEND Packet

        ################
        set startIndx [expr {$startIndx + $packetSize}] 
        set endIndx [expr {$endIndx + $packetSize}] 
        set i [expr {$i +1}]
    }
    #TODO send packet bin to IO
    
    #TODO send packet bin to IO
}
close $fp
# set triggerVal [examine /trigger]


