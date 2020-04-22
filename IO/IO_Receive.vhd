library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity IO_Receive is
    generic (CPU_Bus_Width : integer := 32);
    port(CPU_Bus : inout std_logic_vector(CPU_Bus_Width-1 downto 0);
    Enable_Receiving_IO, CLK, Done_Row,RST : in std_logic;
    Done_Reading_Bus : out std_logic;
    Memory_Data_Bus : out std_logic_vector(2*CPU_Bus_Width-1 downto 0);
    Memory_Address_Bus : out integer;
    Memory1_WR_Enable, Memory2_WR_Enable : out std_logic);
end entity;


architecture arch of IO_Receive is
    constant First_3_Lines : integer := 0; -- Ram 1
    constant Starting_A : integer := 3; -- Ram 1
    constant Starting_X0 : integer := 2503; -- Ram 1
    constant Starting_T : integer := 5003; -- Ram 1
    constant Starting_B : integer := 0; -- Ram 2
    constant Starting_U : integer := 2500; -- Ram 2
    begin
    process (clk) is 

    variable packet_meta_data : std_logic_vector (CPU_Bus_Width-1 downto 0); -- Containg packet size (N-2 downto 0) , First packet starting bit (N-1)
    variable data : std_logic_vector (2*CPU_Bus_Width-1 downto 0); -- Containing the 64-bit data
    variable bit_value : std_logic; -- For getting the packet bit value 
    variable number_of_bits : std_logic_vector(CPU_Bus_Width-1 downto 0); -- Holding number of bits of each packet for decomprission
    variable remaining_number_of_bits : integer;
    variable next_starting_index,next_starting_index_tmp : integer; -- Holding starting bit index + 1 of the next packet
    variable data_bit_index : integer; -- Holding index of the bit to be changed in data variable
    variable ram_address_var : integer; -- Holding ram address to be written in
    variable input_data_state : std_logic_vector(2 downto 0) := "111"; -- "000" => the first row in ram1,"001" => for the second and third rows ram1,"010" => A, "011" => B, "100" => X, "101" => T, "110" => U
    variable N : unsigned(5 downto 0); -- Holding N value
    variable M : unsigned(5 downto 0); -- Holding M value
    variable T : unsigned(48 downto 0); -- Holding T value

    begin
        if RST = '1' then
            input_data_state := "111";
            ram_address_var := First_3_Lines;
        end if ;
        if Enable_Receiving_IO = '1' and RST = '0' then
            if (rising_edge(clk)) then
                if Done_Row = '1' then
                    packet_meta_data := CPU_Bus;
                    bit_value := packet_meta_data(CPU_Bus_Width-1);
                    next_starting_index := CPU_Bus_Width;
                    data_bit_index := 2*CPU_Bus_Width;
                    Done_Reading_Bus <= '1';
                    remaining_number_of_bits := 0;
                    
                    -- Changing to different inputs A,B,U,T,X
                    if input_data_state = "111" then
                        input_data_state := "000";
                        ram_address_var := First_3_Lines;
                    elsif input_data_state = "001" then
                        input_data_state := "010";
                        ram_address_var := Starting_A;
                    elsif input_data_state = "010" and ram_address_var = N*N+Starting_A then
                        input_data_state := "011";
                        ram_address_var := Starting_B;
                    elsif input_data_state = "011" and ram_address_var = N*M+Starting_B then
                        input_data_state := "100";
                        ram_address_var := Starting_X0;
                    elsif input_data_state = "100" and ram_address_var = T+Starting_X0 then
                        input_data_state := "101";
                        ram_address_var := Starting_T;
                    elsif input_data_state = "101" then
                        input_data_state := "110";
                        ram_address_var := Starting_U;
                    else
                        input_data_state := "111";
                        ram_address_var := First_3_Lines;
                    end if ;

                else
                    Done_Reading_Bus <= '0';
                    -- If the 32 bit data_bit_index then out data to memory and get new data from CPU bus
                    -- OR
                    -- If it's an empty package then the row has ended
                    if data_bit_index = 0 or unsigned(number_of_bits) = 0  or Done_Row = '1' then 
                        -- To store N in case of getting the first row of ram 1
                        if input_data_state = "000" then
                            N := unsigned(data(5 downto 0));
                            M := unsigned(data(11 downto 6));
                            T := unsigned(data(63 downto 15));
                            input_data_state := "001";
                        end if ;
                        Memory_Data_Bus <= data;
                        data := (Others => '0');
                        Memory_Address_Bus <= ram_address_var;
                        -- Select memory 2 if it was B or U data , else select memory 1
                        if input_data_state = "100" or input_data_state = "111" then
                            Memory2_WR_Enable <= '1';
                            Memory1_WR_Enable <= '0';
                        else
                            Memory1_WR_Enable <= '1';
                            Memory2_WR_Enable <= '0';
                        end if ;
                        data_bit_index := 2*CPU_Bus_Width;
                        ram_address_var := ram_address_var + 1; 
                    end if ;

                    if next_starting_index = 0 and remaining_number_of_bits = 0 then
                        Done_Reading_Bus <= '1';
                        next_starting_index := CPU_Bus_Width;
                    end if ;

                    
                    if unsigned(number_of_bits) = 0 then
                        Done_Reading_Bus <= '1';
                        next_starting_index := CPU_Bus_Width;
                    end if ;


                    if remaining_number_of_bits = 0 then
                        -- This loop puts number of packet bits in number_of_bits
                        number_of_bits := (Others => '0');
                        l1 : for i in CPU_Bus_Width-1 downto 0 loop
                            -- Loop from beginning of the packet and end with its size
                            if next_starting_index > i and next_starting_index - unsigned(packet_meta_data(CPU_Bus_Width-2 downto 0)) <= i then
                                number_of_bits(to_integer(unsigned(packet_meta_data(CPU_Bus_Width-2 downto 0)))-(next_starting_index-i)) := CPU_Bus(i);
                                next_starting_index_tmp := i; -- next_starting_index_tmp = next_starting_index - unsigned(packet_meta_data(N-2 downto 0)) to be used next time
                            end if ;
                        end loop ; -- l1
                        next_starting_index := next_starting_index_tmp;
                        remaining_number_of_bits := to_integer(unsigned(number_of_bits));
                    else
                        number_of_bits := std_logic_vector(to_unsigned(remaining_number_of_bits, CPU_Bus_Width));
                    end if ;

                    
                    l2 : for i in CPU_Bus_Width-1 downto 0 loop
                        if unsigned(number_of_bits) > i then
                            remaining_number_of_bits := remaining_number_of_bits - 1;
                            data(data_bit_index - 1) := bit_value;
                            data_bit_index := data_bit_index - 1;
                            -- If we still have bits from the previous packet
                            if data_bit_index = 0 then
                                -- To store N in case of getting the first row of ram 1
                                if input_data_state = "000" then
                                    N := unsigned(data(5 downto 0));
                                    M := unsigned(data(11 downto 6));
                                    T := unsigned(data(63 downto 15));
                                    input_data_state := "001";
                                end if ;
                                Memory_Data_Bus <= data;
                                data := (Others => '0');
                                Memory_Address_Bus <= ram_address_var;
                                -- Select memory 2 if it was B or U data , else select memory 1
                                if input_data_state = "100" or input_data_state = "111" then
                                    Memory2_WR_Enable <= '1';
                                    Memory1_WR_Enable <= '0';
                                else
                                    Memory1_WR_Enable <= '1';
                                    Memory2_WR_Enable <= '0';
                                end if ;
                                data_bit_index := 2*CPU_Bus_Width;
                                ram_address_var := ram_address_var + 1;
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
