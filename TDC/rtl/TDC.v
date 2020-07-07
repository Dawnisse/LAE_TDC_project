///////////////////////////////////////////////////
//* ---- Behavioural implementation of TDC ----* //
///////////////////////////////////////////////////


`timescale 1ns / 100ps

module TDC(

   input  wire clk,
   input  wire hit,
   
   output wire [2:0]bin_out_start,
   output wire [2:0]bin_out_stop,
   output wire [3:0]out_count

);

   wire filtered_start;
   wire filtered_stop;
   wire [7:0]thermo_start;
   wire [7:0]thermo_stop;
   wire start_count;
   wire stop_count;
   

//INPUT FILTER
generate begin :infil
 
         InputFilter infil (
      
	        .clk(clk),
	        .hit(hit),
	        .filtered_hit(filtered_start),
	        .valid(start_count)
   
            );
    
    end //begin infil
	
endgenerate    

   
//START DELAY LINE

generate begin :StartDelayLine
   
   DelayLine StartDelayLine (
   
      .filtered_hit(filtered_start),
	  .Z(thermo_start)
     
   );
   end //begin StartDelayLine
   
endgenerate 
 
// STOP DELAY LINE  
generate begin :StopDelayLine
   
   DelayLine StopDelayLine (
   
      .filtered_hit(filtered_stop),
	  .Z(thermo_stop)
     
   );
   
 
   end //begin StopDelayLine
   
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

generate begin :STARTthermo2bin
   

   ThermometerEncoder3 STARTthermo2bin(
   
      .thermo(thermo_start),
	  .bin(bin_out_start)
   
   );

end //begin thermo2bin
endgenerate

generate begin :STOPthermo2bin
   

   ThermometerEncoder3 STOPthermo2bin(
   
      .thermo(thermo_stop),
	  .bin(bin_out_stop)
   
   );
end //begin STOPthermo2bin
endgenerate

//STOP FILTER

generate begin :stopfil
 
 StopFilter stopfil(
      
	  .clk(clk),
	  .hit(hit),
	  .filtered_hit(filtered_stop),
	  .valid(stop_count)
   
   );
 end // begin stopfil   
endgenerate 

 

endmodule