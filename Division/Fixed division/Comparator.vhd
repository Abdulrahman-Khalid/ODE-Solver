library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Returns "1" if A >= B , "0" if A < B
entity Comparator is
generic(N : integer := 16);
port(
    A: in std_logic_vector(N - 1 downto 0);
    B: in std_logic_vector(N - 1 downto 0);
    OP: out std_logic
);
end entity;

architecture DataFlow of Comparator is
begin

    OP <= '1' when A >= B else
            '0';

end DataFlow ; -- DataFlow
