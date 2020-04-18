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
	signal add1,add2,addOut : std_logic_vector(N-1 downto 0); 
	begin
		process is
		variable SHIFTING_IT : Integer := 0;
		variable Dividend2 : std_logic_vector(N-1 downto 0);
		variable Divisor2 : std_logic_vector(N-1 downto 0);
		variable QuotientTmp : std_logic_vector(N-1 downto 0);
		variable FIRST_ONE : std_logic;
		begin	
			-- Sign of the Quotient
			Quotient(N-1) <= Divisor(N-1) xor Dividend(N-1);
			-- Set Quotient to 0 at the begining
			Quotient(N-2 downto 0) <= (Others => '0');
			QuotientTmp(N-2 downto 0) := (Others => '0');
			-- If the divisor == 1 then the OP is the same and return
			if unsigned(Divisor) = 128 then
				Quotient(N-2 downto 0) <= Dividend (N-2 downto 0);
			-- If the divisor then ERROR bit = 1 then return
			elsif unsigned(Divisor(N-2 downto 0)) = 0 then
				ERR <= '1';
			-- Normal division
			else
				-- Calculating 2's complement for Dividend if it's negative
				FIRST_ONE := '0';
				if Dividend(N-1) = '1' then
					l1 : for i in 0 to N-1 loop
						if FIRST_ONE = '1' then
							Dividend2(i) := not Dividend(i);
						else
							Dividend2(i) := Dividend(i);
						end if ;
						if Dividend2(i) = '1' then
							FIRST_ONE := '1';
						end if ;
					end loop ; -- l1
				else
					Dividend2 := Dividend;
				end if ;
				-- Calculating 2's complement for Divisor if it's negative
				FIRST_ONE := '0';
				if Divisor(N-1) = '1' then
					l2 : for i in 0 to N-1 loop
						if FIRST_ONE = '1' then
							Divisor2(i) := not Divisor(i);
						else
							Divisor2(i) := Divisor(i);
						end if ;
						if Divisor(i) = '1' then
							FIRST_ONE := '1';
						end if ;
					end loop ; -- l2
				else
					Divisor2 := Divisor;
				end if ;

				l3 : for i in 0 to N-2 loop
					if Divisor2(i) = '1' then
						SHIFTING_IT := i; -- Calculating the index of the most 1 bit
					end if ;
				end loop ; -- l3
				
				
				-- Divide with long division
				l4 : for i in N-2 downto SHIFTING_IT loop
					report "The value of 'i' is " & integer'image(i);
					if unsigned(Dividend2(N-2 downto i - SHIFTING_IT)) >= unsigned(Divisor2(SHIFTING_IT downto 0)) then
						report "D5lt AWL IF";
						QuotientTmp(0) := '1';
						if i > SHIFTING_IT then
							report "D5lt TANI IF";
							add1(N-2-i+SHIFTING_IT downto 0) <= Dividend2(N-2 downto i - SHIFTING_IT);
							add1(N-1) <= '0';
							add2 <= not Divisor2;
							wait on addOut until FIRST_ONE = '1' for 10 ns;
							Dividend2(N-2 downto i - SHIFTING_IT) := addOut(N-2-i+SHIFTING_IT downto 0);
						end if ;
					else
					QuotientTmp(0) := '0';
					end if ;
					Quotient(N-2 downto 0) <= QuotientTmp(N-3 downto 0) & '0';
					QuotientTmp(N-2 downto 0) := QuotientTmp(N-3 downto 0) & '0';
				end loop ; -- l4


			end if ; 
			wait on Divisor,Dividend;
		end process;

		-- Port maping
		u1: entity work.Carry_Look_Ahead(Behavioral) port map (add1,add2,'1',addOut);
end architecture;