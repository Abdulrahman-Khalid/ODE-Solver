LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use STD.TEXTIO.all;


ENTITY RAM2 IS
	GENERIC (word_size : integer := 32;
	         address_width: integer := 14;
		    RAM_size: integer := 16384); --2^14 slot
	PORT(	
		CLK, WR1,WR2,WRIO,PORT1EN,PORT2EN,PORT3EN  : IN std_logic;
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
process(CLK,PORT1EN)--for port 1  Euler 1 Read/Write port

begin 
if PORT1EN='0'  then
    data_Euler1OUT <=(others=>'Z');
elsif(PORT1EN ='1') then
    if (CLK'event and CLK = '0') then
        if(WR1 ='1') then
            RAM_data(to_integer(unsigned(address_Euler1))) := data_Euler1IN;
        end if;
    end if;
    if WR1 = '0' then
        data_Euler1OUT <= RAM_data(to_integer(unsigned(address_Euler1)));
    end if;    
end if;
end process;

process(CLK,PORT2EN)--for port 2  Euler 2 Read only port
begin 
if PORT2EN='0'  then
    data_Euler2OUT <=(others=>'Z');
elsif(PORT2EN ='1') then
    if WR2 = '0' then
        data_Euler2OUT <= RAM_data(to_integer(unsigned(address_Euler2)));
    elsif WR2 ='1' then
        data_Euler2OUT <=(others=>'Z');
    end if;      
end if;
end process;


process(CLK,PORT3EN)--for port 3  IO Read/Write port
begin 
if PORT3EN='0'  then
    data_IOOUT <=(others=>'Z');
elsif(PORT3EN ='1') then
    if (CLK'event and CLK = '0') then
        if(WRIO ='1') then
            RAM_data(address_IO) := data_IOIN;
        end if;
    end if;
    if WRIO = '0' then
        data_IOOUT <= RAM_data(address_IO);
    end if;    
end if;
end process;
 
end architecture;