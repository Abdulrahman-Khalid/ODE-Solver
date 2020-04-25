Library ieee;
use ieee.std_logic_1164.all;

entity BussFSM is
    port ( outputDone, firstRaw, StoreEntry, processCMD, compare: in std_logic;
            clk,rst: in std_logic;
	    selector: out std_logic_vector(2 downto 0);
	    initialize, writeX, writeU, Add: out std_logic);
end entity;

Architecture FSMControl of BussFSM is

    type states is (Idle,N_M_T_X0, E_H,Ti,A_X_UandU,SpareB,Store_fetchXn, fetch_fetchXn);
    signal current_state : states := Idle;
    signal next_state : states := N_M_T_X0;

begin

    --calculate state --> Combinational or sequential ? Why
    process (current_state, outputDone, firstRaw, storeEntry, processCMD) 
        begin
            case current_state is
		when Idle =>
                    if processCMD = '1' then next_state <= N_M_T_X0; else next_state <=Idle; end if;
                when N_M_T_X0 =>
                    next_state <= E_H;
		when E_H =>
		    next_state <= Ti; 
                when Ti =>
                    next_state <= A_X_UandU; 
                when A_X_UandU =>
		    if firstRaw = '1' then next_state <= SpareB;
		    elsif storeEntry = '1' then next_state <= Store_fetchXn;
		    elsif compare ='1'   then next_state <= fetch_fetchXn;
                    else next_state <= A_X_UandU; end if;
                when SpareB =>
		    if storeEntry = '1' then 
				if compare ='1' then next_state <= fetch_fetchXn; else next_state <= Store_fetchXn; end if; 
		    else next_state <= A_X_UandU; end if;
		when Store_fetchXn =>
		    if outputDone = '1' then next_state <= Ti;
		    elsif compare = '1' then next_state <= fetch_fetchXn; 
		    else next_state <= A_X_UandU; end if;
		when fetch_fetchXn =>
		    if outputDone = '1' then next_state <= Ti; else next_state <= A_X_UandU; end if; 
		    
            end case;
        end process;
    
    --store new state --> Combinational or sequential ? Why
    process (clk,rst)
    begin
      if rst = '1' then
            current_state <= Idle;
      elsif rising_edge(clk) then 
             current_state <= next_state;
      end if;
    end process;
--Idle,N_M_T_X0, E_H,Ti,A_X_UandU,SpareB,Store_fetchXn, fetch_fetchXn
    -- Calculating the 1-bit Output
    process (current_state, firstRaw)
    begin
	initialize <= '0';
	writeX <= '0';
	writeU <= '0';
	Add    <= '0';
	case current_state is
            when Idle =>
                selector <= "000";
            when N_M_T_X0 =>
                selector <= "001";
		initialize<= '1';
	    when E_H =>
                selector <= "010";
            when  Ti =>
                selector <= "011";
	    when  A_X_UandU =>
                selector <= "100";
		if firstRaw ='0' then Add <= '1'; end if;
            when  SpareB =>
                selector <= "101";
		writeU   <= '1';
		Add      <= '1';
	    when  Store_fetchXn =>
                selector <= "110";
		writeX <= '1';
	    when  fetch_fetchXn =>
                selector <= "111";
	end case;
    end process;
       
end Architecture;

Library ieee;
use ieee.std_logic_1164.all;

entity StepFSM is
    port ( clk, rst, enable, stateChange, converged, reached: in std_logic;
	    Var1, Var2, Var3, Var4, Var5 : out std_logic);
end entity;

Architecture FSMControl of StepFSM is

    type states is (Idle, state1, state2, state3, state4);
    signal current_state : states := state1;
    signal next_state : states := state2;

begin
	process(current_state, enable, converged)
	    begin
		case current_state is
		when Idle =>
                    if enable = '1' then next_state <= state1; else next_state <=Idle; end if;
                when state1 =>
                    next_state <= state2;
		when state2 =>
		    next_state <= state3;
		when state3 =>
			if converged = '1' then next_state <= state4; else next_state <= state1; end if;
		when state4 =>
			if reached = '1' then next_state <= state1; else next_state <= state4; end if;
		end case;
        end process;

	process (clk,rst, stateChange)
   	   begin
      		if rst = '1' then
            		current_state <= Idle;
      		elsif rising_edge(clk) then
			if current_state = state4 then current_state <= next_state;
  		        elsif stateChange = '1' then current_state <= next_state;
			end if;
      		end if;
  	end process;
	
	process (current_state)
		begin
			Var1 <= '0';
			Var2 <= '0';
			Var3 <= '0';
			Var4 <= '0';
			case current_state is
			    when Idle =>
         			 
                	    when state1 =>
              		         Var1  <= '1';
		
		            when state2 =>
				 Var2  <= '1';
				
			    when state3 => 
				 Var3  <= '1';
				
			    when state4 =>
				 Var4  <= '1';
		end case;
	end process;
end Architecture;
				 

		
	
