library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Complement2 is
    generic (N: integer := 15);
    port( X : in std_logic_vector(N-1 downto 0);
          Y : out std_logic_vector(N-1 downto 0));
end entity;

architecture Structural of Complement2 is
begin
    process (X)
    variable FIRST_ONE : integer := 0;
    begin
        l1 : for i in 0 to N-1 loop
            if X(i) = '1' then
                FIRST_ONE := i;
                exit;
            end if ;
        end loop ; -- l1
        Y <= not X;
        Y(FIRST_ONE) <= '1';
    end process;
end architecture;
