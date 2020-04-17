library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux is
generic(n : integer := 16);
port(
    counter: in std_logic_vector (n - 1 downto 0);
    resetdata: in std_logic_vector (n - 1 downto 0);
    dataIn: in std_logic_vector (n - 1 downto 0);
    load: in std_logic;
    reset: in std_logic;
    result: out std_logic_vector(n - 1 downto 0)
);
end entity;

architecture behavioure of mux is
begin

    result <=   dataIn when load = '1' and reset = '0' else
                resetdata when load = '0' and reset = '1' else
                counter;
        
end;