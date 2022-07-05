module scorehand(input logic [3:0] card1, input logic [3:0] card2, input logic [3:0] card3, output logic [3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout. Be sure to review Verilog
// notes on bitwidth mismatches and signed/unsigned numbers.

// if any card is undefined, the value is 0

// wires to hold individual card value
logic [3:0] card1_value;
logic [3:0] card2_value;
logic [3:0] card3_value;

always @(card1, card2, card3) begin

    if (card1 === 4'bxxxx)
        card1_value = 4'b0000;
    else 
        card1_value = card1;

    if (card2 === 4'bxxxx)
        card2_value = 4'b0000;
    else 
        card2_value = card2;

    if (card3 === 4'bxxxx)
        card3_value = 4'b0000;
    else 
        card3_value = card3;

    total = (card1_value + card2_value + card3_value) % 10;


end



endmodule

