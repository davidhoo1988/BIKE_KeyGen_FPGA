// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Wed Feb 20 10:57:45 2019
// Host        : David-NTU-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ multiplier_sim_netlist.v
// Design      : multiplier
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xa7a15tcpg236-1I
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multiplier,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [63:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [81:0]P;

  wire [63:0]A;
  wire CLK;
  wire [81:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "64" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "110100001111111101" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "81" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "aartix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14 U0
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "64" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "110100001111111101" *) (* C_B_WIDTH = "18" *) (* C_CCM_IMP = "2" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "2" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "81" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "aartix7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [63:0]A;
  input [17:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [81:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [63:0]A;
  wire CLK;
  wire [81:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "64" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "110100001111111101" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "81" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "aartix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
TvNAk+dzefmJC5/xfGEoXo1v1zzw15yvf2w3I+7pl9weHnOYLTwk2CtA6qQwUdiv+KPlR09XyHxt
UocEiAlS9g==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ccd1Kr3IgmbU3Zd5R5UGhugxe9OUvTTk5M/+YDzRXyTvXIMaUxHB5fv7SuuebIYqGrGlL5seA2Sg
zO1i2uQFXVFn4M1DHS2E7BwirWBP5gmU/RaWKyEfTu3E5ZGbc1lvK67CCG8szRwdrvmY+Z8CpiC4
+fKoXg6GREReZgylTmE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
D4OySXRBGdK3bWTwoBJnna9JJTCfjtow8OCB97TMc0CHJtgWscKG0sA6JP+WmQu+g/St8V3dnWCm
Z/oL2u8esW79WhsyQGAkuc2zUGutMTiH5JtlsxfFXreCjsbpfiQ4cOTSVV8RKFLaZCW+eXj7qQwk
WUd+Rk2Kp6kViZmb9GfGDSBc1qKbMuYuGLGiO+UVYNdt7dkYg9aAhJYx3c/Tx4m6BAZTpzEs9xzl
Mg0Plk7PRG/v5PXojT+9MvJ80iSqd3ejpG6kEE1mYBAhD1zmHQfbte6ipINFibjTuluuS5i0pIbf
HaA/nmULSj1xFBTfeEdDhm4CrFUWEdYvrJoOhg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YmbWYAZhC3ayB3FdtHMbSkvV5OWWIi6gmohNfeiL3hZEqSlPd2B43zehv3FM2BA2v3N0HlGO0TL6
neUbRccVG37R0aVoXEjetzHP+ZMpVpr2wNRYoVv9EAzvD7YjPAyiMQMLJO1wmw/LJVkGpP4UCg4g
tgMS7M+LmVgeot1Fmcwa4mDyquYpShDC0ZhYtWL3VmO204ubc1HcI1fEQiMp+tBP7rYU0jIyGMtz
dXGUYS7PdIYkz5ApCjSfCCueqmWeZf9/KXMkoo9udSh2ZyT9uNr+GM8fH8rcz5nZjN4ShPghIUSN
XIZbR6KJ/+WqugC6B6ULpEZUxft3AS1vxij4dA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pRgO0aX5waanQk0eZ4W7Q+LVxiXC+tf9hFRN9nsdM6xbA9apyUI0wd0pRjkzt/X5yvazLViQDSfS
Bm9cP+mYh23I891gOC2bMeto93RQUYlDhWmKA2HAuokJj6wKo/vk9LA0e/rAjHMWD7cTXHkdXPdz
d92x8sSRX6Z5gz0YOJ8hU+X3aLkMrr/d+Rs3UcELF+MTGSf53SzTuIbnaw08EsHUObyFusQxXlt6
ZuByaRiPP1ofEvMk+UCLRZThOA7sR6SIfjXOTF55TQgss4/Mf30sm+t84LW+xNBWIqVfiQ671PZF
CQ8K4qBj3nTT9D0FTUvfHdTmLtywWgV65+5W3A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
d38DScsESf/yIfST5KEEwSUvjI+Km/dbua2xenGdzq3rgc/diAWKNIN11lcJIPDVBe6fB9J2TqbT
eXC+WnYP2YB9QXYlwKxLW7HOYcLC6Ivx9uoTg503B1azg5yB52W8iAwxelCieuRZ3qo4CxwOJ4w3
kwV+F675PsE0hWvEwTA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Bf4H+OH1vHHXYQ0B+xvr52Pkbk3t9R17gzpbDdSPXjerF+p1mOwTJrxL3jQRkm9rUtVIgJGiq2/s
crniU3gwf/UiAzOrNxcIp9eKlLwDNsxSMYn+mkUQWlDdifqNNVK+YFJD0ZFE6pzyWAfSd99uwvf2
B/+VXkZFAWz3devN4zOqXGE5+OZKTJNNH2fm+gcI0n7V4lPByrga5xMdlx99MQZZRprmMts+yOHQ
eVL2q0jneXaC7j4j8aSjRtpPAjf6aWk9xkdj2iVGAqs6TlpdNPyA9bKumNf3XCjAnjbNwxHWWAao
tHbBrxiXF1qQUoAzJ9mjy31tCjRX+JQOzKafLw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MXNvo2b8w2HvphJPVjQrrsR3KCm8Jv691dMIcLVG5cI8iK7W65j0l2CUVlP/wpggC2ybbLdHabiZ
suzyN6HgLichtTDM8zqERHpSj90CtY7RZHiYhDkF9mbC8dJArcnZsm9o47ZiZkZ5vSQtS2KhIuUk
LZN+g4nWqLEXX5qkPtzexqUzEDPJGUWwS3OIJ8mVUjpBNG49+AFULDBmLHQAx/JwnCNrLQjEb4Z+
h9anEEaStYY1twLq+VV7MAxLZYFSCGM5QjS6kGB+0f5Bk3VjJUWf9LbUuAcuw8OnDeIRfqOrGmDS
Jba5Kq619c+v5OjvPYqrCIIncmDNcKw6UQp3VA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
KkmNhUv4lj2ASFFQ7bIGJjOFdtz+lg7SnolatY0NsMXS1FBRMSzN/tCuWZ4BFdBFO3roggxRVyx2
cSIbWsS5MEbMCw+0BOz6Tq/7kbqffeSaGzLxQT1fQKqA6gbGUlla8+JlszaSXkzYEsbmhJiiqObS
uj7tCAFjj81M7J7MoImV7ZZUijSz71J6vD0PJbx1PpMWjrEdApP3WI6mXbUsaomENn/B4y4ER3D7
/zae+OayzOkF1cR6I5XuRIYbsObQ3HmY7+7LEn8qTq0dV6dS4BNDQU7fH2XisKn2iM4NNE0zobve
O+405XOQsn/NgTDqFlle5jK2O843hWonSPXTdw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 38688)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
