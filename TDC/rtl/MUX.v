
/* ----- MULTIPLEXER 2:1 -----*/

`timescale 1ns / 100ps

module MUX (

   input  wire A, 
   input  wire B, 
   input  wire S, 
   
   output wire Z

) ;


//primitiva xilinx

   // LUT3: 3-input Look-Up Table with general output (Mapped to a LUT6)
   // 7 Series
   // Xilinx HDL Libraries Guide, version 2012.2
   LUT3 #(
      .INIT(8'b11001010) // Specify LUT Contents
      ) 
   LUT3_inst (
      .O (Z), // LUT general output
      .I0(B), // LUT input
      .I1(A), // LUT input
      .I2(S) // LUT input
      );
   // End of LUT3_inst instantiation

   //MUXF7: CLB MUX to tie two LUT6's together with general output
   // 7 Series
   // Xilinx HDL Libraries Guide, version 2012.2
   //   MUXF7 MUXF7_inst (
   //      .O (Z),   // Output of MUX to general routing
   //      .I0(B), // Input (tie to LUT6 O6 pin)
   //      .I1(A), // Input (tie to LUT6 O6 pin)
   //      .S (S)    // Input select to MUX
   //   );
   // End of MUXF7_inst instantiation


   /////////////////////////////////
   //// boolean function        ////
   /////////////////////////////////

  // assign #(10) Z = (A & S) | (B & ~S) ;


endmodule

