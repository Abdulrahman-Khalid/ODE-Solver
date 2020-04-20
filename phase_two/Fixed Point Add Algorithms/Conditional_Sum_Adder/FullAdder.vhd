library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
    port(
        in1 , in2 : in std_logic;
        Ci : in std_logic;
        S : out std_logic;
        Co : out std_logic
    );
end FullAdder;

architecture archA of FullAdder is
begin
    S <= in1 XOR in2 XOR Ci;
    Co <= ( in1 AND in2) OR ( in2 AND Ci) OR (Ci AND in1);
end archA;
