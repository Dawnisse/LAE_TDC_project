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

   input  wire enable,
   input  wire [15:0] thermo,       // 16-bit thermometric input
   output wire [3:0]  bin           // 4-bit  binary output

   ) ;
   
   assign  bin = ( ! enable) ? 0 : 
   
   (
     (thermo[0])  ? 0  : 
     (thermo[1])  ? 1  : 
     (thermo[2])  ? 2  : 
     (thermo[3])  ? 3  : 
     (thermo[4])  ? 4  : 
     (thermo[5])  ? 5  : 
     (thermo[6])  ? 6  : 
     (thermo[7])  ? 7  : 
     (thermo[8])  ? 8  : 
     (thermo[9])  ? 9  : 
     (thermo[10]) ? 10 : 
     (thermo[11]) ? 11 : 
     (thermo[12]) ? 12 : 
     (thermo[13]) ? 13 : 
     (thermo[14]) ? 14 : 15
	 
	); 
 
 endmodule 

