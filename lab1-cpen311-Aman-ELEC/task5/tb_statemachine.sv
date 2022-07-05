module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

statemachine dut(.*);

logic slow_clock; 
logic resetb;
logic [3:0] dscore; 
logic [3:0] pscore; 
logic [3:0] pcard3;
logic load_pcard1;
logic load_pcard2;
logic load_pcard3;
logic load_dcard1;
logic load_dcard2;
logic load_dcard3;
logic player_win_light;
logic dealer_win_light;


initial begin
    slow_clock = 0;
    forever #5 slow_clock = ~slow_clock;
end

initial begin

resetb = 1'b0;
#10;
resetb = 1'b1;


// Case 1: WAIT -> DC2_D -> COMPARE -> NATURAL -> TIE

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    // inputs for NATURAL -> TIE state
    dscore <= 4'b1000; // Setting dscore to 8 to go to NATURAL
    pscore <= 4'b1000; // Setting same to go to TIE

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    

    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // TIE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b1)
    else $error("Incorrect TIE state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT (FINAL) state");
    #10;




// Case 2: WAIT -> DC2_D -> DC3_P -> NATURAL -> P_WIN (rule a)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0111; // Setting to 7 to go to NATURAL
    pscore <= 4'b0101; // Setting to 5 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pscore <= 4'b0110; // Assuming player score is now 6 after third card drawn (for dealer to win)

    #10;

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;

    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // D_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b1)
    else $error("Incorrect D_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 3: WAIT -> DC2_D -> DC3_P -> DC3_D -> NATURAL -> P_WIN (rule b)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0110; // Setting to 6 for rule b.
    pscore <= 4'b0000; // Setting to 0 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pcard3 <= 4'b0111; // Assuming player draws a 7 for third card
    pscore <= 4'b0111; // player now has score of 7

    #10;
    

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;

    // DC3_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b1 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_D state");

    dscore <= 4'b0000; // Assuming calculated score is 0

    #10;
    
    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 4: WAIT -> DC2_D -> DC3_P -> DC3_D -> NATURAL -> P_WIN (rule c)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0101; // Setting to 5 for rule c.
    pscore <= 4'b0000; // Setting to 0 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pcard3 <= 4'b0111; // Assuming player draws a 7 for third card
    pscore <= 4'b0111; // player now has score of 7

    #10;

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;

    // DC3_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b1 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_D state");

    dscore <= 4'b0000; // Assuming calculated score is 0

    #10;
    
    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 5: WAIT -> DC2_D -> DC3_P -> DC3_D -> NATURAL -> P_WIN (rule d)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0100; // Setting to 4 for rule d.
    pscore <= 4'b0000; // Setting to 0 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pcard3 <= 4'b0111; // Assuming player draws a 7 for third card
    pscore <= 4'b0111; // player now has score of 7

    #10;

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;

    // DC3_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b1 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_D state");

    dscore <= 4'b0000; // Assuming calculated score is 0

    #10;
    
    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 5: WAIT -> DC2_D -> DC3_P -> DC3_D -> NATURAL -> P_WIN (rule e)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0011; // Setting to 3 for rule e.
    pscore <= 4'b0000; // Setting to 0 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

     // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pcard3 <= 4'b0111; // Assuming player draws a 7 for third card
    pscore <= 4'b0111; // player now has score of 7

    #10;

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;

    // DC3_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b1 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_D state");

    dscore <= 4'b0000; // Setting to 0 for P win

    #10;
    
    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 6: WAIT -> DC2_D -> DC3_P -> DC3_D -> NATURAL -> P_WIN (rule f)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0010; // Setting to 2 for rule f.
    pscore <= 4'b0000; // Setting to 0 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

     // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pcard3 <= 4'b0111; // Assuming player draws a 7 for third card
    pscore <= 4'b0111; // player now has score of 7

    #10;

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;

    // DC3_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b1 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_D state");

    dscore <= 4'b0000; // Setting to 0 for P win

    #10;
    
    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 7: WAIT -> DC2_D -> DC3_P -> NATURAL -> P_WIN (fails rule e)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0011; // Setting to 3 for rule e.
    pscore <= 4'b0000; // Setting to 0 to have Player draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

     // DC3_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b1 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P state");

    pcard3 <= 4'b1000; // Assuming player draws a 8 for third card
    pscore <= 4'b1000; // player now has score of 8

    #10;

    // COMPARE_2
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE_2 state");
    #10;
   
    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;
    
// Case 8: WAIT -> DC2_D -> DC3_P_NO -> DC3_D -> NATURAL -> P_WIN

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0100; // Setting to 4 to draw third card
    pscore <= 4'b0111; // Setting to 7 for player to not draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // DC3_P_NO
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P_NO state");

    #10;

    // DC3_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b1 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_D state");

    dscore <= 4'b0000; // Setting to 0 for P win

    #10;

    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;


// Case 9: WAIT -> DC2_D -> DC3_P_NO -> NATURAL -> P_WIN (dealer does not draw third card)

resetb = 1'b0;
#10;
resetb = 1'b1;

 // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    dscore <= 4'b0110; // Setting to 6 to not draw third card
    pscore <= 4'b0111; // Setting to 7 for player to not draw third card

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // DC3_P_NO
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC3_P_NO state");

    #10;

    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");

    dscore <= 4'b0000; // Setting to 0 for P win

    #10;

    // P_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b1 && dealer_win_light == 1'b0)
    else $error("Incorrect P_WIN state");
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

// Case 10: WAIT -> DC2_D -> NATURAL -> D_WIN

resetb = 1'b0;
#10;
resetb = 1'b1;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");

    pscore <= 4'b0001; // Setting same to go to TIE
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    // inputs for NATURAL -> TIE state
    dscore <= 4'b1001; // Setting dscore to 9 to go to NATURAL

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // D_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b1)
    else $error("Incorrect D_WIN state");  
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT (FINAL) state");
    #10;

// Case 11: WAIT -> DC2_D -> NATURAL -> D_WIN

resetb = 1'b0;
#10;
resetb = 1'b1;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT state");
    #10;

    // DC1_P
    assert(load_pcard1 == 1'b1 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_P state");
    #10;

    // DC1_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b1 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC1_D state");
    #10;

    // DC2_P
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b1 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_P state");

    pscore <= 4'b0111; // Setting to 7
    #10;

    // DC2_D
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b1 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect DC2_D state");

    

    // inputs for NATURAL -> TIE state
    dscore <= 4'b1000; // Setting dscore to 8 to go to NATURAL

    #10;

    // COMPARE
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect COMPARE state");
    #10;

    // NATURAL
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect NATURAL state");
    #10;

    // D_WIN
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b1)
    else $error("Incorrect D_WIN state");  
    #10;

    // WAIT
    assert(load_pcard1 == 1'b0 && load_pcard2 == 1'b0 && load_pcard3 == 1'b0 &&
           load_dcard1 == 1'b0 && load_dcard2 == 1'b0 && load_dcard3 == 1'b0 &&
           player_win_light == 1'b0 && dealer_win_light == 1'b0)
    else $error("Incorrect WAIT (FINAL) state");
    #10;

end

endmodule
