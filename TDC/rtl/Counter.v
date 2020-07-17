/////////////////////////////////////////////////////////////////
//*----- MODULE PIPELINE WITH FDCE XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module Counter(

   input  wire clk, //CLOCK
   input  wire start_count, 
   input  wire stop_count,
   input  wire reset,
   
   output wire [47:0] count  

   );


   wire start_long;
   wire stop_long;
  // wire invcount;
   wire en;
   wire TC;
  // assign invcount= ~count[0];   
   
  

 generate

    genvar j;

    for(j = 0; j <= 1; j = j+1) begin

       if(j==0) begin

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
                 .Q(start_long), // 1-bit output: Data
                 .C(start_count),         // 1-bit input: Clock
                 .CE(1'b1),       // 1-bit input: Clock enable
                 .CLR(reset),      // 1-bit input: Asynchronous clear
                 .D(1'b1)   // 1-bit input: Data
              );
		 end //if
		 
		 else begin
              // End of 3FDCE_inst instantiation
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
                 .Q(stop_long),   // 1-bit output: Data
                 .C(stop_count),  // 1-bit input: Clock
                 .CE(1'b1),       // 1-bit input: Clock enable
                 .CLR(reset),     // 1-bit input: Asynchronous clear
                 .D(1'b1)         // 1-bit input: Data
              );
			  
			end //else
              // End of 3FDCE_inst instantiation
        end //for
		
	endgenerate
    // LUT2: 2-input Look-Up Table with general output (Mapped to a LUT6)
              // 7 Series
              // Xilinx HDL Libraries Guide, version 2012.2
              LUT2 #(
              .INIT(4'b0010) // Specify LUT Contents
              ) LUT2_inst (
              .O(en), // LUT general output
              .I0(start_long), // LUT input
              .I1(stop_long) // LUT input
              );
              // End of LUT2_inst instantiatio
   
   
// pipeline effettiva      
//  generate 
//  
//       genvar k ;
// 	  
// 	    for (k = 0; k < NFF; k = k + 1) begin
//		
//		   if(k==0) begin
//             //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
//             // UltraScale
//             // Xilinx HDL Libraries Guide, version 2014.1
//             FDCE #(
//                .INIT(0), // Initial value of register, 1’b0, 1’b1
//                // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
//                .IS_CLR_INVERTED(1'b0),   // Optional inversion for CLR
//                .IS_C_INVERTED  (1'b0),   // Optional inversion for C
//                .IS_D_INVERTED  (1'b0)    // Optional inversion for D
//             )
//             FDCE_inst (
//                .Q(count[k]),    // 1-bit output: Data
//                .C(clk),         // 1-bit input: Clock
//                .CE(en),         // 1-bit input: Clock enable
//                .CLR(reset),     // 1-bit input: Asynchronous clear
//                .D(~count[k])    // 1-bit input: Data
//             );
//             // End of 3FDCE_inst instantiation
//	       end // if
//		
//		   else begin
//             //FDCE: D Flip-Flop with Clock Enable and Asynchronous Clear
//             // UltraScale
//             // Xilinx HDL Libraries Guide, version 2014.1
//             FDCE #(
//                .INIT(0), // Initial value of register, 1’b0, 1’b1
//                // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
//                .IS_CLR_INVERTED(1'b0),   // Optional inversion for CLR
//                .IS_C_INVERTED  (1'b0),   // Optional inversion for C
//                .IS_D_INVERTED  (1'b0)    // Optional inversion for D
//             )
//             FDCE_inst (
//                .Q(count[k]), // 1-bit output: Data
//                .C(count[k-1]),         // 1-bit input: Clock
//                .CE(en),       // 1-bit input: Clock enable
//                .CLR(reset),      // 1-bit input: Asynchronous clear
//                .D(~count[k])   // 1-bit input: Data
//             );
//             // End of 3FDCE_inst instantiation
//	       end // if
//	    end //for
//	  
//  endgenerate


//COUNTER_LOAD_MACRO: Loadable variable counter implemented in a DSP48E
// 7 Series
// Xilinx HDL Libraries Guide, version 2012.2
//   COUNTER_LOAD_MACRO #(
//      .COUNT_BY(48'h000000000001), // Count by value
//      .DEVICE("7SERIES"), // Target Device: "7SERIES"
//      .WIDTH_DATA(48) // Counter output bus width, 1-48
//    ) 
//   COUNTER_LOAD_MACRO_inst (
//      .Q(count), // Counter output, width determined by WIDTH_DATA parameter
//      .CLK(clk), // 1-bit clock input
//      .CE(en), // 1-bit clock enable input
//      .DIRECTION(1'b1), // 1-bit up/down count direction input, high is count up
//      .LOAD(1'b0), // 1-bit active high load input  
//      .LOAD_DATA(48'h000000010001), // Counter load data, width determined by WIDTH_DATA parameter
//      .RST(reset) // 1-bit active high synchronous reset
//   );
// End of COUNTER_LOAD_MACRO_inst instantiation
 
// COUNTER_TC_MACRO: Counter with terminal count implemented in a DSP48E
// 7 Series
// Xilinx HDL Libraries Guide, version 2012.2
COUNTER_TC_MACRO #(
   .COUNT_BY(48'h000000000001), // Count by value
   .DEVICE("7SERIES"), // Target Device: "7SERIES"
   .DIRECTION("UP"), // Counter direction, "UP" or "DOWN"
   .RESET_UPON_TC("FALSE"), // Reset counter upon terminal count, "TRUE" or "FALSE"
   .TC_VALUE(48'h000000000000), // Terminal count value
   .WIDTH_DATA(48) // Counter output bus width, 1-48
   ) 
COUNTER_TC_MACRO_inst (
   .Q(count), // Counter output bus, width determined by WIDTH_DATA parameter
   .TC(TC), // 1-bit terminal count output, high = terminal count is reached
   .CLK(clk), // 1-bit positive edge clock input
   .CE(en), // 1-bit active high clock enable input
   .RST(reset) // 1-bit active high synchronous reset
   );
// End of COUNTER_TC_MACRO_inst instantiation 
endmodule