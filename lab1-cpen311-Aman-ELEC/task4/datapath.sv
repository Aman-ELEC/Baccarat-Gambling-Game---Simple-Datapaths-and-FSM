// This is the code for our datapath for lab1. 
// It contains all instantiated modules except for statemachine.
// It follows the overall block diagram on the github


module datapath(input logic slow_clock, input logic fast_clock, input logic resetb,
                input logic load_pcard1, input logic load_pcard2, input logic load_pcard3,
                input logic load_dcard1, input logic load_dcard2, input logic load_dcard3,
                output logic [3:0] pcard3_out,
                output logic [3:0] pscore_out, output logic [3:0] dscore_out,
                output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
                output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);
						
// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code.

logic [3:0] new_card; // wire coming out of dealcard, going into reg4

logic [3:0] p_card1; // wire coming out of reg4 PC1, going into card7seg AND scorehand
logic [3:0] p_card2; // wire coming out of reg4 PC2, going into card7seg AND scorehand
// logic [3:0] p_card3; // dont need this as there is a pcard3_out declared 

logic [3:0] d_card1; // wire coming out of reg4 DC1, going into card7seg AND scorehand
logic [3:0] d_card2; // wire coming out of reg4 DC2, going into card7seg AND scorehand
logic [3:0] d_card3; // wire coming out of reg4 DC3, going into card7seg AND scorehand

// logic player_win_light; // wire for LEDR(8)
// logic dealer_win_light; // wire for LEDR(9)

dealcard DC(fast_clock, resetb, new_card);

// registers for player
reg4 PC1(new_card, load_pcard1, slow_clock, resetb, p_card1);
card7seg C7P1(p_card1, HEX0);

reg4 PC2(new_card, load_pcard2, slow_clock, resetb, p_card2);
card7seg C7P2(p_card2, HEX1);

reg4 PC3(new_card, load_pcard3, slow_clock, resetb, pcard3_out);
card7seg C7P3(pcard3_out, HEX2);

// scorehand for player
scorehand SHP(p_card1, p_card2, pcard3_out, pscore_out);

// registers for dealer
reg4 DC1(new_card, load_dcard1, slow_clock, resetb, d_card1);
card7seg C7D1(d_card1, HEX3);

reg4 DC2(new_card, load_dcard2, slow_clock, resetb, d_card2);
card7seg C7D2(d_card2, HEX4);

reg4 DC3(new_card, load_dcard3, slow_clock, resetb, d_card3);
card7seg C7D3(d_card3, HEX5);

// scorehand for dealer
scorehand SHD(d_card1, d_card2, d_card3, dscore_out);

// instiating statemachine

// statemachine SM(slow_clock, resetb, 
//                 dscore_out, pscore_out, pcard3_out,
//                 load_pcard1, load_pcard2, load_pcard3,
//                 load_dcard1, load_dcard2, load_dcard3,
//                 player_win_light, dealer_win_light);


endmodule


/*
module reg4(input logic [3:0] new_card, input logic load,
            input logic slow_clock, input logic resetb,
            output logic [3:0] card);
        
        logic [3:0] next_state_out;

        assign next_state_out = load ? new_card : card;

        flipflop_asyncr ffa(slow_clock, next_state_out, resetb, card);

endmodule

module flipflop_asyncr(input logic slow_clock, input logic [3:0] next_state_out,
                        input logic resetb, output logic [3:0] card);
        
        always_ff @(posedge slow_clock) begin
            if (resetb == 0)
                card <= 4'b0000;
            else
                card <= next_state_out;
        end

endmodule

*/

// 01-synthisizable-verilog.pdf slide 29: better transistor level implementation
module reg4(input logic [3:0] new_card, input logic load,
            input logic slow_clock, input logic resetb,
            output logic [3:0] card);

            always_ff @(posedge slow_clock) begin
            if (resetb == 0)
                card <= 4'b0000;
            else if (load == 1)
                card <= new_card;
            else
                card <= card;
        end

endmodule