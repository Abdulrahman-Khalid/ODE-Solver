library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity fixed_division is
    generic (N : integer := 16);
	port( Dividend : in std_logic_vector(N-1 downto 0);
		  Divisor : in std_logic_vector(N-1 downto 0);
		  Reset,clk : in std_logic;
		  Start : in std_logic;
	    	  Quotient : out std_logic_vector(N-1 downto 0);
		  ERR,Done : out std_logic;
		  OverFlow : out std_logic);
end entity;


architecture arch of fixed_division is
	signal add1,add2,addOut : std_logic_vector(N-1 downto 0);
	
	begin
		process (Reset,clk) is
		variable Index : integer;
		variable FIRST_ONE_DIVIDEND : integer;
		variable FIRST_ONE_DIVISOR : integer;
		variable Done_bit : std_logic ; 
		variable Dividend2 : std_logic_vector(N-1 downto 0);
		variable QuotientVar : std_logic_vector(N-1 downto 0);
		variable Divisor2 : std_logic_vector(2*N-3 downto 0);
		variable twosCompliment : std_logic_vector(N-2 downto 0);
		variable FIRST_ONE : std_logic;
		variable Q_FIRST_ONE : std_logic;

		begin	
			if Reset = '0' then
				if Done_bit = '1' and Start='1' then
					-- Initialization
					Done<='0';
					Err<='0';
					OverFlow<='0';
					Done_bit := '0';
					Index := N-2+N/2-1;
					--Index := 21;
					-- Sign of the Quotient
					QuotientVar(N-1) := Divisor(N-1) xor Dividend(N-1);
					--Quotient(N-1) <= Divisor(N-1) xor Dividend(N-1);
					QuotientVar(N-2 downto 0) := (Others => '0');
					Divisor2 := (Others => '0');
					-- If the divisor == 1 then the OP is the same and return or -- If the Dividend == 0 then the OP is 0 and return
					if unsigned(Divisor) = 128 or unsigned(Dividend(N-2 downto 0)) = 0  then
						QuotientVar(N-2 downto 0) := Dividend (N-2 downto 0);
						Quotient<=QuotientVar;
						Done <= '1';
						Done_bit := '1';
					-- If the divisor = 0 then ERROR bit = 1 then return
					elsif unsigned(Divisor(N-2 downto 0)) = 0 then
						ERR <= '1';						
						Done <= '1';
						Done_bit := '1';
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
									Divisor2(i + N - 2) := not Divisor(i);
								else
									Divisor2(i + N - 2) := Divisor(i);
								end if ;
								if Divisor(i) = '1' then
									FIRST_ONE := '1';
								end if ;
							end loop ; -- l2
						else
							Divisor2(2*N-3 downto N - 2) := Divisor;
						end if ;
					end if;
					------check overflow-------------
					FIRST_ONE_DIVISOR:=20; -- To handle if divisor is zero do not raise overflow
					FIRST_ONE_DIVIDEND:=0; -- to handle if dividend is zero
					l3 : for i in N-2 downto 0 loop
						if Divisor(i) = '1' then
							FIRST_ONE_DIVISOR:=i;
							exit;
						end if ;
					end loop ; -- l3
					
					l4 : for i in N-2 downto 0 loop
						if Dividend(i) = '1' then
							FIRST_ONE_DIVIDEND:=i;
							exit;
						end if ;
					end loop ; -- l4

					if(FIRST_ONE_DIVISOR<=N/2-2 and FIRST_ONE_DIVIDEND>N/2-2)then
						if(FIRST_ONE_DIVIDEND-FIRST_ONE_DIVISOR>=N/2)then
							Done <= '1';
							Done_bit := '1';
							OverFlow<='1';
						end if;
					end if;
					
					FIRST_ONE := '0';
				elsif Done_bit='0' then  -- Code loop
					-- Check if Dividend2 want to get value from adder
					if FIRST_ONE = '1' then
						Dividend2 := addOut;
						FIRST_ONE := '0';
					end if ;
					if unsigned(Dividend2) >= unsigned(Divisor2) and unsigned(Dividend2)/=0 then
						add1 <= Dividend2;
						add2 <= not Divisor2(N-1 downto 0);
						FIRST_ONE := '1';
						QuotientVar(Index) := '1';
					end if ;
					Divisor2 := '0' & Divisor2(2*(N-1)-1 downto 1);
					if Index = 0 then
						Done <= '1';
						Done_bit := '1';
						Q_FIRST_ONE:='0';
						Quotient(N-1)<=QuotientVar(N-1);
						if QuotientVar(N-1) = '1' then
							l5 : for i in 0 to N-2 loop
								if Q_FIRST_ONE = '1' then
									Quotient(i) <= not QuotientVar(i);
								else
									Quotient(i) <= QuotientVar(i);
								end if ;
								if QuotientVar(i) = '1' then
									Q_FIRST_ONE := '1';
								end if ;
							end loop ; -- l5
						else
							Quotient<=QuotientVar;
						end if;
					end if ;
					Index := Index - 1;
				end if ;	
			else 
				Done_bit:='1';	
			end if ;
		end process;

		-- Port maping
		u1: entity work.Carry_Look_Ahead(Behavioral) port map (add1,add2,'1',addOut);
end architecture;