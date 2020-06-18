//////////////////////////////////////////////
// --- MODULE : Delay Line for FPGA TDC --- //
//////////////////////////////////////////////

`timescale 1ns/100ps


module DelayLine #(parameter integer Nmux)(
   
   input wire filtered_hit,
   
   output wire [Nmux-1:0] Z

   );
      
   
    generate 
   
      genvar k ;
	  
	  for (k = 0; k < Nmux; k = k + 1) begin
	  
	     if (k == 0)begin
	  
	     MUX (
		 
		    .A  (filtered_hit),
			.B  (        1'b0),
			.S  (        1'b1),
			.Z  (        Z[k])
			
			
		     );
	  
	     end //if
		 
		 else begin
		 
		 MUX (
		 
		    .A  (Z[k-1]),
			.B  (  1'b0),
			.S  (  1'b1),
			.Z  (  Z[k])
			
			
		     );
		  
		 end //else
		 
	  end // for
  
   endgenerate
      

endmodule