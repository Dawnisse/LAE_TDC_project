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
   
   reg  filtered_hit;
   wire [31:0]Z;

   DelayLine #(.Nmux(32)) DUT (
   
      .delay_line_in(filtered_hit), 
      .delay_line_out(Z)
	  
      ) ;  //CONNECTION

   // stimulus
   initial begin
  
      #0   filtered_hit = 1'b0;
		   
      #125 filtered_hit = 1'b1 ;
      #254 filtered_hit = 1'b0 ;
      
      #500 $finish ;           // stop the simulation
   end

endmodule

