//////////////////////////////////////////////
// --- MODULE : Delay Line for FPGA TDC --- //
//////////////////////////////////////////////

`timescale 1ns/100ps


module DelayLine #(parameter integer Nmux = 32)(
   
   input wire delay_line_in,
   
   output wire [Nmux-1:0] delay_line_out

   );
       
    generate 
   
      genvar k ;
	  
	  for (k = 0; k < Nmux; k = k + 1) begin :mux
	  
	     if (k == 0)begin
	  
	     MUX mux(
		 
		    .A  (delay_line_in),
			.B  (         1'b0),
			.S  (         1'b1),
			.Z  (delay_line_out[k])
			
			
		     );
	  
	     end //if
		 
		 else begin
		 
		 MUX mux(
		 
		    .A  (delay_line_out[k-1]),
			.B  (  1'b0),
			.S  (  1'b1),
			.Z  (  delay_line_out[k])
			
			
		     );
		  
		 end //else
		 
	  end // for
  
   endgenerate
      

endmodule