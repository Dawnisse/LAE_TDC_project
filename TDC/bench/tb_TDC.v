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
//-- Description:    TEST BENCH
//--
//--
//-- Inputs:
//--
//-- Outputs:
//--
//---------------------------------------------------------------------------------//

`timescale 1ns / 1ps

module tb_TDC ;

   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen   ClockGen_inst (.clk(clk100)) ;

   //CLOCK_WIZ IP CORE FOR CLOCK
   
//   wire clk200; 
//   wire locked;
//   
//   PLL   PLL_inst( 
//   
//      .CLK100(clk100), 
//	  .CLK200(clk200), 
//	  .LOCKED(locked)
//	  
//	  ) ;

   
   //Device Under Test : DUT
   
   reg hit;
   wire [47:0]out_count;
   wire [203:0]one_hot_start;
   wire [175:0]one_hot_stop;
   
   TDC DUT(
   
      .clk(clk100),  //change to clk200 when PLL
	  .hit(hit),
	  .one_hot_start(one_hot_start),
      .one_hot_stop(one_hot_stop),
	  .out_count(out_count)
    
   );
   
   //stimulus
   
   initial begin
   
     #0   hit = 1'b0;
//	 @(posedge locked)  // wait for the PLL to lock
	 #136 hit = 1'b1;
	 #80 hit = 1'b0;
	 #226 hit = 1'b1;
	 #255 hit = 1'b0;
	 
	 #300 $finish ;  
   
   end //stimulus
   
endmodule