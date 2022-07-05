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



module card7seg(input logic [3:0] SW, output logic [6:0] HEX0);
		
   // your code goes here
   always @(SW) begin

      case (SW)  //update 7-seg displays only if NOT in the final states 
      4'b0000: HEX0 = `OFF;
         
      4'b0001: HEX0 = `ACE;
         
      4'b0010: HEX0 = `TWO;
            
      4'b0011: HEX0 = `THREE;
            
      4'b0100: HEX0 = `FOUR;                   
         
      4'b0101: HEX0 = `FIVE;                       
         
      4'b0110: HEX0 = `SIX;                    
         
      4'b0111: HEX0 = `SEVEN;
            
      4'b1000: HEX0 = `EIGHT;
            
      4'b1001: HEX0 = `NINE;
   
      4'b1010: HEX0 = `ZERO;
   
      4'b1011: HEX0 = `JACK;

      4'b1100: HEX0 = `QUEEN;

      4'b1101: HEX0 = `KING;

      4'b1110: HEX0 = `OFF;

      4'b1111: HEX0 = `OFF;
         
      default: HEX0 = 7'bxxxxxxx;

      endcase
    
   end
 
endmodule


