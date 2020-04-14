LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use STD.TEXTIO.all;


ENTITY RAM IS
	GENERIC (word_size : integer := 32;
	         address_width: integer := 14;
		    RAM_size: integer := 16384); --2^14 slot
	PORT(	
		CLK, WR1,WR2,WRIO  : IN std_logic;
		address_Euler1,address_Euler2,address_IO: IN  std_logic_vector(address_width-1 DOWNTO 0);
		data_Euler2OUT : OUT  std_logic_vector(word_size-1 DOWNTO 0);
		data_Euler1,data_IO  : INOUT  std_logic_vector(word_size - 1 DOWNTO 0));
		
END ENTITY RAM;

ARCHITECTURE RAM_arch OF RAM IS
        type ram_type is array (0 to RAM_size-1) of std_logic_vector(word_size - 1 DOWNTO 0) ;
       


-------------------------------------------------------------------------------------------------------------------
	-- Initialise the RAM from text file 	
	SUBTYPE function_output is ram_type;
  	IMPURE FUNCTION init_RAM RETURN function_output is
		VARIABLE RAM_content : ram_type;
		VARIABLE text_line : line;
		VARIABLE count: integer;
		File RAM_file: TEXT open READ_MODE is "Ram.txt";
	BEGIN
		 count := 0;
  		 L1:WHILE not ENDFILE(RAM_file) LOOP
     			readline(RAM_file, text_line);
     			bread(text_line,RAM_content(count) );
			count := count + 1;
  		 END loop L1 ;
		 file_close(RAM_file);
  		 RETURN RAM_content;
		 
	END FUNCTION init_RAM;
-------------------------------------------------------------------------------------------------------------------
	shared variable RAM_data : ram_type:=init_RAM;

BEGIN
--init: RAM_data <= init_RAM;
PROCESS(CLK) IS
BEGIN
	IF falling_edge(CLK) THEN  
		IF WR1 = '1'  THEN
			RAM_data(to_integer(unsigned(address_Euler1))) := data_Euler1;
		end if;
        if WRIO ='1' THEN
		RAM_data(to_integer(unsigned(address_IO))) := data_IO;
		end if;
	END IF;
END PROCESS;
	process(CLK)IS
begin	
        IF WR1 = '0' THEN
        data_Euler1 <= RAM_data(to_integer(unsigned(address_Euler1)));
		elsif WR1 = 'U' or WR1 = 'X'  then
		data_Euler1 <=(others=>'Z');
		END IF;

        if WR2 ='0' THEN
        data_Euler2OUT <= RAM_data(to_integer(unsigned(address_Euler2)));
		elsif WR2 = 'U' or WR2 = 'X' or WR2 = '1' then
		data_Euler2OUT <= (others=>'Z');
		END IF;
		
		if WRIO ='0'  THEN
		data_IO <= RAM_data(to_integer(unsigned(address_IO)));
		elsif WRIO = 'U' or WRIO = 'X' then
		data_IO <=(others=>'Z');
		END IF;
	
end process;
END RAM_arch;