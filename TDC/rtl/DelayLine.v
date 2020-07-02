//////////////////////////////////////////////
// --- MODULE : Delay Line for FPGA TDC --- //
//////////////////////////////////////////////

`timescale 1ns/100ps


module DelayLine #(parameter integer Nmux = 32)(
   
   input wire filtered_hit,
   
   output wire [Nmux-1:0] Z

   );
      
///// MUXF7: CLB MUX to tie two LUT6's together with general output
///// 7 Series
///// Xilinx HDL Libraries Guide, version 2012.2
//   MUXF7 MUXF7_inst (
//      .O (        Z[k]),        // Output of MUX to general routing
//      .I0(filtered_hit),        // Input (tie to LUT6 O6 pin)
//      .I1(        1'b0),        // Input (tie to LUT6 O6 pin)
//      .S (        1'b0)         // Input select to MUX
//   );
// End of MUXF7_inst instantiation   
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