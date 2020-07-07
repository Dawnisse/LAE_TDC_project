

`timescale 1ns / 100ps

module ThermometerEncoder2 (

   input  wire [31:0]  thermob,    // 32-bit thermometer output code
   output reg  [4:0]   bin        //  5-bit base-2 binary input code

   ) ;
   
   integer k;
   reg [31:0] thermo;
   reg [31:0] thermob;
   
   
  always @(thermob) begin
   
      for (k = 0; k <=60; k = k+1) begin
 
	     thermo[k] <= thermob[k] || thermob[k + 1] || thermob[k + 2] ;
	  end //for
         
   thermo[30] <= thermob[30] || thermob[31] ;
   thermo[31] <= thermob[31] ;
   
   end //always
  
   always @(thermo) begin
   
      casez(thermo)
	  
	  {31'b0             } : bin =  0;
	  {31'b0,        1'b1} : bin =  1;
	  {30'b0, 1'b1,  1'bz} : bin =  2;  
      {29'b0, 1'b1,  2'bz} : bin =  3;
      {28'b0, 1'b1,  3'bz} : bin =  4;
      {27'b0, 1'b1,  4'bz} : bin =  5;
      {26'b0, 1'b1,  5'bz} : bin =  6;
      {25'b0, 1'b1,  6'bz} : bin =  7;
      {24'b0, 1'b1,  7'bz} : bin =  8;
	  {23'b0, 1'b1,  8'bz} : bin =  9;
	  {22'b0, 1'b1,  9'bz} : bin = 10;
	  {21'b0, 1'b1, 10'bz} : bin = 11;
	  {20'b0, 1'b1, 11'bz} : bin = 12;
	  {19'b0, 1'b1, 12'bz} : bin = 13;
	  {18'b0, 1'b1, 13'bz} : bin = 14;
	  {17'b0, 1'b1, 14'bz} : bin = 15;
	  {16'b0, 1'b1, 15'bz} : bin = 16;
	  {15'b0, 1'b1, 16'bz} : bin = 17;
	  {14'b0, 1'b1, 17'bz} : bin = 18;
	  {13'b0, 1'b1, 18'bz} : bin = 19;
	  {12'b0, 1'b1, 19'bz} : bin = 20;
      {11'b0, 1'b1, 20'bz} : bin = 21;
	  {10'b0, 1'b1, 21'bz} : bin = 22;
	  {9'b0, 1'b1,  22'bz} : bin = 23;
	  {8'b0, 1'b1,  23'bz} : bin = 24;
	  {7'b0, 1'b1,  24'bz} : bin = 25;
	  {6'b0, 1'b1,  25'bz} : bin = 26;
	  {5'b0, 1'b1,  26'bz} : bin = 27;
	  {4'b0, 1'b1,  27'bz} : bin = 28;
	  {3'b0, 1'b1,  28'bz} : bin = 29;
	  {2'b0, 1'b1,  29'bz} : bin = 30;
	  {1'b0, 1'b1,  30'bz} : bin = 31;
	  {1'b1,        31'bz} : bin = 32;

    endcase
	
	end //always

endmodule
  