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
   wire [31:0]thermo_start_raw;
   wire [31:0]thermo_start_piped;
   wire [31:0]thermo_stop_raw;
   wire [31:0]thermo_stop_piped;
   wire [31:0]O;
   wire start_count;
   wire stop_count;
   wire finish;
   

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
	  .CO(thermo_start_raw),
	  .O(O)
   );

end

endgenerate

//generate begin :StartDelayLine
//   
//   DelayLine StartDelayLine (
//   
//    .delay_line_in(filtered_start),
//	  .delay_line_out(thermo_start_raw)
//     
//   );
//   end //begin StartDelayLine
//   
//endgenerate 

//START PIPELINE

generate begin :Start_pipeline

   Pipeline Start_pipeline(
   
      .clk(clk),
	  .pipe_in(thermo_start_raw)
	  .pipe_out(thermo_start_piped)
   
   )
end

endgenerate

// START THERMOMETER ENCODER

generate begin :STARTthermo2bin
   
   ThermometerEncoder2 STARTthermo2bin(
   
      .thermob(thermo_start_piped),
	  .bin(bin_out_start)
   
   );

end //begin thermo2bin

endgenerate

//STOP FILTER

generate begin :stopfil
 
 StopFilter stopfil(
      
	  .clk(clk),
	  .hit(hit),
	  .filtered_hit(filtered_stop),
	  .valid(stop_count),
	  .finish(finish)
   
   );
 end // begin stopfil   

endgenerate 
 
// STOP DELAY LINE 
 
generate begin :StopDelayLine
   
   DelayLine StopDelayLine (
   
      .delay_line_in(filtered_stop),
	  .delay_line_out(thermo_stop_raw)
     
   );
   
   end //begin StopDelayLine
   
endgenerate

// STOP PIPELINE

generate begin :Stop_pipeline

   Pipeline Stop_pipeline(
   
      .clk(clk),
	  .pipe_in(thermo_stop_raw)
	  .pipe_out(thermo_stop_piped)
   
   )
   
end

endgenerate
   
//STOP THERMOMETER ENCODER

generate begin :STOPthermo2bin
   

   ThermometerEncoder2 STOPthermo2bin(
   
      .thermob(thermo_stop_piped),
	  .bin(bin_out_stop)
   
   );
end //begin STOPthermo2bin

endgenerate

//COUNTER

generate begin: Contatore

   Counter Contatore (
   
      .start_count(start_count),
	  .stop_count(stop_count),
	  .clk(clk),
	  .reset(finish),
	  .count(out_count)
   
   );

end //begin

endgenerate


endmodule