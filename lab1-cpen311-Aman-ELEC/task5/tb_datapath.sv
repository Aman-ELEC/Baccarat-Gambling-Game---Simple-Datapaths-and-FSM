// defining HEX numbers and letters
`define OFF 7'b1111111      //nothing is displayed
`define ZERO 7'b1000000         // 0
`define ACE 7'b0001000          // A
`define TWO 7'b0100100          // 2
`define THREE 7'b0110000        // 3
`define FOUR 7'b0011001         // 4
`define FIVE 7'b0010010         // 5
`define SIX 7'b0000010          // 6
`define SEVEN 7'b1111000        // 7
`define EIGHT 7'b0000000        // 8
`define NINE 7'b0010000         // 9

`define JACK 7'b1100001        // J
`define QUEEN 7'b0011000      // q
`define KING 7'b0001001      // H


module tb_datapath();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
datapath dut(.*);

logic slow_clock;
logic fast_clock;

logic resetb;
logic load_pcard1; 
logic load_pcard2; 
logic load_pcard3;
logic load_dcard1; 
logic load_dcard2; 
logic load_dcard3;
logic [3:0] pcard3_out;
logic [3:0] pscore_out; 
logic [3:0] dscore_out;
logic [6:0] HEX5; 
logic [6:0] HEX4; 
logic [6:0] HEX3;
logic [6:0] HEX2; 
logic [6:0] HEX1; 
logic [6:0] HEX0;


initial begin
    slow_clock = 0;
    forever #5 slow_clock = ~slow_clock;


end

initial begin

    fast_clock = 0;
    forever #1 fast_clock = ~fast_clock;

end

initial begin

resetb = 1'b0;
#10;
resetb = 1'b1;
// #10;

// CASE 1: WAIT -> COMPARE -> DC3_P -> COMPARE_2 -> DC3_D -> NATURAL -> D_WIN (rule f)

// WAIT -> All loads = 0

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

assert(HEX0 == `OFF && HEX1 == `OFF && HEX2 == `OFF && 
        HEX3 == `OFF && HEX4 == `OFF && HEX5 == `OFF &&
        pscore_out == 4'b0000 && dscore_out == 4'b0000)
else $error("Incorrect WAIT state");


load_pcard1 = 1'b1;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// DC1_P -> load_pcard1 = 1'b1

assert(HEX0 == `EIGHT && HEX1 == `OFF && HEX2 == `OFF && 
        HEX3 == `OFF && HEX4 == `OFF && HEX5 == `OFF &&
        pscore_out == 4'b1000 && dscore_out == 4'b0000)
else $error("Incorrect DC1_P state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b1;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// DC1_D -> load_dcard1 = 1'b1

assert(HEX0 == `EIGHT && HEX1 == `OFF && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `OFF && HEX5 == `OFF &&
        pscore_out == 4'b1000 && dscore_out == 4'b0000)
else $error("Incorrect DC1_D state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b1;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// DC2_P -> load_pcard2 = 1'b1

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `OFF && HEX5 == `OFF &&
        pscore_out == 4'b0011 && dscore_out == 4'b0000)
else $error("Incorrect DC2_P state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b1;
load_dcard3 = 1'b0;

#10;

// DC2_D -> load_dcard2 = 1'b1

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        pscore_out == 4'b0011 && dscore_out == 4'b0000)
else $error("Incorrect DC2_D state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// COMPARE -> all loads = 0

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        pscore_out == 4'b0011 && dscore_out == 4'b0000)
else $error("Incorrect COMPARE state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b1;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// DC3_P -> load_pcard3 = 1'b1 (because score is P:3  D:3)

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        pscore_out == 4'b0000 && dscore_out == 4'b0000)
else $error("Incorrect DC3_P state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// COMPARE_2 -> all loads = 0

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        pscore_out == 4'b0000 && dscore_out == 4'b0000)
else $error("Incorrect COMPARE_2 state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b1;

#10;

// DC3_D -> load_pcard3 = 1'b1 (because score is P:3  D:3)

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `FOUR &&
        pscore_out == 4'b0000 && dscore_out == 4'b0100)
else $error("Incorrect DC3_D state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// NATURAL -> all loads = 1'b0 (no conditions met)

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `FOUR &&
        pscore_out == 4'b0000 && dscore_out == 4'b0100)
else $error("Incorrect NATURAL state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;

// D_WIN -> all loads = 1'b0 

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `FOUR &&
        pscore_out == 4'b0000 && dscore_out == 4'b0100)
else $error("Incorrect D_WIN state");

load_pcard1 = 1'b0;
load_pcard2 = 1'b0;
load_pcard3 = 1'b0;
load_dcard1 = 1'b0;
load_dcard2 = 1'b0;
load_dcard3 = 1'b0;

#10;


end

endmodule
