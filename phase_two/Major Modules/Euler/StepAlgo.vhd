library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StepAlgo is
	port( h_in : IN std_logic_vector (15 downto 0);
	      L : in std_logic_vector(15 downto 0);
	      e : in std_logic_vector(15 downto 0);
	      test : in std_logic_vector(15 downto 0);
	      reset,CLK, EN:  IN std_logic;
	      Done: OUT  std_logic;
              h_new : OUT std_logic_vector (15 downto 0)
	      
	);
end StepAlgo;

-- hnew = (0.9*h2*L)/(e)
Architecture arch1 of StepAlgo is
    constant const : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000001110011";

    Signal h_square, MULT_L, firstTerm, Division_output: STD_LOGIC_VECTOR(15 DOWNTO 0);
    Signal overF : std_logic;
    signal ERROR,Div_OVF:std_logic; 
    signal DoneSignal :std_logic;
    signal Div_EN :std_logic;

    signal L1,rst2,Q1,Q2:std_logic;

    BEGIN

	mult1: entity work.booth_multiplier port map(h_in, h_in, h_square, overF); 
	mult2: entity work.booth_multiplier port map(h_square, L , MULT_L, overF);
	mult3: entity work.booth_multiplier port map(const,MULT_L, firstTerm, overF);

	D1:entity work.fixed_division port map(Dividend=>test, Divisor=>e, Reset=>reset, CLK=>CLK, Start=>Div_EN, Quotient=>Division_output, ERR=>ERROR, Done=>DoneSignal, OverFlow=>Div_OVF);  
       
        F:entity work.flipflop(Behavioral) port map(D=>EN, Load=>L1, CLK=>CLK, Q=>Q1, rst=>Q2);
        F2:entity work.flipflop(Behavioral) port map(D=>EN, Load=>Q1, CLK=>CLK,Q=>Q2, rst=>rst2);
 	      		 
	rst2 <= not EN;
        L1 <= not reset;
	Div_EN <= '1' when Q1 ='1' else '0'  ; 
	
	Done<= DoneSignal when EN = '1' else '0' when EN = '0';
	h_new <=(others=>'Z') when (DoneSignal = '0'and EN ='0')else Division_output; 
end Architecture;
