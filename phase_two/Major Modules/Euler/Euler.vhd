library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity Euler is
	port(M1Data1, M2Data1 : IN std_logic_vector (31 downto 0);
	     M1Data1W, M2Data1W : OUT std_logic_vector (31 downto 0);
	     M1Data2, M2Data2 : IN std_logic_vector (31 downto 0);
	     M1Address1, M1Address2, M2Address1,M2Address2 : OUT std_logic_vector (15 downto 0);
	     Un, Uz, Ti: OUT std_logic_vector (15 downto 0);
	     Uk: IN std_logic_vector (15 downto 0);
	     h_to_interpolation : OUT std_logic_vector (15 downto 0);
	     h_in : IN std_logic_vector (15 downto 0);
	     clk, rst, processCMD, variableStep: IN std_logic;     -- h_write to be considered as input
	     Shift_Interpolation, writeX, writeU, programDone : OUT std_logic);
end Euler;


Architecture EulerModule of Euler is

-- Bus control unit signals
signal elementDone, outputDone, vectorDone, converged, sameRaw, firstRaw, StoreEntry, initialize, h_enable, U_enable : std_logic;
signal Mfinish, Nfinish : std_logic;
signal selector: std_logic_vector(2 downto 0);
signal decOut: std_logic_vector(1 to 13);
signal N, M, e, h, hstep, A, B, Xn, U, Tnum, TiReg, Xprev,  to_H, to_U: std_logic_vector(15 downto 0);

-- Counter signals
signal AAddress     : std_logic_vector(15 downto 0) := "0000000000000011";
signal XAddress     : std_logic_vector(15 downto 0) := "0000100111000111";
signal TiAddress    : std_logic_vector(15 downto 0) := "0000100111000111";

signal BAddress     : std_logic_vector(15 downto 0) := "0000000000000010";
signal UcalcAddress : std_logic_vector(15 downto 0) := "0000100111000110";
signal UnAddress    : std_logic_vector(15 downto 0) := "0000100111111000";
signal UzAddress    : std_logic_vector(15 downto 0) := "0000101000101010";

signal NAddress     : std_logic_vector(15 downto 0) := "0000000000000000";
signal MAddress    : std_logic_vector(15 downto 0) := "0000000000000001";
signal EAddress    : std_logic_vector(15 downto 0) := "0000000000000000";
signal HAddress    : std_logic_vector(15 downto 0) := "0000000000000001";
signal TnumAddress : std_logic_vector(15 downto 0) := "0000000000000010";
--signal M : std_logic_vector(15 downto 0) := "0000000000000000";
--signal N : std_logic_vector(15 downto 0) := "0000000000000000";
--signal T : std_logic_vector(15 downto 0) := "0000000000000000";

signal Max : std_logic_vector(15 downto 0):= "0000000000110010";
signal Mult : std_logic_vector(31 downto 0);

signal doneA, doneX, doneXpreRead, doneB, doneUcalc, doneUn, doneUz, repeat, Continue,incXR, resetA_B : std_logic;
signal Add_B, Add_Ucalc,Add_A,Add_X, Add_XpreS,Add_XpreR,next_Add_Xpre,Add_Ti, Add_Un, Add_Uz: std_logic_vector(15 downto 0);

-- Main functionality signals
signal FinalOutput, A_X_product, B_U_product, Accumulator1, Accumulator2, AccTempA, AcctempB, h_out, resIntermediate1,resIntermediate2 : std_logic_vector(15 downto 0);
signal overflow1, overflow2, overflow3, Add, cout, carryFinal: std_logic;
signal C_A_X_D, C_A_X_Q, C_B_U_D, C_B_U_Q, enableAddX, enableAddU: std_logic;

-- VariableStep handling signals
signal reg1Enable, h_divided, h_write, incK, decK: std_logic;
signal reg1Out, half_h: std_logic_vector(15 downto 0);

