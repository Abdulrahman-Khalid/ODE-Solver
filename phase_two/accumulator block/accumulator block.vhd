--adder
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
----------------------------------------------------
--latch
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch_top is
    generic(
	n: integer := 16
    );
    Port ( D  : in  STD_LOGIC_vector(n-1 downto 0);
           EN : in  STD_LOGIC;
           Q  : out STD_LOGIC_vector(n-1 downto 0));
end d_latch_top;

architecture Behavioral of d_latch_top is
    signal DATA : STD_LOGIC_vector(n-1 downto 0) := (others => '0');
begin

    DATA <= D when (EN = '1') else DATA;
    Q <= DATA;
end Behavioral;

-----------------------------------------------------------------

--block logic
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_bit_unsigned.all;
use ieee.numeric_std.all;

entity accumulator_block is
generic (
    n : integer:= 16
    );
Port ( x : in STD_LOGIC_VECTOR (n-1 downto 0);
y : in STD_LOGIC_VECTOR (n-1 downto 0);
--overflow_in : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (n-1 downto 0);
overFlow_out_error : out std_logic);
end accumulator_block;

architecture Behavioral of accumulator_block is 
component Carry_Look_Ahead_generic
generic (
    n : integer:= 16
    );
Port ( A : in STD_LOGIC_VECTOR (n-1 downto 0);
B : in STD_LOGIC_VECTOR (n-1 downto 0);
Cin : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (n-1 downto 0);
overFlow : out std_logic);
end component; 

component d_latch_top
 generic(
	n: integer := 16
    );
    Port ( D  : in  STD_LOGIC_vector(n-1 downto 0);
           EN : in  STD_LOGIC;
           Q  : out STD_LOGIC_vector(n-1 downto 0));
end component;

signal y_sig: std_logic_vector (n-1 downto 0);
signal y_not: std_logic_vector (n-1 downto 0);
signal sum1: std_logic_vector (n-1 downto 0);
signal sum2: std_logic_vector (n-1 downto 0);
signal one : std_logic_vector (n-1 downto 0) :=  (others=>'0');
signal abs_diff : std_logic_vector (n-1 downto 0);
signal latch_data : std_logic_vector (n-1 downto 0);
signal latch_data_to_added : std_logic_vector (n-1 downto 0);
signal latch_data_final_sum : std_logic_vector (n-1 downto 0);
signal latch_data_dumy : std_logic_vector (n-1 downto 0);
signal final_sum : std_logic_vector (n-1 downto 0);

signal clk : std_logic := '1';
begin

--get 2's complement of y
find_difference: Carry_Look_Ahead_generic
Port map( A => y_not,
B => one,
Cin => '0',
S => sum2,
overflow => open);

--get add of x-y
twos_complement:Carry_Look_Ahead_generic
 Port map( A => x,
B => y_sig,
Cin => '0',
S => sum1,
overflow => open);
y_not <= not(y);

--get the value stored in latch
get_latch_value: d_latch_top
Port map( D=> one,  --dummy input
EN => '0',
Q => latch_data);

--add the old latch value with the new calculated abs(x-y)
add_latch_data_with_new_diff: Carry_Look_Ahead_generic
Port map( A => latch_data_to_added,
B => abs_diff,
Cin => '0',
S => final_sum,
overflow => overFlow_out_error);

--save the new value of old_stored_val + abs(x-y)
put_final_value_in_latch: d_latch_top
Port map( D=> latch_data_final_sum,
EN => '1',
Q => latch_data_dumy);


one(0) <= '1'; 
latch_data_to_added <= latch_data;
y_sig <= sum2;
abs_diff <= std_logic_vector(abs(signed(sum1)));
S <= final_sum;
latch_data_final_sum<= final_sum;

end Behavioral;