// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Sat May  4 12:59:59 2019
// Host        : David-NTU-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/David/Desktop/KeyGen-3/KeyGen.ip/mul_64bit/mul_64bit/mul_64bit_stub.v
// Design      : mul_64bit
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_14,Vivado 2018.1" *)
module mul_64bit(CLK, A, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[63:0],P[126:0]" */;
  input CLK;
  input [63:0]A;
  output [126:0]P;
endmodule
