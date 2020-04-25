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

library ieee;
use ieee.std_logic_1164.all; 
