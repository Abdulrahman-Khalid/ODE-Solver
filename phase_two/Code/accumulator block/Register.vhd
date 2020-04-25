library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg is
generic(N : integer := 16);
port( load : in STD_LOGIC;
a : in STD_LOGIC_VECTOR(N-1  downto 0);
clk : in STD_LOGIC;
clr : in STD_LOGIC;
b :out STD_LOGIC_VECTOR(N-1  downto 0));
end reg;

architecture reg of reg is
begin
process(clk, clr)
begin
if clr = '1' then
b <= (others=> '0');
elsif clk'event  and clk = '1' then
if load= '1' then
b <= a;
end if;
end if;
end process;
end reg;
