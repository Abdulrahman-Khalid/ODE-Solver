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
		process (Divisor,Dividend)
		variable SHIFTING_IT : Integer := 0;
		variable Dividend2 : std_logic_vector(N-2 downto 0);
		variable Divisor2 : std_logic_vector(N-2 downto 0);
		variable FIRST_ONE : std_logic;
		begin	
			-- If the divisor == 1 then the OP is the same and return
			if unsigned(Divisor(N-2 downto 0)) = 128 then
				Quotient(N-2 downto 0) <= Dividend (N-2 downto 0);
			-- If the divisor then ERROR bit = 1 then return
			elsif unsigned(Divisor(N-2 downto 0)) = 0 then
				ERR <= '1';
			-- Normal division
			else
				l1 : for i in 0 to N-2 loop
					if Divisor(i) = '1' then
						SHIFTING_IT := i; -- Calculating the index of the most 1 bit
					end if ;
				end loop ; -- l1


				-- Calculating 2's complement for Dividend if it's negative
				FIRST_ONE := '0';
				if Dividend(N-1) = '1' then
					l2 : for i in 0 to N-2 loop
						if FIRST_ONE = '1' then
							Dividend2(i) := not Dividend(i);
						else
							Dividend2(i) := Dividend(i);
						end if ;
						if Dividend2(i) = '1' then
							FIRST_ONE := '1';
						end if ;
					end loop ; -- l2
				else
					Dividend2 := Dividend(N-2 downto 0);
				end if ;
				-- Calculating 2's complement for Divisor if it's negative
				FIRST_ONE := '0';
				if Divisor(N-1) = '1' then
					l3 : for i in 0 to N-2 loop
						if FIRST_ONE = '1' then
							Divisor2(i) := not Divisor(i);
						else
							Divisor2(i) := Divisor(i);
						end if ;
						if Divisor(i) = '1' then
							FIRST_ONE := '1';
						end if ;
					end loop ; -- l3
				else
					Divisor2 := Divisor(N-2 downto 0);
				end if ;
				
				
				-- Divide with long division
				
				

			end if ; 
		end process;

		-- Sign of the Qoutient
		Quotient(N-1) <= Divisor(N-1) xor Dividend(N-1);

end architecture;