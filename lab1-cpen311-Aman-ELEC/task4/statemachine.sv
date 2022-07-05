// This code represents our statemachine for our Lab1.
// It contains two instantiated modules: One for combinational logic (controlling loads) and one for moving from state to state


// defining the states (encoding)
`define WAIT 4'b0000 // Game has not begun
`define DC1_P 4'b0001  // Deal Card #1 P1
`define DC2_P 4'b0010  // Deal Card #2 P1
`define DC3_P 4'b0011  // Deal Card #3 P1

`define DC1_D 4'b0100  // Deal Card #1 DL  
`define DC2_D 4'b0101  // Deal Card #2 DL
`define DC3_D 4'b0110  // Deal Card #3 DL

`define DC3_P_NO 4'b0111 // Do not deal Card #3 to P1
`define NATURAL 4'b1000 // Game Over 

`define TIE 4'b1001 // P1 score == DL score
`define P_WIN 4'b1010 // P1 score > DL score
`define D_WIN 4'b1011 // P1 score < DL score

`define COMPARE 4'b1100 // Comparing player and dealer scores after 2 cards drawn to each


//************************************
module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);

// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

logic [3:0] state; // output of mooremachine, input to combinational

// instanting modules

// mooremachine part of the statemachine -> for the state transitions 
    statemachine_mooremachine mooremachine(slow_clock, resetb, dscore, pscore, pcard3, state);

// combinational logic for statemachine
    statemachine_combinational combinational(state, 
                                            load_pcard1, load_pcard2, load_pcard3,
                                            load_dcard1, load_dcard2, load_dcard3,
                                            player_win_light, dealer_win_light);



endmodule

//************************************




module statemachine_mooremachine(input logic slow_clock, input logic resetb,
                                input logic [3:0] dscore, input logic [3:0] pscore, 
                                input logic [3:0] pcard3, 
                                output logic [3:0] state);

    // wire declarations
    logic [3:0] present_state; // hold present state to check for next state

    always @(posedge slow_clock) begin
        
        if (resetb == 0) begin
            present_state = `WAIT;
        end else begin
            case(present_state)

                // States for dealing first two cards

                `WAIT: present_state = `DC1_P; // Always true

                `DC1_P: present_state = `DC1_D; // Always true

                `DC1_D: present_state = `DC2_P; // Always true

                `DC2_P: present_state = `DC2_D; // Always true. Here we have all scores loaded
                
                `DC2_D: present_state = `COMPARE; // Going here to compare scores and check conditions

                // Deciding the state after two cards delt

                `COMPARE: if (dscore == 4'b1000 || dscore == 4'b1001)
                    present_state = `NATURAL;
                    else if (pscore == 4'b1000 || pscore == 4'b1001)
                    present_state = `NATURAL;
                    else if (pscore == 4'b0000 || pscore == 4'b0001 || pscore == 4'b0010 || pscore == 4'b0011 || pscore == 4'b0100 || pscore == 4'b0101)
                    present_state = `DC3_P;
                    else if (pscore == 4'b0110 || pscore == 4'b0111)
                    present_state = `DC3_P_NO;
                    else
                    present_state = 4'bxxxx; // No matching input.

                // pscore <= 5

                `DC3_P: if (dscore == 4'b0111)
                    present_state = `NATURAL;
                    else if (dscore == 4'b0110 && (pcard3 == 4'b0110 || pcard3 == 4'b0111))
                    present_state = `DC3_D;
                    else if (dscore == 4'b0101 && (pcard3 == 4'b0100 || pcard3 == 4'b0101 || pcard3 == 4'b0110 || pcard3 == 4'b0111 ))
                    present_state = `DC3_D;
                    else if (dscore == 4'b0101 && (pcard3 == 4'b0010 || pcard3 == 4'b0011 || pcard3 == 4'b0100 || pcard3 == 4'b0101 || pcard3 == 4'b0110 || pcard3 == 4'b0111 ))
                    present_state = `DC3_D;
                    else if (dscore == 4'b0100 && pcard3 != 4'b1000)
                    present_state = `DC3_D;
                    else if (dscore == 4'b0000 || dscore == 4'b0001 || dscore == 4'b0010)
                    present_state = `DC3_D;
                    else 
                    present_state = `NATURAL; // Dealer does not pick up card if did not meet the above conditions for this state
               
                `DC3_P_NO: if (dscore == 4'b0000 || dscore == 4'b0001 || dscore == 4'b0010 || dscore == 4'b0011 || 
                             dscore == 4'b0100 || dscore == 4'b0101)
                    present_state = `DC3_D;
                    else
                    present_state = `NATURAL;
                
                `DC3_D: present_state = `NATURAL;
                
                `NATURAL: if (pscore == dscore)
                    present_state = `TIE;
                    else if (pscore > dscore)
                    present_state = `P_WIN;
                    else 
                    present_state = `D_WIN;

                // End game. Go back to wait state for new game

                `TIE: present_state = `WAIT; // Always true
                `P_WIN: present_state = `WAIT; // Always true
                `D_WIN: present_state = `WAIT; // Always true
                
                default: present_state = 4'bxxxx;


            endcase           
    
        end

        state = present_state; // update the output wire 

    end

endmodule

module statemachine_combinational(input logic [3:0] state,  
                                output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                                output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                                output logic player_win_light, output logic dealer_win_light);

    // here we check for what state we are in to output corresponding output value

    always @(state) begin
        
        case(state)

        `WAIT: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0; 
        
        end

        `DC1_P: begin
            load_pcard1 = 1'b1;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `DC1_D: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b1;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `DC2_P: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b1;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `DC2_D: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b1;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;

            
        
        end

        `COMPARE: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;

            
        
        end

        

        `DC3_P: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b1;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `DC3_P_NO: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `DC3_D: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b1;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `NATURAL: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b0;
        
        end

        `TIE: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b1;
            dealer_win_light = 1'b1;
        
        end

        `P_WIN: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b1;
            dealer_win_light = 1'b0;
        
        end

        `D_WIN: begin
            load_pcard1 = 1'b0;
            load_pcard2 = 1'b0;
            load_pcard3 = 1'b0;

            load_dcard1 = 1'b0;
            load_dcard2 = 1'b0;
            load_dcard3 = 1'b0;

            player_win_light = 1'b0;
            dealer_win_light = 1'b1;
        
        end

        default: begin
            load_pcard1 = 1'bx;
            load_pcard2 = 1'bx;
            load_pcard3 = 1'bx;

            load_dcard1 = 1'bx;
            load_dcard2 = 1'bx;
            load_dcard3 = 1'bx;

            player_win_light = 1'bx;
            dealer_win_light = 1'bx;
        
        end

        endcase   

    end

endmodule







