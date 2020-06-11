//
//
//

`timescale 1ns / 100ps

module tb_DelayLine ;

   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen   ClockGen_inst (.clk(clk100)) ;

   // Device Under Test: DUT

   reg  HIT;
   reg [3:0]Z;
   wire CountOn;

   DelayLine  DUT (.HIT(HIT), .CLK(clk100), .CountOn(CountOn), .Z(Z[3:0])) ;  //CONNECTION

   // stimulus
   initial begin

      #0   HIT = 1'b0 ;     // initial value at t=0
		   
      #510 HIT = 1'b1 ;
      #450 HIT = 1'b0 ;
      
      #500 $finish ;           // stop the simulation
   end

endmodule

