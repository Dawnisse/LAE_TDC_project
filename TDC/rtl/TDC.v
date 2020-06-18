//
//
//

`timescale 1ns / 100ps

module TDC(

   input  wire clk,
   input  wire hit,
   
   output wire [1:0]bin_out,
   output wire [3:0]out_count

);

   wire filtered_hit;
   wire [3:0]thermo;
   wire start_count;
   wire stop_count;
   

//INPUT FILTER

generate 
   
   InputFilter (
      
	  .clk(clk),
	  .hit(hit),
	  .filtered_hit(filtered_hit),
	  .valid(start_count)
   
   );
      
   endgenerate  
   
//DELAY LINE

generate 

   DelayLine (
   
      .filtered_hit(filtered_hit),
	  .Z(thermo)
     
   );


   endgenerate
   
//COUNTER

generate

   Counter (
   
      .start_count(start_count),
	  .stop_count(stop_count),
	  .clk(clk),
	  .out_count(out_count)
   
   );
   endgenerate
   
//Thermometer encoder

generate

   ThermometerEncoder (
   
      .thermo(thermo),
	  .bin(bin_out)
   
   );
   endgenerate


 

endmodule