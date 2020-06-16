/////////////////////////////////////////////////////////////////
//*----- MODULE DELAY LINE WITH NCARRY4 XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//#(parameter integer Ncarry4 = 1) add to increase lenght

module Multi_Carry4_DelayLine #(parameter integer Ncarry4 = 2)(

   input  wire CI,          //First MUX input
   input  wire [Ncarry4-1:0]CYINIT,      //First MUX input
   input  wire [3+(Ncarry4-1)*4:0] DI,   //Data-in (MUX '0' input) 
   input  wire [3+(Ncarry4-1)*4:0] S,    //Selection bus
				
   output wire [3+(Ncarry4-1)*4:0]CO,    //
   output wire [3+(Ncarry4-1)*4:0]O      //

   );
   
   wire   [3+(Ncarry4-1)*4:0]w; 
   assign w[0] = CI;
   
   generate 
   
      genvar k ;
	  
	  for (k = 0; k < Ncarry4; k = k + 1) begin 
	  
         //CARRY4: Fast Carry Logic Component
         // 7 Series
         // Xilinx HDL Libraries Guide, version 2012.2
         CARRY4 CARRY4_inst (
         
            .CO( CO[4*k+3:4*k]),          // 4-bit carry out
            .O( O[4*k+3:4*k]),            // 4-bit carry chain XOR data out
            .CI(w[k]),                        // 1-bit carry cascade input
            .CYINIT(CYINIT[k]),  // 1-bit carry initialization
            .DI(DI[4*k+3:4*k]),          // 4-bit carry-MUX data in
            .S(S[4*k+3:4*k])             // 4-bit carry-MUX select input
	        
         );
         // End of CARRY4_inst instantiation

        assign w[k+1] = CO[4*k+3] ;		 
    end  // for
	
   endgenerate 
 
endmodule

//wire net;
//assign net = a ? 1'b1 : (b ? 1'b0 : 1'bx);