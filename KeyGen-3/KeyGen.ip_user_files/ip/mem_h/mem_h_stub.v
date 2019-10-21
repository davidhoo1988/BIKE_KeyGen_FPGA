// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Sat May  4 12:58:40 2019
// Host        : David-NTU-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub C:/Users/David/Desktop/KeyGen-3/KeyGen.ip/mem_h/mem_h_stub.v
// Design      : mem_h
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *)
module mem_h(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[6:0],dina[13:0],douta[13:0],clkb,enb,web[0:0],addrb[6:0],dinb[13:0],doutb[13:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [6:0]addra;
  input [13:0]dina;
  output [13:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [6:0]addrb;
  input [13:0]dinb;
  output [13:0]doutb;
endmodule