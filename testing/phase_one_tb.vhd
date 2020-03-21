Library IEEE;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;

ENTITY phase_one_tb IS
END ENTITY;

ARCHITECTURE phase_one_tb_arch OF phase_one_tb IS
    CONSTANT CLK_FREQ : integer := 100e6; -- 100 MHz
    CONSTANT CLK_PER  : time    := 1000 ms / CLK_FREQ;
    CONSTANT BITS_NUM : integer := 16;
    CONSTANT CASES_START : integer := 0;
    CONSTANT CASES_End : integer := 15;
    
    TYPE reg_type IS ARRAY(CASES_START TO CASES_End) OF std_logic_vector(BITS_NUM-1 DOWNTO 0);
    
    SIGNAL clk: std_logic := '0';
    ------------------------------- signals--------------------------------------
    SIGNAL A, B, add_output, mult_output : std_logic_vector(BITS_NUM-1 DOWNTO 0);
    SIGNAL add_overflow, mult_overflow: std_logic;
    -----------------------------------------------------------------------------
    FUNCTION to_string ( aa: std_logic_vector) RETURN string IS
        VARIABLE bb : string (1 to aa'length) := (OTHERS => NUL);
        VARIABLE stri : integer := 1; 
        BEGIN
            FOR i IN aa'RANGE LOOP
                bb(stri) := std_logic'IMAGE(aa((i)))(2);
            stri := stri+1;
            END LOOP;
        RETURN bb;
    END FUNCTION;
    
BEGIN    
    clk <= not clk after CLK_PER / 2;
    mult_0 : ENTITY work.Multiplication PORT MAP (A => A, B => B, output => mult_output, overFlow => mult_overFlow);
    add_0 : ENTITY work.fixed_addition PORT MAP (A => A, B => B, output => add_output, overFlow => add_overFlow);

    PROCESS
    CONSTANT a_inputs: reg_type := (
        0 =>  "0101010101010101",
        1 =>  "1101010101010101",
        2 =>  "0101010101010101",
        3 =>  "1101010101010101",
        4 =>  "1101010101010101",
        5 =>  "0000000001010000",
        6 =>  "1111111111111111",
        7 =>  "1000000000000000",
        8 =>  "0000000000000000",
        9 =>  "1111111000001111",
        10 => "0000000000000000",
        11 => "0000000000000000",
        12 => "0000001001111111",
        13 => "1000000101111111",
        14 => "0000000100000000",
        15 => "1000001000000000"
        );
    CONSTANT b_inputs: reg_type := (
        0 => "0011101010101001",
        1 => "0011101010101001",
        2 => "1011101010101001",
        3 => "1011101010101001",
        4 => "0101010101010101",
        5 => "1111111110101111",
        6 => "1111111111111111",
        7 => "1000000000000000",
        8 => "0000000000000000",
        9 => "1010010111111111",
        10 => "1010010111111111",
        11 => "0010010111111111",
        12 => "1000000101111111",
        13 => "0000001001111111",
        14 => "1000001000000000",
        15 => "1000001000000000"
        );
    ----------------------------- Multiplication Outputs---------------------------
    CONSTANT mult_res_outputs: reg_type := (
        0 => "0001101100101110",
        1 => "0111001000101110",
        2 => "1100011000101110",
        3 => "0001110100101110",
        4 => "1000111000011100",
        5 => "1111111111001101",
        6 => "0000000000000000",
        7 => "0000000000000000",
        8 => "0000000000000000",
        9 => "0101110101110111",
        10 => "0000000000000000",
        11 => "0000000000000000",
        12 => "1000100001111000",
        13 => "1000100001111000",
        14 => "0000010000000000",
        15 => "0000100000000000"
        );
    CONSTANT mult_overflow_outputs: std_logic_vector(CASES_START TO CASES_END) := (
        0 => '1',
        1 => '1',
        2 => '1',
        3 => '1',
        4 => '1',
        5 => '0',
        6 => '0',
        7 => '1',
        8 => '0',
        9 => '1',
        10 => '0',
        11 => '0',
        12 => '1',
        13 => '1',
        14 => '1',
        15 => '1'
        );
    ----------------------------- Addtion Outputs ---------------------------------
    CONSTANT add_res_outputs: reg_type := (
        0 => "1000111111111110",
        1 => "0000111111111110",
        2 => "0000111111111110",
        3 => "1000111111111110",
        4 => "0010101010101010",
        5 => "1111111111111111",
        6 => "1111111111111110",
        7 => "0000000000000000",
        8 => "0000000000000000",
        9 => "1010010000001110",
        10 => "1010010111111111",
        11 => "0010010111111111",
        12 => "1000001111111110",
        13 => "1000001111111110",
        14 => "1000001100000000",
        15 => "0000010000000000"
        );
    CONSTANT add_overflow_outputs: std_logic_vector(CASES_START TO CASES_END) := (
        0 => '1',
        1 => '0',
        2 => '0',
        3 => '0',
        4 => '0',
        5 => '0',
        6 => '0',
        7 => '1',
        8 => '0',
        9 => '0',
        10 => '0',
        11 => '0',
        12 => '0',
        13 => '0',
        14 => '0',
        15 => '1'
        );
    --------------------------------------- END TEST CASES INIT ---------------------------------------
    BEGIN
        --------------------------------------- TEST CASES ---------------------------------------
        FOR i IN CASES_START TO CASES_END LOOP
            A <= a_inputs(i);
            B <= b_inputs(i);
            WAIT FOR CLK_PER;
            ASSERT(mult_output = mult_res_outputs(i) and mult_overFlow = mult_overflow_outputs(i)) REPORT 
                "TEST MULTIPLICATION (ITERATION #" & integer'image(i) & 
                ") : OUTPUT OR OVERFLOW IS NOT EQUAL TO THE EXPECTED VALUE!!!, OUTPUT = "
                & to_string(mult_output) & ", AND OVERFLOW = " & std_logic'image(mult_overFlow) &
		        ", AND EXPECTED => OUTPUT = " & to_string(mult_res_outputs(i)) &     
                " AND OVERFLOW = " & std_logic'image(mult_overflow_outputs(i)) SEVERITY ERROR;        
            ASSERT(add_output = add_res_outputs(i) and add_overFlow = add_overflow_outputs(i)) REPORT 
                "TEST ADDITION (ITERATION #" & integer'image(i) & 
                ") : OUTPUT OR OVERFLOW IS NOT EQUAL TO THE EXPECTED VALUE!!!, OUTPUT = "
                & to_string(add_output) & ", AND OVERFLOW = " & std_logic'image(add_overFlow) &
                ", AND EXPECTED => OUTPUT = " & to_string(add_res_outputs(i)) &     
                " AND OVERFLOW = " & std_logic'image(add_overflow_outputs(i)) SEVERITY ERROR;    
        END LOOP;
        --------------------------------------- END TEST CASES  ---------------------------------------
        WAIT;
    END PROCESS;
END ARCHITECTURE;