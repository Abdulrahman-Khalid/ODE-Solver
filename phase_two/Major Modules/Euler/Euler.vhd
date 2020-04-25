library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity Euler is
	port(M1Data1, M2Data1 : IN std_logic_vector (63 downto 0);
	     M1Data1W, M2Data1W : OUT std_logic_vector (63 downto 0);
	     M1Data2, M2Data2 : IN std_logic_vector (63 downto 0);
	     M1Address1, M1Address2, M2Address1,M2Address2 : OUT std_logic_vector (15 downto 0);
	     Un, Uz, Ti: OUT std_logic_vector (15 downto 0);
	     Uk: IN std_logic_vector (15 downto 0);
	     h_to_interpolation : OUT std_logic_vector (15 downto 0);
	     h_in : IN std_logic_vector (15 downto 0);
	     clk, rst, processCMD, Var1, Var2, Var3, Var4, Var5: IN std_logic;     -- h_write to be considered as input
	     selector: std_logic_vector (2 downto 0);
	     Shift_Interpolation, writeX, writeU, programDone, Failure : OUT std_logic);
end Euler;


Architecture EulerModule of Euler is


-- Bus control unit signals
signal elementDone, outputDone, vectorDone, converged, sameRaw, firstRaw, StoreEntry, initialize, h_enable, U_enable, VariableStep : std_logic;
signal decOut: std_logic_vector(1 to 10);
signal INIT, N, M, e, h, h_new, A, B, Xn, U, Tnum, TiReg, Xprev, XS1, to_H, to_U: std_logic_vector(15 downto 0);
signal precisionmode: std_logic_vector(1 downto 0);
-- Counter signals
signal AAddress     : std_logic_vector(15 downto 0) := "0000000000000011";
signal XAddress     : std_logic_vector(15 downto 0) := "0000100111000111";
signal TiAddress    : std_logic_vector(15 downto 0) := "0000100111000111";

signal BAddress     : std_logic_vector(15 downto 0) := "0000000000000010";
signal UcalcAddress : std_logic_vector(15 downto 0) := "0000100111000110";
signal UnAddress    : std_logic_vector(15 downto 0) := "0000100111111000";
signal UzAddress    : std_logic_vector(15 downto 0) := "0000101000101010";

signal InitAddress  : std_logic_vector(15 downto 0) := "0000000000000000";
signal EAddress    : std_logic_vector(15 downto 0) := "0000000000000000";
signal HAddress    : std_logic_vector(15 downto 0) := "0000000000000001";
signal TnumAddress : std_logic_vector(15 downto 0) := "0000000000000010";

signal XS1Address: std_logic_vector(15 downto 0) := "0000000000000010";
signal XS2Address: std_logic_vector(15 downto 0) := "0000000000000010";
signal XStoreAddress: std_logic_vector(15 downto 0) := "0000000000000010";
--signal M : std_logic_vector(15 downto 0) := "0000000000000000";
--signal N : std_logic_vector(15 downto 0) := "0000000000000000";
--signal T : std_logic_vector(15 downto 0) := "0000000000000000";

signal Max : std_logic_vector(15 downto 0):= "0000000000110010";
signal Mult : std_logic_vector(31 downto 0);

signal doneA, doneB, incXR, resetA_B, dummy : std_logic;
signal Add_B, Add_Ucalc,Add_A,Add_X, Add_XpreS,Add_XpreR,next_Add_Xpre,Add_Ti, Add_Un, Add_Uz, Add_xs1, Add_xs2: std_logic_vector(15 downto 0);

-- Main functionality signals
signal FinalOutput, A_X_product, B_U_product, Accumulator1, Accumulator2, AccTempA, AcctempB, h_out, resIntermediate1,resIntermediate2 : std_logic_vector(15 downto 0);
signal overflow1, overflow2, overflow3, Add, cout, carryFinal: std_logic;
signal C_A_X_D, C_A_X_Q, C_B_U_D, C_B_U_Q, enableAddX, enableAddU, reached, enable_addingA, enable_addingB, rstAcc_A_B: std_logic;

-- VariableStep handling signals
signal half_h: std_logic_vector(15 downto 0);
signal XstoreCounterEnable, XS1CounterEnable, XS2CounterEnable: std_logic;

