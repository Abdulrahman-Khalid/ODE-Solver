<<<<<<< HEAD
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator is
generic(n : integer := 16);
port(
    firstVal: in std_logic_vector(n - 1 downto 0);
    secondVal: in std_logic_vector(n - 1 downto 0);
    done, firstBigger, firstSmaller: out std_logic
);
end entity;

architecture behavioure of comparator is
    signal sum, notplus : std_logic_vector(n - 1 downto 0);
    signal cout : std_logic;
begin

    
    notplus <= not(secondVal);
    u1: entity work.Addition1 port map(notplus, firstVal, '1', sum, cout);
    
    done <= not(sum(0) or sum(1) or sum(2) or sum(3) or sum(4) or sum(5) or sum(6) or sum(7) or sum(8) or sum(9) or sum(10) or sum(11) or sum(12) or sum(13) or sum(14) or sum(15));

    firstBigger <= '1' when sum(15) = '0' else
                    '0';

    firstSmaller <= '1' when sum(15) = '1' else
                    '0';
end behavioure ; -- behavioure
=======
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
>>>>>>> 48c080a5d275053c5171d803ee54a2e6341d4d50
