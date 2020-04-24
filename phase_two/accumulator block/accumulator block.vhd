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
clr: in std_logic;
load: in std_logic;
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

component Reg
generic(N : integer := 16);
port( load : in STD_LOGIC;
a : in STD_LOGIC_VECTOR(N-1  downto 0);
clk : in STD_LOGIC;
clr : in STD_LOGIC;
b :out STD_LOGIC_VECTOR(N-1  downto 0));
end component;

signal y_sig: std_logic_vector (n-1 downto 0);
signal y_not: std_logic_vector (n-1 downto 0);
signal sum1: std_logic_vector (n-1 downto 0);
signal sum2: std_logic_vector (n-1 downto 0);
signal one : std_logic_vector (n-1 downto 0) :=  (others=>'0');
signal abs_diff : std_logic_vector (n-1 downto 0);
signal latch_data_to_added : std_logic_vector (n-1 downto 0);
signal latch_data_final_sum : std_logic_vector (n-1 downto 0);
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


--add the old latch value with the new calculated abs(x-y)
add_latch_data_with_new_diff: Carry_Look_Ahead_generic
Port map( A => latch_data_to_added,
B => abs_diff,
Cin => '0',
S => final_sum,
overflow => overFlow_out_error);

put_final_value_in_latch: Reg
Port map(load => load,
a => final_sum,
clk => clk,
clr =>clr,
b => latch_data_to_added);

 clk <= not clk after (100 ps) / 2;
one(0) <= '1'; 
y_sig <= sum2;
abs_diff <= std_logic_vector(abs(signed(sum1)));
S <= final_sum;
latch_data_final_sum<= final_sum;

end Behavioral;