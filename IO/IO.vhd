library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity IO is
    generic (N : integer := 32);
    port( CPU_Bus : inout std_logic_vector(N-1 downto 0);
    Enable,CLK,Done_Row : in std_logic;
    Done_Reading_Bus : out std_logic;
    Memory_Bus : out std_logic_vector(N-1 downto 0);
    Memory_WR_Enable : out std_logic);
end entity;


architecture arch of IO is
    begin
    process (clk) is 

    variable packet_meta_data : std_logic_vector (N-1 downto 0); -- Containg packet size (N-2 downto 0) , First packet starting bit (N-1)
    variable data : std_logic_vector (N-1 downto 0); -- Containing the 32-bit data
    variable bit_value : std_logic; -- For getting the packet bit value 
    variable number_of_bits : std_logic_vector(N-1 downto 0); -- Holding number of bits of each packet for decomprission
    variable remaining_number_of_bits : integer;
    variable next_starting_index,next_starting_index_tmp : integer; -- Holding starting bit index + 1 of the next packet
    variable data_bit_index : integer; -- Holding index of the bit to be changed in data variable

    begin
        if enable = '1' then
            if (rising_edge(clk)) then
                if Done_Row = '1' then
                    packet_meta_data := CPU_Bus;
                    bit_value := packet_meta_data(N-1);
                    next_starting_index := N;
                    data_bit_index := N;
                    Done_Reading_Bus <= '1';
                    remaining_number_of_bits := 0;
                else
                    Done_Reading_Bus <= '0';
                    -- If the 32 bit data_bit_index then out data to memory and get new data from CPU bus
                    -- OR
                    -- If it's an empty package then the row has ended
                    if data_bit_index = 0 or unsigned(number_of_bits) = 0  or Done_Row = '1' then 
                        Memory_Bus <= data;
                        data := (Others => '0');
                        Memory_WR_Enable <= '1';
                        data_bit_index := N; 
                    end if ;

                    if next_starting_index = 0 then
                        if  remaining_number_of_bits = 0 then
                            Done_Reading_Bus <= '1';
                            next_starting_index := N;
                        end if ;
                    end if ;

                    
                    if unsigned(number_of_bits) = 0 then
                        Done_Reading_Bus <= '1';
                        next_starting_index := N;
                    end if ;


                    if remaining_number_of_bits = 0 then
                        -- This loop puts number of packet bits in number_of_bits
                        number_of_bits := (Others => '0');
                        l1 : for i in N-1 downto 0 loop
                            -- Loop from beginning of the packet and end with its size
                            if next_starting_index > i and next_starting_index - unsigned(packet_meta_data(N-2 downto 0)) <= i then
                                number_of_bits(to_integer(unsigned(packet_meta_data(N-2 downto 0)))-(next_starting_index-i)) := CPU_Bus(i);
                                next_starting_index_tmp := i; -- next_starting_index_tmp = next_starting_index - unsigned(packet_meta_data(N-2 downto 0)) to be used next time
                            end if ;
                        end loop ; -- l1
                        next_starting_index := next_starting_index_tmp;
                        remaining_number_of_bits := to_integer(unsigned(number_of_bits));
                    else
                        number_of_bits := std_logic_vector(to_unsigned(remaining_number_of_bits, N));
                    end if ;

                    
                    l2 : for i in N-1 downto 0 loop
                        if unsigned(number_of_bits) > i then
                            remaining_number_of_bits := remaining_number_of_bits - 1;
                            data(data_bit_index - 1) := bit_value;
                            data_bit_index := data_bit_index - 1;
                            -- If we still have bits from the previous packet
                            if data_bit_index = 0 then
                                Memory_Bus <= data;
                                data := (Others => '0');
                                Memory_WR_Enable <= '1';
                                data_bit_index := N;
                            end if ;
                        end if ;
                    end loop ; -- l2
                    
                    if remaining_number_of_bits = 0 then
                        bit_value := not bit_value;
                    end if ;
                    
                end if ;
            end if;
        end if ;
    end process;

end architecture;
