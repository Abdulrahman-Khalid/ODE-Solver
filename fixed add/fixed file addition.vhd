library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fixed_add is
generic (fpoint: integer := 4) ;
port(bin1,bin2 : in std_logic_vector(15 downto 0);
sum: out std_logic_vector(15 downto 0);
fixed_point : out integer);
end fixed_add;

architecture arch of fixed_add is
signal result : std_logic_vector(16 downto 0);
signal fpoint_signal : integer;
begin
    result <= ('0' & bin1) + ('0' & bin2);
    sum <= result(16 downto 1) when result(16) = '1' else
             result(15 downto 0);
    fpoint_signal <= fpoint-1 when  result(16) = '1' else
             fpoint;
    fixed_point<=fpoint_signal;
end arch;