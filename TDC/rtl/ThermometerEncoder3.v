//
//thermometric encothermoer gate level thermoescription
//


module ThermometerEncoder3( 

   output wire [2:0] bin,
   input  wire [7:0] thermo 
   
   );

  wire s0, s1, s2, s3, s4, s5, s6, s7;
  wire bin2_temp;
  
  assign s0 = ~ thermo[7];
  assign s1 = ~ thermo[6];
  assign s3 = (thermo[6] | thermo[5] | thermo[4]);
  assign s2 = ~ (s1 & thermo[5]);
  assign s4 = (s3 | thermo[2] | ~ thermo[1]);
  assign s5 = ~ s3;
  assign bin2_temp = ~ (s0 & s1 & s2 & ~ thermo[4]);
  assign s6 = ~ (s5 & thermo[2]);
  assign s7 = ~ (s5 & thermo[3]);
  assign bin[1] = ~ (s0 & s1 & s6 & s7);
  assign bin[0] = ~ (s0 & s2 & s4 & s7);
 
  assign bin[2] = bin2_temp;
  
endmodule