library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity smallMux is
generic(n : integer := 16);
port(
    loadAddress: in std_logic_vector(n - 1 downto 0);
    CurrentCount: in std_logic_vector(n - 1 downto 0);
    start: in std_logic_vector(n - 1 downto 0);
    universalReset, innerDone, continue, load: in std_logic;
    address: out std_logic_vector(n - 1 downto 0)
);
end entity;

architecture behavioure of smallMux is
begin

    address <=  start when universalReset = '1' else
                loadAddress when load = '1' else
                CurrentCount when innerDone = '1' and continue = '1' else
                (others => '0');

end behavioure ;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter IS 
GENERIC(N : INTEGER := 16);
PORT (
    dataIn : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    offset : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    load : IN STD_LOGIC;
    enable: IN STD_LOGIC;
    CLK : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    universalReset : IN STD_LOGIC;
    continue: IN STD_LOGIC;
    dataOut : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    done, NFN: OUT STD_LOGIC
);
END ENTITY;

ARCHITECTURE behavioure OF counter IS
    SIGNAL init, off, countVal, incremented, muxOut, start, newStart, plus: STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL activate, innerDone, setNewstart, Cout, cout2, notFirstN, ffIN: STD_LOGIC;
BEGIN

    activate <= ((enable OR load) AND NOT(innerDone)) OR universalReset OR reset;
    setNewStart <= (innerDone AND continue) OR load OR universalReset;
    smallMux: Entity work.smallMux PORT MAP (dataIn, countVal, start, universalReset,innerDone, continue, load, newStart);
    initialAdress: ENTITY work.reg PORT MAP (newStart, setNewStart, CLK, init,universalReset); 
    offsett: ENTITY work.reg PORT MAP (offset, load, CLK, off,universalReset);
    startAddress: ENTITY work.reg PORT MAP (dataIn, load, CLK, start,universalReset);                   --for universal reset
    addition: ENTITY work.Addition1 PORT MAP (countVal, "0000000000000001", '0' ,incremented, Cout);
    muxing: ENTITY work.counterMux PORT MAP (incremented, init, dataIn, start, load, reset, universalReset, continue, muxOut);
    count: ENTITY work.reg PORT MAP (muxOut, activate, CLK, countVal,universalReset);
    u0: entity work.Addition1 port map(init, offset, '0', plus, cout2);
    compare: ENTITY work.comparator PORT MAP (countVal, plus, innerDone);
    dataOut <= countVal;
    done <= innerDone;
    ffIN <= notFirstN or (innerDone and continue);
    ff: ENTITY work.flipflop port map (ffIN, '1', CLK, notFirstN, universalReset);
    NFN <= notFirstN;
    
END;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counterNext IS 
GENERIC(N : INTEGER := 16);
PORT (
    dataIn : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    offset : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    load : IN STD_LOGIC;
    enable: IN STD_LOGIC;
    CLK : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    dataOut : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    nextAddress : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    done: OUT STD_LOGIC
);
END ENTITY;

ARCHITECTURE behavioureNext OF counterNext IS
    SIGNAL init, off, countVal, incremented, muxOut, plus: STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL activate, Cout, innerDone, innerReset, cout2: STD_LOGIC;
BEGIN

    activate <= enable OR reset OR load OR innerDone;
    innerReset <= (reset OR innerDone);
    initialAdress: ENTITY work.reg PORT MAP (dataIn, load, CLK, init,reset);
    offsett: ENTITY work.reg PORT MAP (offset, load, CLK, off,reset);
    addition: ENTITY work.Addition1 PORT MAP (countVal, "0000000000000001", '0' ,incremented, Cout);
    muxing: ENTITY work.counterMux PORT MAP (incremented, init, dataIn, "0000000000000000", load, innerReset, '0', '0', muxOut);
    count: ENTITY work.reg PORT MAP (muxOut, activate, CLK, countVal,reset);
    u1: entity work.Addition1 port map(init, offset, '0', plus, cout2);
    compare: ENTITY work.comparator PORT MAP (countVal, plus, innerDone);
    dataOut <= countVal;
    nextAddress <= incremented;
    done <= innerDone;
    
END;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counterNextID IS 
GENERIC(N : INTEGER := 16);
PORT (
    step: IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    enable: IN STD_LOGIC;
    ID: IN STD_LOGIC;
    CLK : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    dataOut : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    nextAddress : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE behavioureNext OF counterNextID IS
    SIGNAL init, countVal, incremented, muxOut, PLUSORMINUS, stepC, notStep: STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL activate, Cout, cout3: STD_LOGIC;
BEGIN

    notStep <= not(step);
    stepComplement: ENTITY work.Addition1 PORT MAP (notStep, "0000000000000000", '1', stepC, cout3);
    PLUSORMINUS <=  step WHEN ID = '1' else
                    stepC;
    addition: ENTITY work.Addition1 PORT MAP (countVal, PLUSORMINUS, '0' ,incremented, Cout);
    count: ENTITY work.reg PORT MAP (incremented, enable, CLK, countVal,reset);
    dataOut <= countVal;
    nextAddress <= incremented;
    
END;