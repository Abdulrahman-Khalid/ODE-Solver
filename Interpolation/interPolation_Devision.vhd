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
    signal DoneSignal :std_logic;
    signal Div_EN :std_logic:='0';
    signal counter :integer := 0;
    begin
       D1:entity work.fixed_division port map(Dividend=>Tk_Tn,Divisor=>Tz_Tn,Enable=>'1',CLK=>CLK,Start=>Div_EN,Quotient=>Division_output,ERR=>ERROR,Done=>DoneSignal,OverFlow=>Div_OVF);  
        DIV_EN <= '1' when counter = 2 else '0';
        process(CLK,counter,DoneSignal)
        begin
            if(rising_edge(CLK)) then
                counter<= counter+1;
                end if;
            if(EN='0') then
                counter <= 0;
                end if;

        end process;    
        temp <= not Tn;
        TkComp  <= std_logic_vector(unsigned(temp + 1));
        sub1:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Tk,B=>TkComp,Cin=>'0',S=>Tk_Tn);
        sub2:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Tz,B=>TkComp,Cin=>'0',S=>Tz_Tn);
        Done<= DoneSignal;
        DivOut<=(others=>'Z') when (DoneSignal = '0'and EN ='0')else Division_output; 
        end architecture;