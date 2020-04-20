library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counterMux is
generic(n : integer := 16);
port(
    counter: in std_logic_vector (n - 1 downto 0);
    resetdata: in std_logic_vector (n - 1 downto 0);
    dataIn: in std_logic_vector (n - 1 downto 0);
    start: in std_logic_vector (n - 1 downto 0);
    load: in std_logic;
    reset: in std_logic;
    universalReset: in std_logic;
    result: out std_logic_vector(n - 1 downto 0)
);
end entity;

architecture behavioure of counterMux is
begin

    result <=   start when universalReset = '1' else
                dataIn when load = '1' else
                resetdata when reset = '1' else
                counter;
        
end;