// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_14,Vivado 2018.1" *)
module mul_64bit(CLK, A, P);
  input CLK;
  input [63:0]A;
  output [126:0]P;
endmodule
