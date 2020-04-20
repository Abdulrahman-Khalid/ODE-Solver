library ieee;
use ieee.std_logic_1164.all;

Entity M1Add1Mux is
	generic (num : integer := 16);
	port( N, A, Ti, Xstore, Tnum: IN std_logic_vector (num-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      Add:      OUT std_logic_vector (num-1 downto 0));
end  M1Add1Mux;

Architecture behavioral of M1Add1Mux is

begin
	process (selector)
		begin 
			if selector = "001" then Add <= N; 
			elsif selector = "011" then Add <= Ti;
			elsif selector = "100" then Add <= A;
			elsif selector = "110" then Add <= Xstore;
			elsif selector = "010" then Add <= Tnum;
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;

Entity M1Add2Mux is
	generic (n : integer := 16);
	port(M, Xn, Xprev : IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      Add:      OUT std_logic_vector (n-1 downto 0));
end  M1Add2Mux;

Architecture behavioral of M1Add2Mux is

begin
	process (selector)
		begin 
			if selector = "001" then Add <= M; 
			elsif selector = "100" then Add <= Xn;
			elsif selector = "010" or selector = "110" then Add <= Xprev;
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;
	
Entity M2AddMux is
	generic (n : integer := 16);
	port(E_h, Un_B, Ucalc_Uz : IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      firstRaw: IN std_logic;
	      Add:      OUT std_logic_vector (n-1 downto 0));
end  M2AddMux;

Architecture Address of M2AddMux is

begin
	process (selector)
		begin 
			if selector = "001" then Add <= E_h; 
			elsif selector = "100" then
				if firstRaw= '0' then Add <= Ucalc_Uz; else Add <= Un_B; end if; 
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;
	
Entity twoInpMux is
	generic (n : integer := 16);
	port(In0, In1: IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic;
	      out1:      OUT std_logic_vector (n-1 downto 0));
end  twoInpMux;

Architecture seq of twoInpMux is
begin
	out1 <= In0 when selector = '0' else In1;
end Architecture;
