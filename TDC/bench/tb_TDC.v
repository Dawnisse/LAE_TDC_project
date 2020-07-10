//
//
//

`timescale 1ns / 100ps

module tb_TDC ;

   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen   ClockGen_inst (.clk(clk100)) ;
   
   //Device Under Test : DUT
   
   reg hit;
   wire [4:0]bin_out_start;
   wire [4:0]bin_out_stop;
   wire [3:0]out_count;
   
   
   TDC DUT(
   
      .clk(clk100),
	  .hit(hit),
	  .bin_out_start(bin_out_start),
	  .bin_out_stop(bin_out_stop),
	  .out_count(out_count)
    
   );
   
   //stimulus
   
   initial begin
   
     #0   hit = 1'b0;
	 #122  hit = 1'b1;
	 #159 hit = 1'b0;
	 #232 hit = 1'b1;
	 #243 hit = 1'b0;
	 
	 #300 $finish ;  
   
   end //stimulus
   
endmodule