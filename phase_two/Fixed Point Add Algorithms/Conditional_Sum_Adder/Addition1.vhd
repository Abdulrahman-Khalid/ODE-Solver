library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity Addition1 is
	port( A : in std_logic_vector(15 downto 0);
	      B : in std_logic_vector(15 downto 0);
	      Cin : in std_logic;
	      sum : out std_logic_vector(15 downto 0);
	      Cout: out std_logic
	);
end Addition1;

Architecture arch1 of Addition1 is
    COMPONENT FullAdder  
          port(
        	in1 , in2 : in std_logic;
        	Ci : in std_logic;
        	S : out std_logic;
        	Co : out std_logic
    	  );     
    END COMPONENT; 
    component mux is
            port(
            sel       : in std_logic;
            in1 , in2 : in std_logic;
            i1 , i2   : in std_logic;
            out1      : out std_logic;
            Carry     : out std_logic
        );
    end component;
    SIGNAL   t0, t1:  std_logic_vector(15 downto 1); 
    SIGNAL   ou0, ou1: std_logic_vector(15 downto 1);
    SIGNAL  SC : std_logic_vector(15 downto 0);
    begin
	FA0: FullAdder port map( A(0), B(0), Cin, sum(0), SC(0));

	FA: for i in 1 to 15 generate  
            FA0_i: FullAdder PORT MAP (A(i), B(i), '0', ou0(i), t0(i)); 
	    FA1_i: FullAdder PORT MAP (A(i), B(i), '1', ou1(i), t1(i));     
        end generate; 

	muxx: for j in 1 to 15 generate
        	muxx_j: mux port map(SC(j-1), Ou0(j), Ou1(j), t0(j), t1(j), sum(j), SC(j) ); 
	end generate;
	Cout <= SC(15);
end Architecture;
