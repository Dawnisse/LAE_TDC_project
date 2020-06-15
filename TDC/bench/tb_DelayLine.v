//
//
//

`define Num_FFMUX 4
`timescale 1ns / 100ps

module tb_DelayLine ;

   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen   ClockGen_inst (.clk(clk100)) ;

   // Device Under Test: DUT

   reg  clr;
   reg  HIT;
   wire [3:0] Q;

   DelayLine #(.Nffmux(`Num_FFMUX)) DUT (
   
      .HIT(   HIT), 
      .clk(clk100), 
      .clr(   clr),
      .Q  (     Q)
	  
      ) ;  //CONNECTION

   // stimulus
   initial begin
  
      #0   HIT = 1'b0;
      #0   clr = 1'b0;         // initial value at t=0
		   
      #510 HIT = 1'b1 ;
      #450 HIT = 1'b0 ;
      
      #500 $finish ;           // stop the simulation
   end

endmodule

