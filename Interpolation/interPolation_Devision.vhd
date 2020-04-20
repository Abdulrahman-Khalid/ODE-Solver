LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Interpolation_Devision is
    generic(width :integer:=16);
    port(
    Tk,Tz,Tn:IN std_logic_vector(width-1 downto 0);
    CLK,EN:IN std_logic;
    Done: OUT  std_logic;
    DivOut:OUT std_logic_vector(width-1 downto 0)          
    ); 
end Interpolation_Devision;

architecture Interpolation_DevisionArch of Interpolation_Devision is
    signal temp,TkComp,Tk_Tn,Tz_Tn,Division_output :std_logic_vector(width-1 downto 0):=(others=>'0');
    signal ERROR,Div_OVF:std_logic; 
    signal Div_EN,DoneSignal :std_logic;
    begin
       D1:entity work.fixed_division port map(Dividend=>Tk_Tn,Divisor=>Tz_Tn,Enable=>'1',CLK=>CLK,Start=>Div_EN,Quotient=>Division_output,ERR=>ERROR,Done=>DoneSignal,OverFlow=>Div_OVF);  
        DIV_EN <= '1' when (Tk_Tn /= (std_logic_vector(to_unsigned(0,width))) and Tz_Tn /= (std_logic_vector(to_unsigned(0,width)))) and falling_edge(CLK) else
        '0' when (rising_edge(CLK));
        temp <= not Tn;
        TkComp  <= std_logic_vector(unsigned(temp + 1));
        sub1:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Tk,B=>TkComp,Cin=>'0',S=>Tk_Tn);
        sub2:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Tz,B=>TkComp,Cin=>'0',S=>Tz_Tn);
        Done<= DoneSignal;
        DivOut<=(others=>'Z') when (DoneSignal = '0'and EN ='0')else Division_output; 
        end architecture;