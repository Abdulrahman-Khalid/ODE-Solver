LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY booth_multiplier IS
	
	PORT(m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	     result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	     overflow : OUT STD_LOGIC);
		
END booth_multiplier;

ARCHITECTURE behavior OF booth_multiplier IS

BEGIN
	
	PROCESS(m, r)
		
		CONSTANT ZEROS : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');	
		VARIABLE a, s, p : STD_LOGIC_VECTOR(32 DOWNTO 0);
		VARIABLE mn      : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	BEGIN
		
		a := (OTHERS => '0');
		s := (OTHERS => '0');
		p := (OTHERS => '0');
		
		IF (m /= ZEROS AND r /= ZEROS) THEN
		
			a(32 DOWNTO 17) := m;
			mn := (NOT m) + 1;
			s(32 DOWNTO 17) := mn;
			p(16 DOWNTO 1) := r;
			
			FOR i IN 1 TO 16 LOOP
				IF (p(1 DOWNTO 0) = "01") THEN
					p := p + a;
				ELSIF (p(1 DOWNTO 0) = "10") THEN
					p := p + s;
				END IF;
				p(31 DOWNTO 0) := p(32  DOWNTO 1);
			END LOOP;
			
		END IF;
		
		result <= p(23 DOWNTO 8);
		overflow <= (p(32) and p(31) and p(30) and p(29) and p(28) and p(27) and p(26) and p(25) and p(24)) xor (p(32) or p(31) or p(30) or p(29) or p(28) or p(27) or p(26) or p(25) or p(24));
		
	END PROCESS;
	
END behavior;