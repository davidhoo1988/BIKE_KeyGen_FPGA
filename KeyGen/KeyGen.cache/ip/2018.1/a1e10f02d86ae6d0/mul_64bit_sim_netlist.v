// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Thu Feb 21 19:40:59 2019
// Host        : David-NTU-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mul_64bit_sim_netlist.v
// Design      : mul_64bit
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xa7a35tcsg324-2I
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mul_64bit,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [52:0]P;

  wire [31:0]A;
  wire CLK;
  wire [52:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "100101101011010000111" *) 
  (* C_B_WIDTH = "21" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "52" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "aartix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14 U0
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "100101101011010000111" *) (* C_B_WIDTH = "21" *) (* C_CCM_IMP = "2" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "2" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "52" *) 
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
  input [31:0]A;
  input [20:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [52:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire CLK;
  wire [52:0]P;
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
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "100101101011010000111" *) 
  (* C_B_WIDTH = "21" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "52" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "aartix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
h9pjBIjCMTzF3xYDK0Sb6KoFxNVtTGeK2iKmFRktLiyEPSP/hfEbcDZC6xSSA1p7c6ns5iQzjc7o
/bSWGcVhGwa3MvVZmsPvWS3Y0ZcS9+WXcgkQkxRUbrD/JkfXvVS5Sj0x3i4sdWgjoMruP7gW+dZB
BzTitFMO50SJKees5yWUOz7cZnnuQywwBoli5e6++KxP1PVSx/fRGlw6dSvxn1EINO9OWTJi4ZLp
r7F418MDX/W2BG3aVnuQ105g4POz41igiACly6rH2GLG4JxoukN8gFTlGUsnQVT/t6Nv7AfJcFDx
vbZTcboxfwE8ah83dW9H5PHWBvy7eaeWS3R04A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
egYqLGTvgCSJ7FLl2Mk9r0jC/m/GmzKzIKpy7nTn6o6mG5XooUMXSZRHz+kk1FaAIDaF9myhUW5e
nMUzPGFprDqH/P8KZ9jHXLSuG6ntsZMI9Asv0FZ9rpv4rBj0hrw/yRY85vn4hSJVGgYUv9W6+s5U
Taf3DP4y3fB2G5QgswT+ZPbzELoklO1tw0QUPD3ETxGzFH9rkqwjYbr8CLxUmwH7LAyY6ClDZwIR
mEH8dA21eQB7VYe3DsOs/dFHNXpvO34TI54C2JE8o9s698obRW+MqVXN7t9OTM8R06TbJevGK6BO
0YPKqVuPbp8Jw/r3jI4mD+aAl5xKvLhj9zEYlw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 23120)
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
