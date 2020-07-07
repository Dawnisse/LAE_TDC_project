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

module ThermometerEncoder (

   input  wire [31:0]  thermo,    // 32-bit thermometer output code
   output wire  [4:0]   bin        //  5-bit base-2 binary input code

   ) ;

   
//   integer i ;
//
//   
//      for(i=0; i < 32; i=i+1) begin
//
//		assign bin = (thermo == {(32-i)'b1, (i)'b0}) ? i;
//	  
//	  end //for

endmodule