begin
	
	mult <= Max * Max;
	Failure <= overflow1 or overflow2 or overflow3; 
	Shift_Interpolation <= decOut(6);  -- Ti
	storeEntry<= (not(variableStep) and elementDone)  or  (variableStep and not Var3 and elementDone);
	elementDone <= doneA and doneB;
	resetA_B <= rst or vectorDone;
	U_enable <= decOut(7) or decOut(8);
	incXR <= decOut(1) or decOut(9);
	--fsm: entity work.BussFSM port map( outputDone, firstRaw, StoreEntry, processCMD, 
         --   clk,rst, selector, initialize, writeX, writeU, Add);
	
	busDec: entity work.Decoder1 port map(selector, firstRaw, decOut);
	
	-- Euler registers
	Initreg: entity work.reg port map(M1Data2(15 downto 0), decOut(1), clk, INIT, rst); 
	Ereg: entity work.reg port map(M1Data1(15 downto 0), decOut(2), clk, e, rst);
	Hreg: entity work.reg port map(M1Data2(15 downto 0), decOut(3), clk, h, rst);       -- a mux is needed here!!
	Hsmaller:entity work.reg port map(h_in, var3, clk, h_new, rst);
	Areg: entity work.reg port map(M1Data1(15 downto 0), decOut(4), clk, A, rst);
	Breg: entity work.reg port map(M2Data2(15 downto 0), decOut(5), clk, B, rst); 
	Xnreg: entity work.reg port map(M1Data2(15 downto 0), decOut(4), clk, Xn, rst);
	Ureg: entity work.reg port map(to_U,U_enable , clk, U, rst);                 -- mux here!!(M2Data1)
	RegTi:entity work.reg port map(M1Data1(15 downto 0), decOut(6), clk, TiReg, rst);  
	XprevReg:entity work.reg port map(M1Data2(15 downto 0), decOut(9), clk, Xprev, rst);
	XS1Reg  :entity work.reg port map(M1Data1(15 downto 0), decOut(10), clk, XS1, rst);
	
	N <= "000"&Init(5 downto 0)&"0000000";
	M <= "000"&Init(11 downto 6)&"0000000";
	VariableStep <= Init(12);
	PrecisionMode<= Init(14 downto 13);
	Un <= M2Data1(15 downto 0);
	Uz <= M2Data2(15 downto 0);
	UMux: entity work.twoInpMux port map(Uk, M2Data1(15 downto 0), decOut(7), to_U);
----------------------------------------------------------------------------------------------------------------------
--dataIn ,offset ,load ,enable, CLK , reset ,universalReset ,continue:, dataOut : ,done, NFN:
	--signal ContinueXRead, XstoreCounterEnable
	--signal XStoreAddress, UzAddress
