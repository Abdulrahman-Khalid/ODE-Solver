library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity IO_Output is
    generic (N : integer := 32;
            bus_bits: integer := 64;
            mem_address_bits : integer := 32);
    port(enable_output_IO, CLK, RST : in std_logic;
    end_T_address, end_Output_address : in integer;
    memory_data : in std_logic_vector(bus_bits-1 downto 0);
    CPU_Bus : inout std_logic_vector(N-1 downto 0);
    memory_address : out integer;
    done_output_data : out std_logic);
end entity;

architecture arch of IO_Output is
    begin
    process (CLK) is 
    variable start_Output_address : integer; -- Ram 1
    variable start_T_address : integer; -- Ram 1
    variable state : std_logic_vector(1 downto 0);
    begin
        if RST = '1' then
            start_T_address := 5003;
            start_Output_address := 2503;
            state := "00";
            Done_output_data <= '0';
        elsif (Enable_Output_IO = '1') then
            if (rising_edge(clk) and state = "00") then
                if(start_T_address <= end_T_address) then
                    memory_address <= start_T_address;
                    start_T_address := start_T_address + 1;
                    Done_output_data <= '0';
                elsif(start_Output_address <= end_Output_address) then
                    memory_address <= start_Output_address;
                    start_Output_address := start_Output_address + 1;
                    Done_output_data <= '0';
                else
                    state := "10";
                    memory_address <= start_Output_address;
                    Done_output_data <= '0';
                end if;
            elsif(falling_edge(clk)) then
                if state = "00" then
                    CPU_Bus <= memory_data(bus_bits-1 downto bus_bits/2);
                    state := "01";
                    Done_output_data <= '0';
                elsif(state = "01") then
                    CPU_Bus <= memory_data((bus_bits/2)-1 downto 0);
                    state := "00";
                    Done_output_data <= '0';
                elsif(state = "10") then -- "10"
                    CPU_Bus <= memory_data((bus_bits/2)-1 downto 0);
                    state := "11";
                    Done_output_data <= '0';
                else
                    Done_output_data <='1';
                end if ;
            end if;
        else
            start_T_address := 5003;
            start_Output_address := 2503;
            state := "00";
            Done_output_data <= '0';
        end if ;
    end process;

end architecture;
