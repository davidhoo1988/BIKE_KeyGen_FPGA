// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Wed Feb 20 10:52:17 2019
// Host        : David-NTU-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xa7a15tcpg236-1I
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [49:0]P;

  wire [31:0]A;
  wire CLK;
  wire [49:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "110100001111111101" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "49" *) 
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

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "110100001111111101" *) (* C_B_WIDTH = "18" *) (* C_CCM_IMP = "2" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "1" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "2" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "49" *) 
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
  input [17:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [49:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire CLK;
  wire [49:0]P;
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
  (* C_B_VALUE = "110100001111111101" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "49" *) 
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
Co0dUZXTgFO58k1EUlISe9c7xZDcE5UUdaOovBihAT+p9zvydQLP35GN1a0MmTx53D8WljQNbpvB
7ZnavoRphPpGzYD41H7EVAxOETXR3DF1R1zfUktmgY6s4/k7UHapCgNjLW2O+x2wbRbOeeY3x49+
1fji85NTBnjNEaV5IebWyf7pNKmR32fmJghWHNdKNDYRuDfQ7OLOCKeVIhe4YK0gbGR//jnsesQl
w/zv/SHIeMbjaHRDLo7Cx8EjHy54Mc343u7cubjZSG79NOaVJ0Pvh5DdAXBeOtHRPaeRT4mTvG/M
tmEIEQlzSY+ae/PfcTTo6ejjoCwQ6WyPyHq3oQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o7qSOtDuOiQH49ULDA4OHIU2lVNhD5r7NJ9ctK+CDadxv3C+9Cm1PID2qN8HJIbjiGqivIaq+ZuK
tty3UsSiVQdyb4uEB9hQS4Ar7jLOYJySqSacuW8k5EDGs326VevC+SfjOVcKrqyCCbHKkpN2Zm/D
nrFaqCI8CHyWIWJxXk6a6531gznIdwxFpTHmFzwEO1+YKCwu2z5hoEeIIqvt610JP3USnhirxx/F
Aukise+A5agSVfRwazW8Lr54jvtLV8qIX+udTTYf2Gr+6BQrOccIz9Qgr+xJDdZn6wCpkSALR85U
tJShFXXaWiHUAvZvbWVn+2gEsORjzbuDGV7D3A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 23232)
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
