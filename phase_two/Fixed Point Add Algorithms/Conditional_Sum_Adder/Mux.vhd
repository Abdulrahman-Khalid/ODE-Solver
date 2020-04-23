LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux is
    port(
        sel       : in std_logic;
        in1 , in2 : in std_logic;
        i1 , i2   : in std_logic;
        out1      : out std_logic;
        Carry     : out std_logic
    );
end mux;

architecture arch of mux is
begin
    process(in1, in2, i1, i2,Sel)
    begin
     if Sel = '0' then
       out1 <= in1;
       carry <= i1;
     else
       out1 <= in2;
       carry <= i2;
     end if;
    end process;


end arch ; 

