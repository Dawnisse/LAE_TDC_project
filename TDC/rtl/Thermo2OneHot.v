//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       ThermometerDecoder.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 5, 2020
// [Modified]       -
// [Description]    Behavioural implementation using for-loop of a 5-bit/32-bit thermometer decoder.
// [Notes]          -
// [Version]        1.0
// [Revisions]      05.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

`timescale 1ns / 100ps

module Thermo2OneHot (

   input  wire [199:0]  thermo,    // 32-bit thermometer output code
   output wire [194:0]   one_hot        //  5-bit base-2 binary input code

   ) ;

generate

   genvar k;
   
   for (k = 0; k <= 194 ; k = k + 1) begin

// LUT6: 6-input Look-Up Table with general output
// 7 Series
// Xilinx HDL Libraries Guide, version 2012.2
   LUT6 #(
   .INIT(64'h4000000000000000) // Specify LUT Contents
   ) 
   LUT6_inst (
      .O ( one_hot[k]), // LUT general output
      .I0(  thermo[k]), // LUT input
      .I1(thermo[k+1]), // LUT input
      .I2(thermo[k+2]), // LUT input
      .I3(thermo[k+3]), // LUT input
      .I4(thermo[k+4]), // LUT input
      .I5(thermo[k+5]) // LUT input
   );
// End of LUT6_inst instantiation

   end //for
endgenerate
	  
endmodule


