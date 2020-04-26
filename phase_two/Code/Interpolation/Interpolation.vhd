LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Interpolation is
    generic(width : integer:=16);
    port(
        Tk,Uz,Un,Tz :IN std_logic_vector(width-1 downto 0);
        clk,rst,DivFlag,shiftFlag:IN std_logic;
        DivDoneFlag:OUT std_logic;
        Uk:OUT std_logic_vector(width-1 downto 0));    
end Interpolation; 
architecture InterpolationArch of Interpolation is
    signal Tz_Reg,Tz_RegTemp : std_logic_vector(width-1 downto 0);
    signal Tn_Reg,Tn_RegTemp : std_logic_vector(width-1 downto 0);
    signal Div_Output,Div_Output_Reg : std_logic_vector(width-1 downto 0);
    signal DivisonDoneSignal:std_logic;
begin
    DivDoneFlag <= DivisonDoneSignal;
    Dk:entity work.Interpolation_Devision port map (Tk=>Tk,Tz=>Tz,Tn=>Tn_Reg,clk=>clk,rst=>rst,EN=>DivFlag,Done=>DivisonDoneSignal,DivOut=>Div_Output);
    L1:entity work.Interpolation_Logic port map (Un=>Un,Uz=>Uz,DivResult=>Div_Output_Reg,En=>DivisonDoneSignal,Uk=>Uk);
    Reg_Tz:entity work.reg generic map(N=>width) port map(D=>Tz,Load=>'1',CLK=>CLK,Q=>Tz_RegTemp,rst=>rst);
    Reg_Tn:entity work.reg generic map(N=>width) port map(D=>Tz_Reg,Load=>shiftFlag,CLK=>clk,Q=>Tn_RegTemp,rst=>rst);
    DivOut_Reg :entity work.reg generic map(N=>width) port map(D=>Div_Output,Load=>DivisonDoneSignal,CLK=>clk,Q=>Div_Output_Reg,rst=>rst);
    Tn_reg <= Tn_RegTemp when shiftFlag ='1' else (others=>'0') when rst ='1';
    Tz_reg <= Tz_RegTemp ;
end architecture;