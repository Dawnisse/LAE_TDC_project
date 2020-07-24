/////////////////////////////////////////////////////////////////
//*----- MODULE DELAY LINE WITH CARRY4 XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module InputFilter (

   input  wire clk, //CLOCK
   input  wire hit, 
   
   output wire filtered_hit,
   output wire valid


   );
 
   wire w;  //to connect 1 e 2 ff
   wire y;
      
   generate 
   
        genvar k ;
  	  
  	    for (k = 0; k < 3; k = k + 1) begin
		
		   if (k == 0) begin
              //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
              // UltraScale
              // Xilinx HDL Libraries Guide, version 2014.1
              FDCE #(
                 .INIT(0), // Initial value of register, 1’b0, 1’b1
                 // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
                 .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
                 .IS_C_INVERTED  (1'b0),   // Optional inversion for C
                 .IS_D_INVERTED  (1'b0)    // Optional inversion for D
              )
              FDCE_inst (
                 .Q(w), // 1-bit output: Data
                 .C(hit), // 1-bit input: Clock
                 .CE(1'b1), // 1-bit input: Clock enable
                 .CLR(w), // 1-bit input: Asynchronous clear
                 .D(1'b1) // 1-bit input: Data
              );		  
      // End of 1FDCE_inst instantiation
	  end //if
	  	  
	  		  else if (k == 1) begin
        //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
        // UltraScale
        // Xilinx HDL Libraries Guide, version 2014.1
        FDCE #(
           .INIT(0), // Initial value of register, 1’b0, 1’b1
           // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
           .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
           .IS_C_INVERTED  (1'b0),   // Optional inversion for C
           .IS_D_INVERTED  (1'b0)    // Optional inversion for D
        )
        FDCE_inst (
           .Q(y), // 1-bit output: Data
           .C(clk), // 1-bit input: Clock
           .CE(1'b1), // 1-bit input: Clock enable
           .CLR(w), // 1-bit input: Asynchronous clear
           .D(1'b1) // 1-bit input: Data
      );
      // End of 2FDCE_inst instantiation
	  end //if
	 	  
	  		else begin
        //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
        // UltraScale
        // Xilinx HDL Libraries Guide, version 2014.1
        FDCE #(
           .INIT(0), // Initial value of register, 1’b0, 1’b1
           // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
           .IS_CLR_INVERTED(1'b0),   // Optional inversion for CLR
           .IS_C_INVERTED  (1'b0),   // Optional inversion for C
           .IS_D_INVERTED  (1'b0)    // Optional inversion for D
        )
        FDCE_inst (
           .Q(valid),      // 1-bit output: Data
           .C(clk),    // 1-bit input: Clock
           .CE(1'b1),  // 1-bit input: Clock enable
           .CLR(1'b0), // 1-bit input: Asynchronous clear
           .D(~y)      // 1-bit input: Data
      );
      // End of 3FDCE_inst instantiation
	  end //if	  
	 end //for
	  
   endgenerate
   
   assign filtered_hit = ~y;

 
 //DESIGN NUOVO, VEDIAMO SE FUNGE
 
// generate 
//   
//        genvar k ;
//  	  
//  	    for (k = 0; k < 2; k = k + 1) begin
//		
//		   if (k == 0) begin
//              //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
//              // UltraScale
//              // Xilinx HDL Libraries Guide, version 2014.1
//              FDCE #(
//                 .INIT(0), // Initial value of register, 1’b0, 1’b1
//                 // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
//                 .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
//                 .IS_C_INVERTED  (1'b0),   // Optional inversion for C
//                 .IS_D_INVERTED  (1'b0)    // Optional inversion for D
//              )
//              FDCE_inst (
//                 .Q(filtered_hit), // 1-bit output: Data
//                 .C(hit), // 1-bit input: Clock
//                 .CE(1'b1), // 1-bit input: Clock enable
//                 .CLR(clk), // 1-bit input: Asynchronous clear
//                 .D(1'b1) // 1-bit input: Data
//              );
//			  
//			  
//      // End of 1FDCE_inst instantiation
//	  end //if
//	  
//	  
//	  else  begin
//        //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
//        // UltraScale
//        // Xilinx HDL Libraries Guide, version 2014.1
//        FDCE #(
//           .INIT(0), // Initial value of register, 1’b0, 1’b1
//           // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
//           .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
//           .IS_C_INVERTED  (1'b0),   // Optional inversion for C
//           .IS_D_INVERTED  (1'b0)    // Optional inversion for D
//        )
//        FDCE_inst (
//           .Q(valid), // 1-bit output: Data
//           .C(clk), // 1-bit input: Clock
//           .CE(1'b1), // 1-bit input: Clock enable
//           .CLR(1'b0), // 1-bit input: Asynchronous clear
//           .D(filtered_hit) // 1-bit input: Data
//      );
//      // End of 2FDCE_inst instantiation
//	  end //else
//	  
//	  end //for
//endgenerate
 
endmodule