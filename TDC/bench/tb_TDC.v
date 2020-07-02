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
   wire [4:0]bin_out;
   wire [3:0]out_count;
   
   
   TDC DUT(
   
      .clk(clk100),
	  .hit(hit),
	  .bin_out(bin_out),
	  .out_count(out_count)
    
   );
   
   //stimulus
   
   initial begin
   
     #0   hit = 1'b0;
	 #55  hit = 1'b1;
	 #240 hit = 1'b0;
	 
	 #500 $finish ;  
   
   end //stimulus
   
endmodule