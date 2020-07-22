-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Tue Jul 21 18:45:14 2020
-- Host        : DESKTOP-4AILNFN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub C:/Users/Chiara/Desktop/LAE_TDC_project/TDC/cores/PLL/PLL_stub.vhdl
-- Design      : PLL
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLL is
  Port ( 
    CLK200 : out STD_LOGIC;
    LOCKED : out STD_LOGIC;
    CLK100 : in STD_LOGIC
  );

end PLL;

architecture stub of PLL is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK200,LOCKED,CLK100";
begin
end;
