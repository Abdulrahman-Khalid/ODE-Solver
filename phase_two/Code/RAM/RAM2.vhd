LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use STD.TEXTIO.all;


ENTITY RAM2 IS
	GENERIC (word_size : integer := 32;
	         address_width: integer := 14;
		    RAM_size: integer := 16384); --2^14 slot
	PORT(	
		CLK, reset,WR1,WR2,WRIO,PORT1EN,PORT2EN,PORT3EN  : IN std_logic;
		address_Euler1,address_Euler2: IN  std_logic_vector(address_width-1 DOWNTO 0);
        address_IO :IN integer;
		data_Euler2OUT,data_Euler1OUT,data_IOOUT : OUT  std_logic_vector(word_size-1 DOWNTO 0);
		data_Euler1IN,data_IOIN  : IN  std_logic_vector(word_size - 1 DOWNTO 0));
		
END ENTITY RAM2;

ARCHITECTURE RAM_arch OF RAM2 IS
        type ram_type is array (0 to RAM_size-1) of std_logic_vector(word_size - 1 DOWNTO 0) ;
       


-------------------------------------------------------------------------------------------------------------------
shared variable RAM_data : ram_type:= (others => (others =>'0'));

BEGIN
process(CLK,PORT1EN,WR1,data_Euler1IN,address_Euler1)--for port 1  Euler 1 Read/Write port

begin 
if PORT1EN='1'  then
    if WR1 = '0' then
        data_Euler1OUT <= RAM_data(to_integer(unsigned(address_Euler1)));
    elsif (falling_edge(CLK)) then
        if(WR1='1')then 
        RAM_data(to_integer(unsigned(address_Euler1))) := data_Euler1IN;    
        elsif(reset ='1')then 
        data_Euler1OUT <=(others=>'0');
        end if;
    end if;    
else
    data_Euler1OUT <=(others=>'Z');
end if; 
end process;

process(CLK,PORT2EN,WR2,address_Euler2)--for port 2  Euler 2 Read only port
begin 
if(PORT2EN ='1') then
    if WR2 = '0' then
        data_Euler2OUT <= RAM_data(to_integer(unsigned(address_Euler2)));
    else 
        data_Euler2OUT <=(others=>'Z');
    end if;
    if(falling_edge(CLK) and reset ='1')then 
    data_Euler2OUT <=(others=>'0');
    end if;
else
    data_Euler2OUT <=(others=>'Z');          
end if;
end process;


process(CLK,PORT3EN,WRIO,data_IOIN,address_IO)--for port 3  IO Read/Write port
begin 

if PORT3EN='1'  then
    if WRIO = '0' then
        data_IOOUT <= RAM_data(address_IO);
    elsif (falling_edge(CLK) and WRIO ='1') then
        if(WRIO ='1')then 
        RAM_data(address_IO) := data_IOIN;    
        elsif(reset ='1') then 
        data_IOOUT<=(others=>'0');
        end if;  
    end if;  
else
    data_IOOUT <=(others=>'Z');
end if; 
end process;

end architecture;