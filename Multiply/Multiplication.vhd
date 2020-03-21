library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity Multiplication is
	port( A : in std_logic_vector(15 downto 0);
	      B : in std_logic_vector(15 downto 0);
	      output : out std_logic_vector(15 downto 0);
	      overFlow : out std_logic
	);
end Multiplication;

Architecture arch of Multiplication is
    signal result : std_logic_vector(31 downto 0);
    constant scaleFactor : integer := 7;
    begin
	result <= std_logic_vector(signed(A) * signed(B));
	output <= result(22 downto 7);  -- (scale_factor+15 downto scale_factor)
	overFlow <= '0' when (result(31 downto 22) = "0000000000" or result(31 downto 22) = "1111111111") else '1';
end Architecture;