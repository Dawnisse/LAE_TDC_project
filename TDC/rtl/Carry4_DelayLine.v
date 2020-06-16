/////////////////////////////////////////////////////////////////
//*----- MODULE DELAY LINE WITH CARRY4 XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//#(parameter integer Ncarry4 = 1) add to increase lenght

module Carry4_DelayLine(

   input  wire CI,         //First MUX input
   input  wire CYINIT,      //First MUX input
   input  wire [3:0] DI,   //Data-in (MUX '0' input) 
   input  wire [3:0] S,    //Selection bus

   output wire [3:0]CO,    //
   output wire [3:0]O      //

   );
  
   //CARRY4: Fast Carry Logic Component
   // 7 Series
   // Xilinx HDL Libraries Guide, version 2012.2
   CARRY4 CARRY4_inst (
   
      .CO(CO),          // 4-bit carry out
      .O(O),            // 4-bit carry chain XOR data out
      .CI(CI),          // 1-bit carry cascade input
      .CYINIT(CYINIT),  // 1-bit carry initialization
      .DI(DI),          // 4-bit carry-MUX data in
      .S(S)             // 4-bit carry-MUX select input
	  
   );
   // End of CARRY4_inst instantiation   
   
   
endmodule