----------------------------------------------------------------------------------------------------------------------
	-- Euler Counters (Addresses) and Address Bus Muxes
	XstoreCounterEnable <= decOut(9) and (Var4 or not(VariableStep));
	XS1CounterEnable <= decOut(10) or (decOut(9) and Var1);
	XS2CounterEnable <= decOut(10) or (decOut(9) and Var2);
	XstoreStartAddress:ENTITY work.Addition1 PORT MAP (XAddress, N, '0' ,XStoreAddress, dummy);
	UzStartAddress:ENTITY work.Addition1 PORT MAP (UnAddress, M, '0' ,UzAddress, dummy);
	Acounter:      entity work.counter port map(AAddress, N, initialize, decOut(4), clk, '0', resetA_B, elementDone, Add_A, doneA, firstRaw);
    	XAddress <= AAddress + mult(15 downto 0);
   	x:      entity work.counter port map(XAddress, N, initialize, decOut(4), clk, elementDone, RST, '0', Add_X, dummy,dummy);
    	Xstore:   entity work.counter port map(XStoreAddress, N, initialize, XstoreCounterEnable, clk, vectorDone, RST,reached, Add_XpreS, vectorDone, dummy);
    	XpreRead:entity work.counter port map(XAddress, N, initialize, incXR, clk, '0',RST, vectorDone, Add_XpreR, dummy, dummy); -----------
	XS1Counter:entity work.counter port map(XS1Address, N, initialize,XS1CounterEnable , clk,vectorDone, RST,'0', Add_Xs1, dummy, dummy); ------------
    	XS2Counter:entity work.counter port map(XS2Address, N, initialize,XS2CounterEnable ,clk, vectorDone , rst, '0', Add_Xs2, dummy, dummy);
	TiAddress <= XAddress + Max;
    	TiCounter:     entity work.counter port map(TiAddress, Tnum, initialize, decOut(6), clk, '1', RST, '0', Add_Ti, programDone, dummy);
    
    	Bcounter:      entity work.counter port map(BAddress, M, initialize, decOut(5), clk, '0', resetA_B, elementDone, Add_B, doneB, dummy);
    	UcalcAddress <= BAddress + mult(15 downto 0);
    	Ucalc:  entity work.counter port map(UcalcAddress, M, initialize, decOut(7), clk, elementDone, RST, '0', Add_Ucalc, dummy,dummy);
    	UnAddress <= UcalcAddress + Max;
    	UnCounter:     entity work.counter port map(UnAddress, M, initialize, decOut(8), clk, elementDone, RST, reached, Add_Un, dummy,dummy);
    	UzAddress <= UnAddress + Max;
    	UZCounter:     entity work.counter port map(UzAddress, M, initialize, decOut(8), clk, elementDone, RST, reached, Add_Uz, dummy,dummy);

	M1A1:   entity work.M1Add1Mux port map(InitAddress, EAddress, Add_Ti, Add_A, Add_XpreS, Add_Xs1,Add_Xs2,selector, Var1,Var2,Var3, M1Address1);
	M1A2:   entity work.M1Add2Mux port map(HAddress, Add_X, Add_XpreR,Add_Xs2, selector, M1Address2);
	M2A1:   entity work.M2Add1Mux port map(Add_Ucalc, Add_Un, Add_Ucalc, selector, firstRaw, M2Address1);
	M2A2:   entity work.M2Add2Mux port map(Add_B, Add_Uz, selector, firstRaw,M2Address2);

	-- Euler Main Function
	enable_addingA <= enableAddX and not (doneA);
	enable_addingB <= enableAddU and not (doneB);
	rstAcc_A_B <= rst or elementDone;
	A_X_block: entity work.booth_multiplier port map(A, Xn, A_X_product, overflow1);
	B_U_block: entity work.booth_multiplier port map(B, U, B_U_product, overflow2);
	En_Add1:   entity work.flipflop port map(decOut(4),'1', clk, enableAddX, rst);
	En_Add2:   entity work.flipflop port map(Add,'1', clk, enableAddU, rst);
	Acc_A_X:   entity work.reg port map(Accumulator1, enableAddX, clk, AccTempA, rstAcc_A_B);
	Acc_B_U:   entity work.reg port map(Accumulator2, enableAddU, clk, AccTempB, rstAcc_A_B);
	C_A_X_FF:  entity work.flipflop port map(C_A_X_D, enableAddX,clk, C_A_X_Q, rstAcc_A_B);
	C_B_U_FF:  entity work.flipflop port map(C_B_U_D, enableAddU, clk, C_B_U_Q, rstAcc_A_B);   
	addition_A_X: ENTITY work.Addition1 PORT MAP (A_X_product, AccTempA, C_A_X_Q ,Accumulator1, C_A_X_D);
	addition_U_B: ENTITY work.Addition1 PORT MAP (B_U_product, AccTempB, C_B_U_Q ,Accumulator2, C_B_U_D);
	--h_out_mux: entity work.twoInpMux port map(h, half_h, h_divided, h_out);
	additioBoth:ENTITY work.Addition1 PORT MAP (Accumulator1, Accumulator2, '0' ,resIntermediate1, Cout);
	preFinal:  entity work.booth_multiplier port map(resIntermediate1, h_out, resIntermediate2, overflow3);
	final:     entity work.Addition1 port map (resIntermediate2, Xprev,'0',finalOutput,carryFinal);
	M1Data1W <= "000000000000000000000000000000000000000000000000"&Xprev;
	M2Data1W <= "000000000000000000000000000000000000000000000000"&U;


	-- Variable step handling
	--varStepFsm: entity work.StepFSM port map(rst, variableStep, elementDone, reg1Enable, h_divided, h_write, incK, decK); 
	half_h <= '0' & h(14 downto 0);
	
	 
end EulerModule;
