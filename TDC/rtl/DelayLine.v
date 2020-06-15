//////////////////////////////////////////////
// --- MODULE : Delay Line for FPGA TDC --- //
//////////////////////////////////////////////

`timescale 1ns/100ps


module DelayLine #(parameter integer Nffmux)(
   
   input  wire HIT,           // hit signal
   input  wire clk,           // clock signal
   input  wire clr,
   
   output reg [Nffmux-1:0] Q  // output vector 
  
   );
   
   wire GND = 1'b0 ;   
   wire [Nffmux:0] w ;        //Nmux + 1 wires
   
   assign w[0] = HIT ;
   
    generate 
   
      genvar k ;
	  
	  for (k = 0; k < Nffmux; k = k + 1) begin : lenght
	  
	     FFMUX   lenght (
		 
		    .A  (   w[k]),
			.B  (    GND),
			.clk(    clk),
			.clr(    clr),
			.Z  ( w[k+1]),
			.Q  (   Q[k])
			
		    );
	  
	  end // for
  
   endgenerate
      

endmodule