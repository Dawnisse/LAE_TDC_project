

`timescale 1ns / 100ps

module ThermometerEncoder2 (

   input  wire [31:0]  thermo,    // 32-bit thermometer output code
   output reg  [4:0]   bin        //  5-bit base-2 binary input code

   ) ;

always @(*) begin   
    case(thermo)
	  
	  {32'b0       } : bin = 0;
	  {31'b0,  1'b1} : bin = 1;
	  {30'b0,  2'b1} : bin = 2;  
      {29'b0,  3'b1} : bin = 3;
      {28'b0,  4'b1} : bin = 4;
      {27'b0,  5'b1} : bin = 5;
      {26'b0,  6'b1} : bin = 6;
      {25'b0,  7'b1} : bin = 7;
      {24'b0,  8'b1} : bin = 8;
	  {23'b0,  9'b1} : bin = 9;
	  {22'b0, 10'b1} : bin = 10;
	  {21'b0, 11'b1} : bin = 11;
	  {20'b0, 12'b1} : bin = 12;
	  {19'b0, 13'b1} : bin = 13;
	  {18'b0, 14'b1} : bin = 14;
	  {17'b0, 15'b1} : bin = 15;
	  {16'b0, 16'b1} : bin = 16;
	  {15'b0, 17'b1} : bin = 17;
	  {14'b0, 18'b1} : bin = 18;
	  {13'b0, 19'b1} : bin = 19;
	  {12'b0, 20'b1} : bin = 20;
      {11'b0, 21'b1} : bin = 21;
	  {10'b0, 22'b1} : bin = 22;
	  {9'b0,  23'b1} : bin = 23;
	  {8'b0,  24'b1} : bin = 24;
	  {7'b0,  25'b1} : bin = 25;
	  {6'b0,  26'b1} : bin = 26;
	  {5'b0,  27'b1} : bin = 27;
	  {4'b0,  28'b1} : bin = 28;
	  {3'b0,  29'b1} : bin = 29;
	  {2'b0,  30'b1} : bin = 30;
	  {1'b0,  31'b1} : bin = 31;
	  {       32'b1} : bin = 32;

    endcase
end //always

endmodule
  