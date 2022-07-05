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

module tb_task4();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").

task4 dut(.*);

logic CLOCK_50;
logic [3:0] KEY;
logic [9:0] LEDR;
logic [6:0] HEX5; 
logic [6:0] HEX4; 
logic [6:0] HEX3;
logic [6:0] HEX2; 
logic [6:0] HEX1; 
logic [6:0] HEX0;

initial begin
    CLOCK_50 = 0;
    forever #1 CLOCK_50 = ~CLOCK_50;
end

initial begin
    KEY[0] = 0;
    forever #5 KEY[0] = ~KEY[0];
end

initial begin


KEY[3] = 1'b0;
#10;
KEY[3] = 1'b1;
#10;


// CASE 1

assert(HEX0 == `OFF && HEX1 == `OFF && HEX2 == `OFF && 
        HEX3 == `OFF && HEX4 == `OFF && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0000 && LEDR[7:4] == 4'b0000)
else $error("Incorrect WAIT state");

#10;


assert(HEX0 == `EIGHT && HEX1 == `OFF && HEX2 == `OFF && 
        HEX3 == `OFF && HEX4 == `OFF && HEX5 == `OFF &&
        LEDR[3:0] == 4'b1000 && LEDR[7:4] == 4'b0000)
else $error("Incorrect DC1_P state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `OFF && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `OFF && HEX5 == `OFF &&
        LEDR[3:0] == 4'b1000 && LEDR[7:4] == 4'b0011)
else $error("Incorrect DC1_D state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `OFF && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0011 && LEDR[7:4] == 4'b0011)
else $error("Incorrect DC2_P state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0011 && LEDR[7:4] == 4'b0011)
else $error("Incorrect DC2_D state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `OFF && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0011 && LEDR[7:4] == 4'b0011)
else $error("Incorrect COMPARE state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0000 && LEDR[7:4] == 4'b0011)
else $error("Incorrect DC3_P state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0000 && LEDR[7:4] == 4'b0011)
else $error("Incorrect NATURAL state");

#10;

assert(HEX0 == `EIGHT && HEX1 == `FIVE && HEX2 == `SEVEN && 
        HEX3 == `KING && HEX4 == `ZERO && HEX5 == `OFF &&
        LEDR[3:0] == 4'b0000 && LEDR[7:4] == 4'b0011)
else $error("Incorrect D_WIN state");

#10;


end



endmodule
