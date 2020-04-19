library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity IO is
    generic (N : integer := 32);
    port( data_bus : inout std_logic_vector(N-1 downto 0);
    enable,clk,row_finished : in std_logic;
    hand_shaking : out std_logic);
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
    begin
        if enable = '1' then
            if state = '0' then
                state := '1';
                bit_value := packet_meta_data(N-1);
            else
                if row_finished = '1' then
                    state := '0';
                end if ;
                -- Adding data to know when data register will be ready to start transfering data to memory
                finished := add_out;
                add1 <= finished;
                add2 <= packet_meta_data(N/2-1 downto 0);

                if unsigned(finished) = N then
                    -- TODO: Code to transfere data to memory
                    hand_shaking <= '1';
                end if ;
                -- TODO: Filling data register code
            end if ;
        end if ;
    end process;


    u1: entity work.Carry_Look_Ahead(Behavioral) port map (add1,add2,'0',add_out);

end architecture;