begin
	mult <= Max * Max;
	firstRaw <= '0';
	storeEntry<= (not(variableStep) and elementDone)  or  (variableStep and converged and h_write);
	elementDone <= doneA and doneB;
	repeat   <= variableStep and elementDone and not(converged and h_write);
	continue <= (elementDone and converged and h_write and variableStep) or not(variableStep);
	resetA_B <= rst or vectorDone;
	U_enable <= decOut(10) or decOut(9);
	incXR <= decOut(13) or decOut(12);
	fsm: entity work.BussFSM port map( outputDone, firstRaw, StoreEntry, processCMD, 
            clk,rst, selector, initialize, writeX, writeU, Add);
	
	busDec: entity work.Decoder port map(selector, firstRaw, decOut);
	
	-- Euler registers
	Nreg: entity work.reg port map(M1Data1(15 downto 0), decOut(1), clk, N, rst);
	Mreg: entity work.reg port map(M1Data2(15 downto 0), decOut(2), clk, M, rst); 
	Ereg: entity work.reg port map(M2Data1(15 downto 0), decOut(3), clk, e, rst);
	Hreg: entity work.reg port map(M2Data2(15 downto 0), decOut(4), clk, h, rst);       -- a mux is needed here!!
	Hsmaller:entity work.reg port map(h_in, h_write, clk, hstep, rst);
	Areg: entity work.reg port map(M1Data1(15 downto 0), decOut(5), clk, A, rst);
	Breg: entity work.reg port map(M2Data2(15 downto 0), decOut(6), clk, M, rst); 
	Xnreg: entity work.reg port map(M1Data2(15 downto 0), decOut(7), clk, e, rst);
	Ureg: entity work.reg port map(to_U,U_enable , clk, U, rst);                 -- mux here!!(M2Data1)
	RegTi:entity work.reg port map(M1Data1(15 downto 0), decOut(8), clk, TiReg, rst);  
	TnumReg: entity work.reg port map(M1Data1(15 downto 0), decOut(12), clk, Tnum, rst);
	XprevReg:entity work.reg port map(M1Data2(15 downto 0), decOut(13), clk, Xprev, rst);
	
	Un <= M2Data1(15 downto 0);
	Uz <= M2Data2(15 downto 0);
	Shift_Interpolation <= decOut(8);  -- Ti
	UMux: entity work.twoInpMux port map(Uk, M2Data1(15 downto 0), decOut(9), to_U);

	-- Euler Counters (Addresses) and Address Bus Muxes
	Acounter:      entity work.counter port map(AAddress, N, initialize, decOut(5), clk, repeat, resetA_B, Continue, Add_A, doneA);
    	XAddress <= AAddress + mult(15 downto 0);
   	x:      entity work.counter port map(XAddress, N, initialize, decOut(7), clk, '1', RST, '0', Add_X, doneX);
    	Xpre:   entity work.counterNext port map(XAddress, N, initialize, decOut(13), clk, RST, Add_XpreS, next_Add_Xpre, vectorDone);
    	XpreRead:entity work.counterNext port map(XAddress, N, initialize, incXR, clk, RST, Add_XpreR, next_Add_Xpre, doneXpreRead);
	TiAddress <= XAddress + Max;
    	TiCounter:     entity work.counter port map(TiAddress, Tnum, initialize, decOut(8), clk, '1', RST, '0', Add_Ti, programDone);
    
    	Bcounter:      entity work.counter port map(BAddress, M, initialize, decOut(6), clk, repeat, resetA_B, Continue, Add_B, doneB);
    	UcalcAddress <= BAddress + mult(15 downto 0);
    	Ucalc:  entity work.counter port map(UcalcAddress, M, initialize, decOut(9), clk, '1', RST, '0', Add_Ucalc, doneUcalc);
    	UnAddress <= UcalcAddress + Max;
    	UnCounter:     entity work.counter port map(UnAddress, M, initialize, decOut(10), clk, repeat, RST, Continue, Add_Un, doneUn);
    	UzAddress <= UnAddress + Max;
    	UZCounter:     entity work.counter port map(UzAddress, M, initialize, decOut(11), clk, repeat, RST, Continue, Add_Uz, doneUz);

	M1A1:   entity work.M1Add1Mux port map(NAddress, Add_A, Add_Ti, Add_XpreS, TnumAddress, selector, M1Address1);
	M1A2:   entity work.M1Add2Mux port map(MAddress, Add_X, Add_XpreR, selector, M1Address2);
	M2A1:   entity work.M2AddMux port map(EAddress, Add_Un, Add_Ucalc, selector, firstRaw, M2Address1);
	M2A2:   entity work.M2AddMux port map(HAddress, Add_B, Add_Uz, selector, firstRaw,M2Address2);

	-- Euler Main Function
	A_X_block: entity work.booth_multiplier port map(A, Xn, A_X_product, overflow1);
	B_U_block: entity work.booth_multiplier port map(B, U, B_U_product, overflow2);
	En_Add1:   entity work.flipflop port map(decOut(5),'1', clk, enableAddX, rst);
	En_Add2:   entity work.flipflop port map(Add,'1', clk, enableAddU, rst);
	Acc_A_X:   entity work.reg port map(Accumulator1, enableAddX, clk, AccTempA, rst);
	Acc_B_U:   entity work.reg port map(Accumulator2, enableAddU, clk, AccTempB, rst);
	C_A_X_FF:  entity work.flipflop port map(C_A_X_D, enableAddX,clk, C_A_X_Q, rst);
	C_B_U_FF:  entity work.flipflop port map(C_B_U_D, enableAddU, clk, C_B_U_Q, rst);   
	addition_A_X: ENTITY work.Addition1 PORT MAP (A_X_product, AccTempA, C_A_X_Q ,Accumulator1, C_A_X_D);
	addition_U_B: ENTITY work.Addition1 PORT MAP (B_U_product, AccTempB, C_B_U_Q ,Accumulator2, C_B_U_D);
	h_out_mux: entity work.twoInpMux port map(h, half_h, h_divided, h_out);
	additioBoth:ENTITY work.Addition1 PORT MAP (Accumulator1, Accumulator2, '0' ,resIntermediate1, Cout);
	preFinal:  entity work.booth_multiplier port map(resIntermediate1, h_out, resIntermediate2, overflow3);
	final:     entity work.Addition1 port map (resIntermediate2, Xprev,'0',finalOutput,carryFinal);
	M1Data1W <= "0000000000000000"&Xprev;
	M2Data1W <= "0000000000000000"&U;


	-- Variable step handling
	varStepFsm: entity work.StepFSM port map(rst, variableStep, elementDone, reg1Enable, h_divided, h_write, incK, decK); 
	TempReg: entity work.reg port map(finalOutput,reg1Enable , clk, reg1Out, rst);
	half_h <= '0' & h(14 downto 0);
	
	 
end EulerModule;
