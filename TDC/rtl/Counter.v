/////////////////////////////////////////////////////////////////
//*----- MODULE PIPELINE WITH FDCE XILINX PRIMITIVES -----*//
/////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module Counter #(parameter integer NFF = 4)(

   input  wire clk, //CLOCK
   input  wire start_count, 
   input  wire stop_count,
   input  wire reset,
   
   output wire [NFF-1:0] count  

   );
// logica FSM
   wire start_long;
   wire stop_long;
  // wire invcount;
   wire en;
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
                 .Q(stop_long), // 1-bit output: Data
                 .C(stop_count),         // 1-bit input: Clock
                 .CE(1'b1),       // 1-bit input: Clock enable
                 .CLR(reset),      // 1-bit input: Asynchronous clear
                 .D(1'b1)   // 1-bit input: Data
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
              // End of LUT2_inst instantiation
   
   
   
   
   
// pipeline effettiva      
   generate 
   
        genvar k ;
  	  
  	    for (k = 0; k < NFF; k = k + 1) begin
		
		   if(k==0) begin
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
                 .Q(count[k]),    // 1-bit output: Data
                 .C(clk),         // 1-bit input: Clock
                 .CE(en),         // 1-bit input: Clock enable
                 .CLR(reset),     // 1-bit input: Asynchronous clear
                 .D(~count[k])    // 1-bit input: Data
              );
              // End of 3FDCE_inst instantiation
	       end // if
		
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
                 .Q(count[k]), // 1-bit output: Data
                 .C(count[k-1]),         // 1-bit input: Clock
                 .CE(en),       // 1-bit input: Clock enable
                 .CLR(reset),      // 1-bit input: Asynchronous clear
                 .D(~count[k])   // 1-bit input: Data
              );
              // End of 3FDCE_inst instantiation
	       end // if
	    end //for
	  
   endgenerate
    
endmodule