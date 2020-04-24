<<<<<<< HEAD
library ieee;
use ieee.std_logic_1164.all; 

package my_types_pkg is
  type array16 is array (0 to 15) of std_logic_vector(31 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all; 

entity AddandShift is
    Port ( A,B : in std_logic_vector(15 downto 0);
	   Y : out  std_logic_vector(15 downto 0);
	   overflow : out std_logic);
end AddandShift;
 
use work.my_types_pkg.all;

ARCHITECTURE AddandShit OF AddandShift IS

signal zeros : std_logic_vector (15 downto 0) := (others=>'0');
signal R,Z,F : array16;
signal c : std_logic_vector (15 downto 0);
BEGIN
	zeros <= (others=>'0');
	process(zeros)
	begin
		R(0) <= zeros & A ;
		M: for I in 15 downto 1 loop
		Mi:R(16-I) <= zeros(I downto 1) & A & zeros(16-I downto 1);
		end loop;
	end process;

	L: for I in 0 to 15 generate
	li:entity work.MuxCustom port map (R(I),Z(I),B(I));
	end generate;
	
	p0: entity work.Carry_Look_Ahead_generic generic map(32) port map(Z(0),Z(1),'0', F(0),c(0));
	p: for I in 0 to 13 generate
	pi: entity work.Carry_Look_Ahead_generic generic map(32) port map(F(I),Z(I+2),c(I), F(I+1),c(I+1));
	end generate;
	Y <= F(14) (22 downto 7);
	overflow <= (F(14)(31)and F(14)(30)and F(14)(29)and F(14)(28)and F(14)(27)and F(14)(26)and F(14)(25)and F(14)(24)and F(14)(23))
		    xor (F(14)(31)or F(14)(30)or F(14)(29)or F(14)(28)or F(14)(27)or F(14)(26)or F(14)(25)or F(14)(24)or F(14)(23));
	 
END AddandShit;

library ieee;
use ieee.std_logic_1164.all; 

entity MuxCustom is
    Port ( A : in std_logic_vector(31 downto 0);
	   Y : out  std_logic_vector(31 downto 0);
	   selector : in std_logic);
end MuxCustom;

ARCHITECTURE MuxArch OF MuxCustom IS
begin
	Y <= A when (selector = '1') else (others=>'0');
end MuxArch;
=======
library ieee;
use ieee.std_logic_1164.all; 

package my_types_pkg is
  type array16 is array (0 to 15) of std_logic_vector(31 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all; 

entity Multiplier is
    Port ( A,B : in std_logic_vector(15 downto 0);
	   Y : out  std_logic_vector(15 downto 0);
	   overflow : out std_logic);
end Multiplier;

library ieee;
use ieee.std_logic_1164.all; 
use work.my_types_pkg.all;

ARCHITECTURE AddandShit OF Multiplier IS
component Mux is
    Port ( A : in std_logic_vector(31 downto 0);
	   Y : out  std_logic_vector(31 downto 0);
	   selector : in std_logic);
end component;
component my_nadder IS

	GENERIC (n : integer := 32);

	PORT(a,b : IN std_logic_vector(n-1 DOWNTO 0);

	cin : IN std_logic;

	s : OUT std_logic_vector(n-1 DOWNTO 0);
	cout : OUT std_logic);

END component;
signal zeros : std_logic_vector (15 downto 0) := (others=>'0');
signal R,Z,F : array16;
signal c : std_logic_vector (15 downto 0);
BEGIN
	process(zeros)
	begin
		R(0) <= zeros & A ;
		M: for I in 15 downto 1 loop
		Mi:R(16-I) <= zeros(I downto 1) & A & zeros(16-I downto 1);
		end loop;
	end process;

	L: for I in 0 to 15 generate
	li:Mux port map (R(I),Z(I),B(I));
	end generate;
	
	p0: my_nadder port map(Z(0),Z(1),'0', F(0),c(0));
	p: for I in 0 to 13 generate
	pi: my_nadder port map(F(I),Z(I+2),c(I), F(I+1),c(I+1));
	end generate;
	Y <= F(14) (22 downto 7);
	 
END AddandShit;

library ieee;
use ieee.std_logic_1164.all; 

entity MuxCustom is
    Port ( A : in std_logic_vector(31 downto 0);
	   Y : out  std_logic_vector(31 downto 0);
	   selector : in std_logic);
end MuxCustom;

ARCHITECTURE MuxArch OF MuxCustom IS
begin
	Y <= A when (selector = '1') else (others=>'0');
end MuxArch;

library ieee;
use ieee.std_logic_1164.all; 

-- n-bit adder
ENTITY my_adder IS
	PORT( a,b,cin : IN std_logic;
	s,cout : OUT std_logic);
END my_adder;

ARCHITECTURE a_my_adder OF my_adder IS

BEGIN

	PROCESS (a,b,cin)
	BEGIN
		s <= a XOR b XOR cin;
		cout <= (a AND b) or (cin AND (a XOR b));

	END PROCESS;

END a_my_adder;


library ieee;
use ieee.std_logic_1164.all; 

ENTITY my_nadder IS

	GENERIC (n : integer := 32);

	PORT(a,b : IN std_logic_vector(n-1 DOWNTO 0);

	cin : IN std_logic;

	s : OUT std_logic_vector(n-1 DOWNTO 0);
	cout : OUT std_logic);

END my_nadder;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ARCHITECTURE a_my_nadder OF my_nadder IS

	COMPONENT my_adder IS

	PORT( a,b,cin : IN std_logic;
	s,cout : OUT std_logic);

	END COMPONENT;

SIGNAL temp : std_logic_vector(n-1 DOWNTO 0);

BEGIN

	loop1: FOR i IN 0 TO n-1 GENERATE

	g0: IF i = 0 GENERATE

	f0: my_adder PORT MAP (a(i) ,b(i) ,cin, s(i), temp(i));

	END GENERATE g0;

	gx: IF i > 0 GENERATE

	fx: my_adder PORT MAP (a(i),b(i),temp(i-1),s(i),temp(i));

	END GENERATE gx;

END GENERATE;

cout <= temp(n-1);

END a_my_nadder;
>>>>>>> 48c080a5d275053c5171d803ee54a2e6341d4d50
