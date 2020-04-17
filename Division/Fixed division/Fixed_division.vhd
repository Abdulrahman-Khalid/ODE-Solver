library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fixed_division is
    generic (N : integer := 16);
	port( Dividend : in std_logic_vector(N-1 downto 0);
		  Divisor : in std_logic_vector(N-1 downto 0);
	      Quotient : out std_logic_vector(N-1 downto 0);
		  ERR : out std_logic;
		  OverFlow : out std_logic);
end entity;

architecture arch of fixed_division is
	begin
		Quotient(N-1) <= Divisor(N-1) xor Dividend(N-1);
		 
		process (Divisor,Dividend)
		variable ERR_VAR : std_logic := '0';
		variable SHIFTING_IT : Integer := 0;
		variable D : std_logic_vector(N-2 downto 0);
		variable Z : std_logic_vector(N-2 downto 0);
		begin	
			-- If divisor == 0 then ERROR bit = 1
			l1 : for i in 0 to N-2 loop
				ERR_VAR := ERR_VAR or Divisor(i);
				if Divisor(i) = '1' then
					SHIFTING_IT := i; -- Calculating the index of the most 1 bit
				end if ;
			end loop ; -- l1
			-- Error bit
			ERR <= not ERR_VAR;	
			
			D(N-2 downto N-2-SHIFTING_IT) := Divisor(N-2 downto N-2-SHIFTING_IT);
			Z(N-2 downto N-2-SHIFTING_IT) := Dividend(SHIFTING_IT downto 0);
			l2 : for i in 0 to 10 loop
				
			end loop ; -- l2

		end process;
end architecture;