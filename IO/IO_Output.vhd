library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity IO_Output is
    generic (N : integer := 32, bus_bits: integer := 64, mem_address_bits := 32);
    port(enable_output_IO, CLK : in std_logic;
    end_T_address, end_Output_address : in std_logic_vector(mem_address_bits-1 downto 0);
    memory_data : in std_logic_vector(bus_bits-1 downto 0);
    CPU_Bus : inout std_logic_vector(N-1 downto 0);
    memory_address : out std_logic_vector(mem_address_bits-1 downto 0);
    memory_read_enable, done_processing : out std_logic);
end entity;

architecture arch of IO_Output is
    begin
    process (CLK) is 

    variable start_T_address : std_logic_vector (N-1 downto 0) := x"9C7"; -- 2503
    variable start_Output_address : std_logic_vector (N-1 downto 0) := x"9C7"; -- Containg packet size (N-2 downto 0) , First packet starting bit (N-1)
    variable flip_to_output_address : std_logic := '0'; -- For getting the packet bit value 
    begin
        if Enable_Output_IO = '1' and (not done) then
            if (rising_edge(clk)) then
                memory_read_enable <= '1';
                if(start_T_address /= end_T_address) then
                    Done_Processing <= '0';
                    -- Read from mem
                    start_T_address := start_T_address + 1;
                else
                    Done_Processing <= '0';
                    -- Read from mem
                    flip_to_output_address := '1';
                end if;
                if(start_T_address /= end_Output_address) then
                    Done_Processing <= '0';
                    -- Read from mem
                    start_Output_address := start_Output_address + 1;
                else
                    Done_Processing <= '1';
                end if;
            end if;
        else
            start_T_address := x"9C7";
            start_Output_address := x"9C7";
            memory_read_enable <= '0';
            flip_to_output_address := '0';
        end if ;
    end process;

end architecture;
