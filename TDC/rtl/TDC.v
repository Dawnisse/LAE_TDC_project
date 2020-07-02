///////////////////////////////////////////////////
//* ---- Behavioural implementation of TDC ----* //
///////////////////////////////////////////////////


`timescale 1ns / 100ps

module TDC(

   input  wire clk,
   input  wire hit,
   
   output wire [4:0]bin_out,
   output wire [3:0]out_count

);

   wire filtered_hit;
   wire filtered_stop;
   wire [31:0]thermo_start;
   wire [31:0]thermo_stop;
   wire start_count;
   wire stop_count;
   

//INPUT FILTER

generate
 
 InputFilter #(.NFF(3))(
      
	  .clk(clk),
	  .hit(hit),
	  .filtered_hit(filtered_hit),
	  .valid(start_count)
   
   );
    
endgenerate 
   
//DELAY LINE

generate 

   genvar k;
   
   for (k = 0; k <= 1 ; k = k + 1 ) begin
   
   if (k==0) begin 
   DelayLine #(.Nmux(32))(
   
      .filtered_hit(filtered_hit),
	  .Z(thermo_start)
     
   );
   end //if
   
   else begin
   
   DelayLine #(.Nmux(32))(
   
      .filtered_hit(filtered_stop),
	  .Z(thermo_stop)
     
   );
   
   end//else
   end //for
   
endgenerate
   
//COUNTER

//generate
//
//   Counter (
//   
//      .start_count(start_count),
//	  .stop_count(stop_count),
//	  .clk(clk),
//	  .out_count(out_count)
//   
//   );
//  endgenerate
   
//Thermometer encoder

generate

   ThermometerEncoder (
   
      .thermo(thermo),
	  .bin(bin_out)
   
   );

endgenerate

//STOP FILTER

generate
 
 StopFilter #(.NFF(3))(
      
	  .clk(clk),
	  .hit(hit),
	  .filtered_hit(filtered_stop),
	  .valid(stop_count)
   
   );
    
endgenerate 

 

endmodule