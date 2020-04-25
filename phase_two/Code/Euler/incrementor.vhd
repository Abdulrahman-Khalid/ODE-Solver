library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity incrementor is
generic(n : integer := 16);
port(
    counter: in std_logic_vector (n - 1 downto 0);
    ID: in std_logic;
    incremented: out std_logic_vector (n - 1 downto 0)
);
end entity;

architecture behavioure of incrementor is
begin

    incremented <= counter + 1 when ID = '1' else
                    counter - 1 when ID = '0';

end;