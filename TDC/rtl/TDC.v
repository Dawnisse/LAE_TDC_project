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
//-- Description:    TOP LEVEL MODULE
//--
//--
//-- Inputs:
//--
//-- Outputs:
//--
//---------------------------------------------------------------------------------//


`timescale 1ns / 100ps

module TDC(

   input  wire clk,
   input  wire hit,
   
   output wire  [7:0]bin_out_start,
   output wire  [7:0]bin_out_stop,
   output wire [47:0]out_count

);

   (*keep = "true"*)wire filtered_start;
   (*keep = "true"*)wire filtered_stop;
   (*keep = "true"*)wire [199:0]thermo_start_raw;
   (*keep = "true"*)wire [199:0]thermo_start_piped;
   (*keep = "true"*)wire [199:0]thermo_stop_raw;
   (*keep = "true"*)wire [199:0]thermo_stop_piped;
   (*keep = "true"*)wire [194:0]one_hot_start;
   (*keep = "true"*)wire [194:0]one_hot_stop;
//   (*keep = "true"*)wire [199:0]O;
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
	  .CO(thermo_start_raw)
//	  .O(O)
   );

end

endgenerate

//generate begin :StartDelayLine  //DelayLine implemented with MUXs
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

//In two step : thermo -> one hot , one hot -> bin AVOIDING BUBBLES
generate begin :Start_thermo2onehot

    Thermo2OneHot Start_thermo2onehot(
	
	   .thermo(thermo_start_piped),
	   .one_hot(one_hot_start)
	
	);

end
endgenerate

generate begin :Start_onehot2bin

   OneHot2Bin Start_onehot2bin(
   
      .one_hot(one_hot_start),
	  .index(bin_out_start)
   
   );

end
endgenerate

//in one step
//generate begin :STARTthermo2bin
//   
//   ThermometerEncoder2 STARTthermo2bin(
//   
//      .thermob(thermo_start_piped),
//	  .bin(bin_out_start)
//   
//   );
//
//end //begin thermo2bin
//
//endgenerate

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
	  .CO(thermo_stop_raw)
//	  .O(O)
   );

end

endgenerate
 
//generate begin :StopDelayLine //DelayLine implemented with MUXs
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

//In two step : thermo -> one hot , one hot -> bin AVOIDING BUBBLES
generate begin :Stop_thermo2onehot

    Thermo2OneHot Stop_thermo2onehot(
	
	   .thermo(thermo_stop_piped),
	   .one_hot(one_hot_stop)
	
	);

end
endgenerate

generate begin :Stop_onehot2bin

   OneHot2Bin Stop_onehot2bin(
   
      .one_hot(one_hot_stop),
	  .index(bin_out_stop)
   
   );

end
endgenerate

// In one step
//generate begin :STOPthermo2bin
//   
//
//   ThermometerEncoder2 STOPthermo2bin(
//   
//      .thermob(thermo_stop_piped),
//	  .bin(bin_out_stop)
//   
//   );
//end //begin STOPthermo2bin
//
//endgenerate

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