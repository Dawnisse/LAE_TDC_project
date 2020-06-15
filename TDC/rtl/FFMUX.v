
/* ----- LAB 3 : MULTIPLEXER with DFF -----*/

`timescale 1ns / 100ps

module FFMUX (

   input wire A,     //MUX input
   input wire B,     //MUX input
   input wire clk,
   input wire clr,   //clear signal
   
   output reg Z,   
   output reg Q      //FF output

) ;
   
   always @(A, B, clr) begin        //@(sensivity list)
        if (clr == 1'b0)	
           Z <= A;
        else 
           Z <= B ;  
	 
     end

   always @(posedge clk ) begin // Asynchronous active-high reset
   
	     Q <= Z ;		 //non-blocking assignement
	  
	  end
	 
	  
 


/*
   always @(*) begin   // always@(*) -> combinational
      
	  case ( {S, A, B} )
	  
	     3'b000 : Z = 1'b0 ; //A   //3'd0
		 3'b001 : Z = 1'b0 ; //A   //3'd1
	     3'b010 : Z = 1'b1 ; //A
		 3'b011 : Z = 1'b1 ; //A
		 3'b100 : Z = 1'b0 ; //B
		 3'b101 : Z = 1'b1 ; //B
		 3'b110 : Z = 1'b0 ; //B
		 3'b111 : Z = 1'b1 ; //B
	  
	  
	  endcase
   
   
   end // always
*/   

   /////////////////////////////////
   //// conditional assignement ////
   /////////////////////////////////

   //assign Z = ( S == 1'b0 ) ? A : B ; // C-style conditional assignment   
   
   /////////////////////////////////
   //// boolean function        ////
   /////////////////////////////////

   //assign Z = (A & ~S) | (B & S) ;

   /////////////////////////////////
   //// gate-level schematic    ////
   /////////////////////////////////  

   //wire Sbar, w1, w2 ;
   //
   //not g1 (Sbar, S) ;
   //
   //and g2 (w1, A, Sbar) ;
   //and g3 (w2, B, S) ;
   //
   //or g4 (Z, w1, w2) ;
   
   
endmodule