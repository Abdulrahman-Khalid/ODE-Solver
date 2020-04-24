--partial full adder "eithout carry"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Partial_Full_Adder is
Port ( A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
S : out STD_LOGIC;
P : out STD_LOGIC;
G : out STD_LOGIC);
end Partial_Full_Adder;
 
architecture Behavioral of Partial_Full_Adder is
 
begin
 
S <= A xor B xor Cin;
P <= A xor B;
G <= A and B;
 
end Behavioral;

------------------------------------------------------------
------------------------------------------------------------

--carry look ahead adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Carry_Look_Ahead_generic is
generic (
    n : integer:= 16
    );
Port ( A : in STD_LOGIC_VECTOR (n-1 downto 0);
B : in STD_LOGIC_VECTOR (n-1 downto 0);
Cin : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (n-1 downto 0);
overFlow : out std_logic);
--Cout : out STD_LOGIC);
end Carry_Look_Ahead_generic;

architecture Behavioral of Carry_Look_Ahead_generic is
 
component Partial_Full_Adder
Port ( A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
S : out STD_LOGIC;
P : out STD_LOGIC;
G : out STD_LOGIC);
end component;
 
signal c: STD_LOGIC_vector (n-1 downto 0);
signal sum_sig :STD_LOGIC_VECTOR(n-1 downto 0); 
signal P,G: STD_LOGIC_VECTOR(n-1 downto 0);
constant fixed_point: integer := 7;
begin

 -- Create the Full Adders
  GEN_FULL_ADDERS : for i in 0 to n-1 generate
    FULL_ADDER_INST : Partial_Full_Adder
      port map (
        A  => A(i),
        B  => B(i),
        Cin => c(i),        
        S   => sum_sig(i),
        P => P(i),
	G => G(i)
        );
  end generate GEN_FULL_ADDERS;

 GEN_CLA : for j in 0 to n-2 generate
    c(j+1) <= G(j) or (P(j) and C(j));
  end generate GEN_CLA;
    c(0) <= Cin; -- no carry input
    S    <= sum_sig;

    overFlow <= '1' when (A(15) = B(15) and A(15) /= sum_sig(15)) else '0';
end Behavioral;
