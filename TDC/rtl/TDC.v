///////////////////////////////////////////////////
//* ---- Behavioural implementation of TDC ----* //
///////////////////////////////////////////////////


`timescale 1ns / 100ps

module TDC(

   input  wire clk,
   input  wire hit,
   
   output wire [4:0]bin_out_start,
   output wire [4:0]bin_out_stop,
   output wire [3:0]out_count

);

   wire filtered_start;
   wire filtered_stop;
   wire [31:0]thermo_start;
   wire [31:0]thermo_stop;
   wire [31:0]O;
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

generate begin :Start_carry4_DelayLine

   Multi_Carry4_DelayLine Start_carry4_DelayLine(
   
      .CI(1'b0),
	  .trigger(filtered_start),
	  .CO(thermo_start),
	  .O(O)
   );

end

endgenerate

//generate begin :StartDelayLine
//   
//   DelayLine StartDelayLine (
//   
//      .filtered_hit(filtered_start),
//	  .Z(thermo_start)
//     
//   );
//   end //begin StartDelayLine
//   
//endgenerate 
 
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
   

   ThermometerEncoder2 STARTthermo2bin(
   
      .thermob(thermo_start),
	  .bin(bin_out_start)
   
   );

end //begin thermo2bin
endgenerate

generate begin :STOPthermo2bin
   

   ThermometerEncoder2 STOPthermo2bin(
   
      .thermob(thermo_stop),
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