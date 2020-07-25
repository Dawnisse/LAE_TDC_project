/////////////////////////////////////////////////////////////////////////////////////
//-------------IMPLEMENTATION OF TDC ON ARTY7 A7:ARTIX7 FPGA-----------------------//
/////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------//
//-- Authors:        Chiara Alice and Giacomo Alloatti
//-- Institute:      Università degli studi di Torino
//-- Course:         Laurea Magistrale in fisica delle tecnologie avanzate
//--                 LABORATORIO AVANZATO DI ELETTRONICA
//-- Create Date:    07/2020 
//-- Module Name:    tdc - Structural 
//-- Project Name:   tdc - Time to Digital Converter
//-- Target Devices: ARTY7 - XC5VLX30
//--
//-- Description:    PIPELINE WITH FDCE XILINX'S ISTANCES
//--
//--
//-- Inputs:
//--
//-- Outputs:
//--
//---------------------------------------------------------------------------------//

`timescale 1ns / 100ps
//prima era 180
module StopPipeline #(parameter integer NFF=176 )(

   input  wire clk, //CLOCK
   input  wire [NFF+163:0]pipe_in,  
   
   output wire [NFF-1:0]pipe_out 

   );
      
   generate 
   
        genvar k ;
  	  
  	    for (k = 0; k < NFF; k = k + 1) begin
		
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
           .Q(pipe_out[k]), // 1-bit output: Data
           .C(clk),         // 1-bit input: Clock
           .CE(1'b1),       // 1-bit input: Clock enable
           .CLR(1'b0),      // 1-bit input: Asynchronous clear
           .D(pipe_in[k+164])   // 1-bit input: Data
      );
      // End of 3FDCE_inst instantiation
	  
	  end //for
	  
   endgenerate
    
endmodule