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
    signal add1,add2,add_out : std_logic_vector(N-1 downto 0);
    begin
    process (clk) is 
    variable state : std_logic := '0'; -- Equals to '0' to get packet info else getting compressed data
    variable packet_meta_data : std_logic_vector (N-1 downto 0); -- Containg packet size (N-2 downto 0) , First packet starting bit (N-1)
    variable data : std_logic_vector (N-1 downto 0); -- Containing the 32-bit data
    variable finished : std_logic_vector(N/2-1 downto 0); -- To check if we got all the 32 bits or not
    variable bit_value : std_logic; -- For getting the packet bit value 
    variable number_of_bits : std_logic_vector(N/2-1 downto 0); -- Holding number of bits of each packet for decomprission
    variable next_starting_index : integer; -- Holding starting bit index + 1 of the next packet
    begin
        if enable = '1' then
            if (rising_edge(clk)) then
                if state = '0' then
                    packet_meta_data := CPU_Bus;
                    state := '1';
                    bit_value := packet_meta_data(N-1);
                    finished := std_logic_vector(to_unsigned(0,N/2-1));
                    next_starting_index := N;
                else
                    if Done_Row = '1' then
                        state := '0';
                        -- For the last packet if we want to send only 16 bit in last packet
                        if unsigned(finished) = N/2 then 
                            Memory_Bus <= data;
                            Memory_WR_Enable <= '1';
                        end if ;
                    end if ;
                    -- Adding data to know when data register will be ready to start transfering data to memory
                    finished := add_out;
                    -- If the 32 bit finished then out data to memory and get new data from CPU bus
                    if unsigned(finished) = N then 
                        Memory_Bus <= data;
                        Memory_WR_Enable <= '1';
                        Done_Reading_Bus <= '1';
                        finished := std_logic_vector(to_unsigned(0,N/2-1)); 
                    end if ;

                    -- TODO: Filling data register code
                    number_of_bits := (Others => '0');
                    l1 : for i in N-1 downto 0 loop
                        -- Loop from beginning of the packet and end with its size
                        if next_starting_index > i and next_starting_index - unsigned(packet_meta_data(N-2 downto 0)) <= i then
                            number_of_bits(to_integer(unsigned(packet_meta_data(N-2 downto 0)))-(next_starting_index-i-1)) := CPU_Bus(i);
                        end if ;
                    end loop ; -- l1
                    -- Setting operands of the adder
                    add1 <= finished;
                    add2 <= packet_meta_data(N/2-1 downto 0);
                end if ;
            end if;
        end if ;
    end process;


    u1: entity work.Carry_Look_Ahead(Behavioral) port map (add1,add2,'0',add_out);

end architecture;
