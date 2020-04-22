library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity IO_Output is
    generic (N : integer := 32;
            bus_bits: integer := 64;
            mem_address_bits : integer := 32);
    port(enable_output_IO, CLK,RST : in std_logic;
    end_T_address, end_Output_address : in integer;
    memory_data : in std_logic_vector(bus_bits-1 downto 0);
    CPU_Bus : inout std_logic_vector(N-1 downto 0);
    memory_address : out integer;
    done_processing : out std_logic);
end entity;

architecture arch of IO_Output is
    begin
    process (CLK) is 
    variable start_Output_address : integer; -- Ram 1
    variable Starting_T : integer; -- Ram 1
    variable Is_Completed_64_bit : std_logic;
    variable flip_to_output_address : std_logic; -- For getting the packet bit value 
    begin
        if RST = '1' then
            Starting_T := 5003;
            start_Output_address := 2503;
            flip_to_output_address := '0';
            Is_Completed_64_bit := '0';
            Done_Processing <= '0';
        end if ;
        if Enable_Output_IO = '1' and RST = '0' then
            if (rising_edge(clk)) then
                if(Starting_T <= end_T_address+1 and Is_Completed_64_bit = '0') then
                    -- Read from mem
                    memory_address <= Starting_T;
                    Starting_T := Starting_T + 1;
                else
                    -- Read from mem
                    flip_to_output_address := '1';
                end if;
                if(start_Output_address /= end_Output_address and flip_to_output_address = '1') then
                    memory_address <= start_Output_address;
                    -- Read from mem
                    start_Output_address := start_Output_address + 1;
                else
                    memory_address <= start_Output_address;
                    Done_Processing <= '1';
                end if;
                if Is_Completed_64_bit = '0' then
                    CPU_Bus <= memory_data(bus_bits-1 downto bus_bits/2);
                    Is_Completed_64_bit := '1';
                else
                    CPU_Bus <= memory_data(bus_bits/2-1 downto 0);
                    Is_Completed_64_bit := '0';
                end if ;
            end if;
        else
            Starting_T := 5003;
            start_Output_address := 2503;
            flip_to_output_address := '0';
        end if ;
    end process;

end architecture;
