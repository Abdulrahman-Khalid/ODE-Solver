library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



ENTITY reg is
GENERIC(N : INTEGER := 16);
PORT ( 
	D : IN std_logic_vector(N - 1 downto 0);
	load : IN std_logic;
	Clk : IN std_logic;
	Q : OUT std_logic_vector(N - 1 downto 0)
	 );
END reg;

ARCHITECTURE Behavioral of reg is
BEGIN
	PROCESS(clk,load)
	BEGIN
		IF(load='1' and clk='1') THEN
			Q <= D;
		END IF;
	END PROCESS;
END ARCHITECTURE;
