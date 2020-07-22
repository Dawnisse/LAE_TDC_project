// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Jul 21 18:45:14 2020
// Host        : DESKTOP-4AILNFN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub C:/Users/Chiara/Desktop/LAE_TDC_project/TDC/cores/PLL/PLL_stub.v
// Design      : PLL
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module PLL(CLK200, LOCKED, CLK100)
/* synthesis syn_black_box black_box_pad_pin="CLK200,LOCKED,CLK100" */;
  output CLK200;
  output LOCKED;
  input CLK100;
endmodule
