///////////////////////////////////////////////////
//* ---- Behavioural implementation of TDC ----* //
///////////////////////////////////////////////////


`timescale 1ns / 100ps

module TDC(

   input  wire clk,
   input  wire hit,
   
   output wire [4:0]bin_out_start,
   output wire [4:0]bin_out_stop,
   output wire [47:0]out_count

);

   (*keep = "true"*)wire filtered_start;
   (*keep = "true"*)wire filtered_stop;
   (*keep = "true"*)wire [31:0]thermo_start_raw;
   (*keep = "true"*)wire [31:0]thermo_start_piped;
   (*keep = "true"*)wire [31:0]thermo_stop_raw;
   (*keep = "true"*)wire [31:0]thermo_stop_piped;
   (*keep = "true"*)wire [31:0]O;
   (*keep = "true"*)wire start_count;
   (*keep = "true"*)wire stop_count;
   (*keep = "true"*)wire finish;
   

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
	  .pipe_in(thermo_start_raw),
	  .pipe_out(thermo_start_piped)
   
   );
end

endgenerate

// START THERMOMETER ENCODER

generate begin :STARTthermo2bin
   
   ThermometerEncoder2 STARTthermo2bin(
   
      .thermo(thermo_start_piped),
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

generate begin :Stop_carry4_DelayLine

   Multi_Carry4_DelayLine Stop_carry4_DelayLine(
   
      .CI(1'b0),
	  .trigger(filtered_stop),
	  .CO(thermo_stop_raw),
	  .O(O)
   );

end

endgenerate
 
//generate begin :StopDelayLine
//   
//   DelayLine StopDelayLine (
//   
//      .delay_line_in(filtered_stop),
//	  .delay_line_out(thermo_stop_raw)
//     
//   );
//   
//   end //begin StopDelayLine
//   
//endgenerate

// STOP PIPELINE

generate begin :Stop_pipeline

   Pipeline Stop_pipeline(
   
      .clk(clk),
	  .pipe_in(thermo_stop_raw),
	  .pipe_out(thermo_stop_piped)
   
   );
   
end

endgenerate
   
//STOP THERMOMETER ENCODER

generate begin :STOPthermo2bin
   

   ThermometerEncoder2 STOPthermo2bin(
   
      .thermo(thermo_stop_piped),
	  .bin(bin_out_stop)
   
   );
end //begin STOPthermo2bin

endgenerate

//COUNTER

generate begin :counter

   Counter counter(
   
      .start_count(start_count),
	  .stop_count(stop_count),
	  .clk(clk),
	  .reset(finish),
	  .count(out_count)
   
   );

end //begin counter

endgenerate


endmodule