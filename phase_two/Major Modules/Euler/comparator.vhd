library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator is
generic(n : integer := 16);
port(
    counter: in std_logic_vector(n - 1 downto 0);
    init: in std_logic_vector(n - 1 downto 0);
    offset: in std_logic_vector(n - 1 downto 0);
    done: out std_logic
);
end entity;

architecture behavioure of comparator is
    signal plus : std_logic_vector(n - 1 downto 0);
begin

    plus <= init + offset;
    done <= '1' when plus = counter else
            '0';

end behavioure ; -- behavioure
