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

`timescale 1ns / 100ps

module tb_TDC ;

   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk200 ;

   ClockGen   ClockGen_inst (.clk(clk100)) ;

   //PLL IP CORE FOR CLOCK
   
//   wire clk100;
//   wire clk200; 
//   wire locked;
//   
//   PLL   PLL_inst( 
//   
//    .CLK100(clk100), 
//	  .CLK200(clk200), 
//	  .LOCKED(locked)
//	  
//	  ) ;

   
   //Device Under Test : DUT
   
   reg hit;
   wire [4:0]bin_out_start;
   wire [4:0]bin_out_stop;
   wire [47:0]out_count;
   
   
   TDC DUT(
   
      .clk(clk200),
	  .hit(hit),
	  .bin_out_start(bin_out_start),
	  .bin_out_stop(bin_out_stop),
	  .out_count(out_count)
    
   );
   
   //stimulus
   
   initial begin
   
     #0   hit = 1'b0;
//	 @(posedge locked)  // wait for the PLL to lock
	 #122 hit = 1'b1;
	 #159 hit = 1'b0;
	 #230 hit = 1'b1;
	 #253 hit = 1'b0;
	 
	 #300 $finish ;  
   
   end //stimulus
   
endmodule