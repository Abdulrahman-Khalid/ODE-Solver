
------first approach 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fixed_add is
generic (fpoint: integer := 4) ;
port(bin1,bin2 : in std_logic_vector(15 downto 0);
sum: out std_logic_vector(15 downto 0);
overflow : out std_logic);
end fixed_add;

architecture arch of fixed_add is
signal result : std_logic_vector(16 downto 0);
signal sum_signal : std_logic_vector(15 downto 0);
signal fpoint_signal : integer;
begin
	
    result <= ('0' & bin1) + ('0' & bin2);
    sum_signal <= result(15 downto 0)+("000000000000000"&result(16)) when result(16) ='1' else
           result(15 downto 0);
    overflow <= '1' when (sum_signal(15)='1' and bin1(15)='0' and bin2(15)='0') or(sum_signal(15)='0' and bin1(15)='1' and bin2(15)='1') else
                '0';
    sum<=sum_signal;
end arch;
