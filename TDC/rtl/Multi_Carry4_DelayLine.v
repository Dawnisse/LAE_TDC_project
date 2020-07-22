/////////////////////////////////////////////////////////////////
//*----- MODULE DELAY LINE WITH NCARRY4 XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps


module Multi_Carry4_DelayLine #(parameter integer Ncarry4 = 50)(

   input  wire CI,                       //First MUX input
   input  wire trigger,                  //First CYINIT
				
   (*keep = "true"*)output wire [3+(Ncarry4-1)*4:0]CO
//   (*keep = "true"*)output wire [3+(Ncarry4-1)*4:0]O   

   );

   wire [3+(Ncarry4-1)*4:0]O;   
  
   generate 
   
      genvar k ;
	  
	  for (k = 0; k < Ncarry4; k = k + 1) begin 
	     if (k==0) begin
		 
         //CARRY4: Fast Carry Logic Component
         // 7 Series
         // Xilinx HDL Libraries Guide, version 2012.2
            CARRY4 CARRY4_inst (
            
               .CO    (CO[4*k+3:4*k]),         // 4-bit carry out
               .O     ( O[4*k+3:4*k]),         // 4-bit carry chain XOR data out
               .CI    (         1'b0),         // 1-bit carry cascade input
               .CYINIT(      trigger),         // 1-bit carry initialization
               .DI    (      4'b0000),         // 4-bit carry-MUX data in
               .S     (      4'b1111)          // 4-bit carry-MUX select input
	           
            );
			
	     end //if
		 else begin
		 
		    CARRY4 CARRY4_inst (
            
               .CO    (CO[4*k+3:4*k]),       // 4-bit carry out
               .O     ( O[4*k+3:4*k]),       // 4-bit carry chain XOR data out
               .CI    (CO[3+4*(k-1)]),       // 1-bit carry cascade input
               .CYINIT(         1'b0),       // 1-bit carry initialization
               .DI    (      4'b0000),       // 4-bit carry-MUX data in
               .S     (      4'b1111)        // 4-bit carry-MUX select input
	           
            );
	     end //else
		 
         // End of CARRY4_inst instantiation
	 
    end  // for
	
   endgenerate 
 
endmodule

