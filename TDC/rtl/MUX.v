
/* ----- MULTIPLEXER 2:1 -----*/

`timescale 1ns / 100ps

module MUX (

   input  wire A, 
   input  wire B, 
   input  wire S, 
   
   output wire Z

) ;

   /////////////////////////////////
   //// boolean function        ////
   /////////////////////////////////

   assign #(10) Z = (A & S) | (B & ~S) ;


endmodule