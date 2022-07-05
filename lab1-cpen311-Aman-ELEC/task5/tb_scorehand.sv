module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic [3:0] card1;
logic [3:0] card2;
logic [3:0] card3;

logic [3:0] total;


scorehand dut(.*);


initial begin

    card1 = 4'b0000;
    card2 = 4'b0000;
    card3 = 4'b0000;
    #10
    assert(total == 4'b0000)
    else $error("Incorrect total");
    #10;

    card1 = 4'b1000;
    card2 = 4'b1000;
    card3 = 4'b1000;
    #10
    assert(total == 4'b0100)
    else $error("Incorrect total for mod case (expecting 4)");
    #10;

    card1 = 4'b0001;
    card2 = 4'bxxxx;
    card3 = 4'bxxxx;
    #10
    assert(total == 4'b0001)
    else $error("Incorrect total for only card1 defined");
    #10;

    card1 = 4'b0001;
    card2 = 4'b0001;
    card3 = 4'bxxxx;
    #10
    assert(total == 4'b0010)
    else $error("Incorrect total for card3 undefined");
    #10;
   


    

end

endmodule
