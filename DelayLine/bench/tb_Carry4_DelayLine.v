/////////////////////////////////////////////////////////////////
//*----- MODULE DELAY LINE WITH CARRY4 XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module tb_Carry4_DelayLine ;


   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen  ClockGen_inst ( .clk(clk100) ) ;

   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg CI;
   wire CYINIT  = 1'b0;
   wire [3:0]DI = 4'b0000;
   wire [3:0]S  = 4'b1111;
   wire [3:0]O;
   wire [3:0]CO;

   Carry4_DelayLine   DUT (
   
      .CO(CO),          // 4-bit carry out
      .O(O),            // 4-bit carry chain XOR data out
      .CI(CI),          // 1-bit carry cascade input
      .CYINIT(CYINIT),  // 1-bit carry initialization
      .DI(DI),          // 4-bit carry-MUX data in
      .S(S)             // 4-bit carry-MUX select input

    
      ) ;

   //////////////////
   //   stimulus   //
   //////////////////

   initial begin
   
      #0 CI = 1'b0;
	  
	  #110 CI = 1'b1;
	  
	  #500 CI = 1'b0;
	  
	  #600 $finish;
	  
	 end;
	 
endmodule