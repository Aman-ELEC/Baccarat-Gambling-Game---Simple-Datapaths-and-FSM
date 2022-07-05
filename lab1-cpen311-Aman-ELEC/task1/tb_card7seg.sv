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


module tb_card7seg();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

    logic [3:0] SW;
    logic [6:0] HEX0;

card7seg dut(.*);

initial begin

    SW = 4'b0000;
    #10;
    assert(HEX0 == `OFF)
    else $error("Incorrect display");
    #10;

    SW = 4'b0001;
    #10;
    assert(HEX0 == `ACE)
    else $error("Incorrect display");
    #10;

    SW = 4'b0010;
    #10;
    assert(HEX0 == `TWO)
    else $error("Incorrect display");
    #10

    SW = 4'b0011;
    #10;
    assert(HEX0 == `THREE)
    else $error("Incorrect display");
    #10;

    SW = 4'b0100;
    #10;
    assert(HEX0 == `FOUR)
    else $error("Incorrect display");
    #10;

    SW = 4'b0101;
    #10;
    assert(HEX0 == `FIVE)
    else $error("Incorrect display");
    #10;

    SW = 4'b0110;
    #10;
    assert(HEX0 == `SIX)
    else $error("Incorrect display");
    #10;

    SW = 4'b0111;
    #10;
    assert(HEX0 == `SEVEN)
    else $error("Incorrect display");
    #10;

    SW = 4'b1000;
    #10;
    assert(HEX0 == `EIGHT)
    else $error("Incorrect display");
    #10;

    SW = 4'b1001;
    #10;
    assert(HEX0 == `NINE)
    else $error("Incorrect display");
    #10;

    SW = 4'b1010;
    #10;
    assert(HEX0 == `ZERO)
    else $error("Incorrect display");
    #10;

    SW = 4'b1011;
    #10;
    assert(HEX0 == `JACK)
    else $error("Incorrect display");
    #10;

    SW = 4'b1100;
    #10;
    assert(HEX0 == `QUEEN)
    else $error("Incorrect display");
    #10;
    
    SW = 4'b1101;
    #10;
    assert(HEX0 == `KING)
    else $error("Incorrect display");
    #10;

    SW = 4'b1110;
    #10;
    assert(HEX0 == `OFF)
    else $error("Incorrect display");
    #10;

    SW = 4'b1111;
    #10;
    assert(HEX0 == `OFF)
    else $error("Incorrect display");
    #10;



end



endmodule

