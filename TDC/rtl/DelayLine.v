//////////////////////////////////////////////
// --- MODULE : Delay Line for FPGA TDC --- //
//////////////////////////////////////////////

`timescale 1ns/100ps


module DelayLine(
   
   input  wire HIT,           // hit signal
   input  wire CLK,           // clock signal
   
   output reg CountOn,         // counter
   output reg [3:0] Z = 4'd0   // output vector 
  
   );
    
   
   reg EN = 1'b0 ;  // enable initialization
   
   
   always @(posedge HIT) begin      // sensitivity list (aggiorna quando cambia un input)
      
	  EN      = 1'b1;
	  CountOn = 1'b0;
		 
      if (EN == 1'b1) begin      // AGGIUSTARE STA ROBA BRUTTA
		
		 Z[0] <= 1'b1 ;
		
		 if (Z[0])
		 Z[1] <= Z[0] ;
		 
		 if (Z[1])
		 Z[2] <= Z[1] ;
		 
		 if (Z[2])
		 Z[3] <= Z[2] ;
		
		 @(posedge CLK) EN = 1'b0 ;
	
      end    //if
			
      else
	     CountOn = 1'b1;
    
	end      //always
      

endmodule