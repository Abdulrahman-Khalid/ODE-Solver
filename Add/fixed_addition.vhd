library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fixed_addition is
	port( A : in std_logic_vector(15 downto 0);
	      B : in std_logic_vector(15 downto 0);
	      output : out std_logic_vector(15 downto 0);
	      overFlow : out std_logic
	);
end fixed_addition;

Architecture arch of fixed_addition is
    signal result : std_logic_vector(15 downto 0);
    constant scaleFactor : integer := 7;
    begin
	result <= std_logic_vector(signed(A) + signed(B));
	output <= result;
	-- neg + neg = pos or pos + pos = neg => overFlow = '1' else '0'
	overFlow <= '1' when (A(15) = B(15) and A(15) /= result(15)) else '0'; 
end Architecture;