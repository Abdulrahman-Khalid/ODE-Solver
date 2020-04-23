LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Interpolation_Devision is
    generic(width :integer:=16);
    port(
    Tk,Tz,Tn:IN std_logic_vector(width-1 downto 0);
    CLK,reset,EN:IN std_logic;
    Done: OUT  std_logic;
    DivOut:OUT std_logic_vector(width-1 downto 0)          
    ); 
end Interpolation_Devision;

architecture Interpolation_DevisionArch of Interpolation_Devision is
    signal temp,TkComp,Tk_Tn,Tz_Tn,Division_output :std_logic_vector(width-1 downto 0);
    signal ERROR,Div_OVF:std_logic; 
    signal DoneSignal :std_logic;
    signal Div_EN :std_logic;
    signal L1,rst2,Q1,Q2:std_logic;

    begin
       D1:entity work.fixed_division port map(Dividend=>Tk_Tn,Divisor=>Tz_Tn,Reset=>reset,CLK=>CLK,Start=>Div_EN,Quotient=>Division_output,ERR=>ERROR,Done=>DoneSignal,OverFlow=>Div_OVF);  
       F:entity work.flipflop(Behavioral) port map(D=>EN,Load=>L1,CLK=>CLK,Q=>Q1,rst=>Q2);
       F2:entity work.flipflop(Behavioral) port map(D=>EN,Load=>Q1,CLK=>CLK,Q=>Q2,rst=>rst2);
       rst2<=not EN;
       L1 <= not reset;
        Div_EN <= '1' when Q1 ='1' else '0'  ;  
        temp <= not Tn;
        add1:entity work.Carry_Look_Ahead(Behavioral) port map(A=>temp,B=>(others=>'0'),Cin=>'1',S=>TkComp);
        sub1:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Tk,B=>TkComp,Cin=>'0',S=>Tk_Tn);
        sub2:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Tz,B=>TkComp,Cin=>'0',S=>Tz_Tn);
        Done<= DoneSignal when EN = '1' else '0' when EN = '0';
        DivOut<=(others=>'Z') when (DoneSignal = '0'and EN ='0')else Division_output; 
        end architecture;