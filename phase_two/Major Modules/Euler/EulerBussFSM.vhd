Library ieee;
use ieee.std_logic_1164.all;

entity BussFSM is
    port ( outputDone, firstRaw, StoreEntry, processCMD: in std_logic;
            clk,rst: in std_logic;
	    selector: out std_logic_vector(2 downto 0);
	    initialize, writeX, writeU, Add: out std_logic);
end entity;

Architecture FSMControl of BussFSM is

    type states is (Idle,N_M_E_H,T_X0,ReadTi,A_X_UandU,SpareB,Store_fetchXn);
    signal current_state : states := Idle;
    signal next_state : states := N_M_E_H;

begin

    --calculate state --> Combinational or sequential ? Why
    process (current_state, outputDone, firstRaw, storeEntry, processCMD) 
        begin
            case current_state is
		when Idle =>
                    if processCMD = '1' then next_state <= N_M_E_H; else next_state <=Idle; end if;
                when N_M_E_H =>
                    next_state <= T_X0;
		when T_X0 =>
		    next_state <= ReadTi; 
                when ReadTi =>
                    next_state <= A_X_UandU; 
                when A_X_UandU =>
		    if firstRaw = '1' then next_state <= SpareB;
		    elsif storeEntry = '1' then next_state <= Store_fetchXn;
                    else next_state <= A_X_UandU; end if;
                when SpareB =>
		    if storeEntry = '1' then next_state <= Store_fetchXn; 
		    else next_state <= A_X_UandU; end if;
		when Store_fetchXn =>
		    if outputDone = '1' then next_state <= ReadTi; else next_state <= A_X_UandU; end if;
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
--Idle,N_M_E_H,ReadT0_X0,A_X_UandU,SpareB,Store_fetchXn
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
            when N_M_E_H =>
                selector <= "001";
	    when T_X0 =>
		selector <= "010";
		initialize <= '1';
	    when ReadTi =>
                selector <= "011";
            when  A_X_UandU =>
                selector <= "100";
		if firstRaw ='0' then Add <= '1'; end if;
	    when  SpareB =>
                selector <= "101";
		writeU <= '1';
		Add    <= '1';
            when  Store_fetchXn =>
                selector <= "110";
		writeX <= '1';
	end case;
    end process;
       
end Architecture;

Library ieee;
use ieee.std_logic_1164.all;

entity StepFSM is
    port ( clk, rst, enable, stateChange: in std_logic;
	    reg1Enable, h_divided, h_write, incK, decK: out std_logic);
end entity;

Architecture FSMControl of StepFSM is

    type states is (Idle, state1, state2, state3, state4, state5);
    signal current_state : states := state1;
    signal next_state : states := state2;

begin
	process(current_state, enable, rst)
	    begin
		case current_state is
		when Idle =>
                    if enable = '1' then next_state <= state1; else next_state <=Idle; end if;
                when state1 =>
                    next_state <= state2;
		when state2 =>
		    next_state <= state3;
		when state3 =>
		    next_state <= state4; 
		when state4 =>
		    next_state <= state5;
		when state5 =>
		    next_state <= state1;
		end case;
        end process;

	process (clk,rst, stateChange)
   	   begin
      		if rst = '1' then
            		current_state <= Idle;
      		elsif rising_edge(clk) then
			if current_state = state3 or current_state = state5 then current_state <= next_state;
  		        elsif stateChange = '1' then current_state <= next_state;
			end if;
      		end if;
  	end process;
	
	process (current_state)
		begin
			reg1Enable <= '0';
			h_divided  <= '0';
			h_write    <= '0';
			incK 	   <= '0';	
			decK       <= '0';
			case current_state is
			    when Idle =>
         			 
                	    when state1 =>
              		         reg1Enable <= '1';
		
		            when state2 =>
				 h_divided  <= '1';
				
			    when state3 => 
				 incK 	    <= '1';
				
			    when state4 =>
				
			    when state5 => 
				 h_write    <= '1';
				 decK       <= '1';
		end case;
	end process;
end Architecture;
				 

		
	
