// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *)
module mem_g(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb);
  input clka;
  input ena;
  input [0:0]wea;
  input [7:0]addra;
  input [63:0]dina;
  output [63:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [7:0]addrb;
  input [63:0]dinb;
  output [63:0]doutb;
endmodule
