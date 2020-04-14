---------------------------------------Testbench------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use STD.TEXTIO.all;


ENTITY test_RAM IS
	GENERIC (word_size : integer := 32;
	         address_width: integer := 14;
		    RAM_size: integer := 16384); --2^14 slot		
END ENTITY test_RAM;



Architecture  ramTest of test_RAM is 
signal s_clk : std_logic:= '0';
signal 	s_WR1,s_WR2,s_WRIO,s_PORT1EN,s_PORT2EN,s_PORT3EN  :  std_logic;
signal	s_address_Euler1,s_address_Euler2,s_address_IO :std_logic_vector(address_width-1 DOWNTO 0);
signal	s_data_Euler1,s_data_Euler2OUT,s_data_IO  :std_logic_vector(word_size - 1 DOWNTO 0);
constant CLK_PERIOD :time :=10 ns;

component RAM2 is
GENERIC (word_size : integer := 32;
	         address_width: integer := 14;
		    RAM_size: integer := 16384); --2^14 slot
            PORT(	
                CLK, WR1,WR2,WRIO,PORT1EN,PORT2EN,PORT3EN  : IN std_logic;
                address_Euler1,address_Euler2,address_IO: IN  std_logic_vector(address_width-1 DOWNTO 0);
                data_Euler2OUT : OUT  std_logic_vector(word_size-1 DOWNTO 0);
                data_Euler1,data_IO  : INOUT  std_logic_vector(word_size - 1 DOWNTO 0));
                
end component;

begin

R1:RAM2 generic map(word_size=> 32,address_width=>14,RAM_size=>16384)  port map(CLK=>s_clk,WR1=>s_WR1,WR2=>s_WR2,WRIO=>s_WRIO,
PORT1EN=>s_PORT1EN,PORT2EN=>s_PORT2EN,PORT3EN=>s_PORT3EN
,address_Euler1=>s_address_Euler1,address_Euler2=>s_address_Euler2,address_IO=>s_address_IO
,data_Euler2OUT=>s_data_Euler2OUT,data_Euler1=>s_data_Euler1,data_IO=>s_data_IO);

process 
    begin
        s_clk <= '1';
        wait for CLK_PERIOD/2;
        s_clk <= '0';
        wait for CLK_PERIOD/2;
        
end process;
process 
    begin

    s_WR1<='1';
    s_PORT1EN <='1';
    s_PORT2EN <='0';
    s_PORT3EN <='0';
    s_address_Euler1 <= (std_logic_vector(to_unsigned(2,address_width)));
    s_data_Euler1 <= X"00000065";
    wait for CLK_PERIOD;
    
    s_WRIO<='1';
    s_PORT1EN <='0';
    s_PORT2EN <='0';
    s_PORT3EN <='1';
    s_address_IO <= (std_logic_vector(to_unsigned(3,address_width)));
    s_data_IO <= X"00000000";
    wait for CLK_PERIOD;


    s_WR2<='0';
    s_PORT1EN <='0';
    s_PORT2EN <='1';
    s_PORT3EN <='0';
    s_address_Euler2 <= (std_logic_vector(to_unsigned(3,address_width)));
    
    assert (s_data_Euler2OUT = X"00000000") report "error in Ram Read" severity error;
    assert (s_data_Euler1 /= X"00000000") report "error in Ram Read with no order" severity error;
    wait for CLK_PERIOD;
    

    s_WR2<='0';
    s_PORT1EN <='0';
    s_PORT2EN <='1';
    s_PORT3EN <='0';
    s_address_Euler2 <= (std_logic_vector(to_unsigned(2,address_width)));
    
    assert (s_data_Euler2OUT = X"00000065") report "error in Ram Read" severity error;
    assert (s_data_Euler1 /= X"00000065") report "error in Ram Read with no order" severity error;
    wait for CLK_PERIOD;
    
    s_WR2<='0';
    s_WR1<='0';
    s_PORT1EN <='1';
    s_PORT2EN <='1';
    s_PORT3EN <='0';
    s_address_Euler2 <= (std_logic_vector(to_unsigned(2,address_width)));
    s_address_Euler1 <= (std_logic_vector(to_unsigned(3,address_width)));
    
    assert (s_data_Euler2OUT = X"00000065" and s_data_Euler1 = X"00000065") report "error in Ram Read in 2 ports at same cycle" severity error;
    assert (s_data_IO /= X"00000065") report "error in Ram Read with no order" severity error;
    wait for CLK_PERIOD;
    


    
    wait ;   
    end process;

end Architecture;