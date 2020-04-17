library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Comparator is
generic(N : integer := 16);
port(
    A: in std_logic_vector(N - 1 downto 0);
    B: in std_logic_vector(N - 1 downto 0);
    OP: out std_logic_vector(1 downto 0)
);
end entity;

architecture DataFlow of Comparator is
begin

    OP <= "00" when A = B else
            "11" when A > B else
            "10" when A < B;

end DataFlow ; -- DataFlow
