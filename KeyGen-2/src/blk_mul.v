`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 19:08:06
// Design Name: 
// Module Name: blk_mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blk_mul
#(  parameter 					r = 10163,
	parameter               	G_ADDR_W = 8,
    parameter               	G_DAT_W = 64,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14)

(
	input						clk,
	input 						rst_b,

	input [G_DAT_W-1:0] 		op_a,
	input [2*G_DAT_W-2:0]		op_b,

	output reg [G_DAT_W-1:0]    mul_r
    );

wire [G_DAT_W-1:0] 	grp0_r, grp1_r, grp2_r, grp3_r, grp4_r, grp5_r, grp6_r, grp7_r,
					grp8_r, grp9_r, grp10_r, grp11_r, grp12_r, grp13_r, grp14_r, grp15_r,
					grp16_r, grp17_r, grp18_r, grp19_r, grp20_r, grp21_r, grp22_r, grp23_r,
					grp24_r, grp25_r, grp26_r, grp27_r, grp28_r, grp29_r, grp30_r, grp31_r,
					grp32_r, grp33_r, grp34_r, grp35_r, grp36_r, grp37_r, grp38_r, grp39_r,
					grp40_r, grp41_r, grp42_r, grp43_r, grp44_r, grp45_r, grp46_r, grp47_r,
					grp48_r, grp49_r, grp50_r, grp51_r, grp52_r, grp53_r, grp54_r, grp55_r,
					grp56_r, grp57_r, grp58_r, grp59_r, grp60_r, grp61_r, grp62_r, grp63_r;


//reg [G_DAT_W-1:0] tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
wire [G_DAT_W-1:0] tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;



/*always @(posedge clk) begin
	if (~rst_b) 
		op_a <= {G_DAT_W{1'b0}};
	else 
		op_a <= op_a_tmp; 	
end

always @(posedge clk) begin
	if (~rst_b) 
		op_b <= {(2*G_DAT_W-1){1'b0}};
	else 
		op_b <= op_b_tmp; 	
end*/

//first pipeline

//GROUP-0
sca_mul grp0(
	.bit_a						(op_a[G_DAT_W-1]),
	.vec_b						(op_b[G_DAT_W-1:0]),
	.mul_r 						(grp0_r)
	);

sca_mul grp1(
	.bit_a						(op_a[G_DAT_W-2]),
	.vec_b						(op_b[G_DAT_W:1]),
	.mul_r 						(grp1_r)
	);

sca_mul grp2(
	.bit_a						(op_a[G_DAT_W-3]),
	.vec_b						(op_b[G_DAT_W+1:2]),
	.mul_r 						(grp2_r)
	);

sca_mul grp3(
	.bit_a						(op_a[G_DAT_W-4]),
	.vec_b						(op_b[G_DAT_W+2:3]),
	.mul_r 						(grp3_r)
	);

sca_mul grp4(
	.bit_a						(op_a[G_DAT_W-5]),
	.vec_b						(op_b[G_DAT_W+3:4]),
	.mul_r 						(grp4_r)
	);

sca_mul grp5(
	.bit_a						(op_a[G_DAT_W-6]),
	.vec_b						(op_b[G_DAT_W+4:5]),
	.mul_r 						(grp5_r)
	);

sca_mul grp6(
	.bit_a						(op_a[G_DAT_W-7]),
	.vec_b						(op_b[G_DAT_W+5:6]),
	.mul_r 						(grp6_r)
	);

sca_mul grp7(
	.bit_a						(op_a[G_DAT_W-8]),
	.vec_b						(op_b[G_DAT_W+6:7]),
	.mul_r 						(grp7_r)
	);



//GROUP-1
sca_mul grp8(
	.bit_a						(op_a[G_DAT_W-9]),
	.vec_b						(op_b[G_DAT_W+7:8]),
	.mul_r 						(grp8_r)
	);

sca_mul grp9(
	.bit_a						(op_a[G_DAT_W-10]),
	.vec_b						(op_b[G_DAT_W+8:9]),
	.mul_r 						(grp9_r)
	);

sca_mul grp10(
	.bit_a						(op_a[G_DAT_W-11]),
	.vec_b						(op_b[G_DAT_W+9:10]),
	.mul_r 						(grp10_r)
	);

sca_mul grp11(
	.bit_a						(op_a[G_DAT_W-12]),
	.vec_b						(op_b[G_DAT_W+10:11]),
	.mul_r 						(grp11_r)
	);

sca_mul grp12(
	.bit_a						(op_a[G_DAT_W-13]),
	.vec_b						(op_b[G_DAT_W+11:12]),
	.mul_r 						(grp12_r)
	);

sca_mul grp13(
	.bit_a						(op_a[G_DAT_W-14]),
	.vec_b						(op_b[G_DAT_W+12:13]),
	.mul_r 						(grp13_r)
	);

sca_mul grp14(
	.bit_a						(op_a[G_DAT_W-15]),
	.vec_b						(op_b[G_DAT_W+13:14]),
	.mul_r 						(grp14_r)
	);

sca_mul grp15(
	.bit_a						(op_a[G_DAT_W-16]),
	.vec_b						(op_b[G_DAT_W+14:15]),
	.mul_r 						(grp15_r)
	);



//GROUP-2
sca_mul grp16(
	.bit_a						(op_a[G_DAT_W-17]),
	.vec_b						(op_b[G_DAT_W+15:16]),
	.mul_r 						(grp16_r)
	);

sca_mul grp17(
	.bit_a						(op_a[G_DAT_W-18]),
	.vec_b						(op_b[G_DAT_W+16:17]),
	.mul_r 						(grp17_r)
	);

sca_mul grp18(
	.bit_a						(op_a[G_DAT_W-19]),
	.vec_b						(op_b[G_DAT_W+17:18]),
	.mul_r 						(grp18_r)
	);

sca_mul grp19(
	.bit_a						(op_a[G_DAT_W-20]),
	.vec_b						(op_b[G_DAT_W+18:19]),
	.mul_r 						(grp19_r)
	);

sca_mul grp20(
	.bit_a						(op_a[G_DAT_W-21]),
	.vec_b						(op_b[G_DAT_W+19:20]),
	.mul_r 						(grp20_r)
	);

sca_mul grp21(
	.bit_a						(op_a[G_DAT_W-22]),
	.vec_b						(op_b[G_DAT_W+20:21]),
	.mul_r 						(grp21_r)
	);

sca_mul grp22(
	.bit_a						(op_a[G_DAT_W-23]),
	.vec_b						(op_b[G_DAT_W+21:22]),
	.mul_r 						(grp22_r)
	);

sca_mul grp23(
	.bit_a						(op_a[G_DAT_W-24]),
	.vec_b						(op_b[G_DAT_W+22:23]),
	.mul_r 						(grp23_r)
	);



//GROUP-3
sca_mul grp24(
	.bit_a						(op_a[G_DAT_W-25]),
	.vec_b						(op_b[G_DAT_W+23:24]),
	.mul_r 						(grp24_r)
	);

sca_mul grp25(
	.bit_a						(op_a[G_DAT_W-26]),
	.vec_b						(op_b[G_DAT_W+24:25]),
	.mul_r 						(grp25_r)
	);

sca_mul grp26(
	.bit_a						(op_a[G_DAT_W-27]),
	.vec_b						(op_b[G_DAT_W+25:26]),
	.mul_r 						(grp26_r)
	);

sca_mul grp27(
	.bit_a						(op_a[G_DAT_W-28]),
	.vec_b						(op_b[G_DAT_W+26:27]),
	.mul_r 						(grp27_r)
	);

sca_mul grp28(
	.bit_a						(op_a[G_DAT_W-29]),
	.vec_b						(op_b[G_DAT_W+27:28]),
	.mul_r 						(grp28_r)
	);

sca_mul grp29(
	.bit_a						(op_a[G_DAT_W-30]),
	.vec_b						(op_b[G_DAT_W+28:29]),
	.mul_r 						(grp29_r)
	);

sca_mul grp30(
	.bit_a						(op_a[G_DAT_W-31]),
	.vec_b						(op_b[G_DAT_W+29:30]),
	.mul_r 						(grp30_r)
	);

sca_mul grp31(
	.bit_a						(op_a[G_DAT_W-32]),
	.vec_b						(op_b[G_DAT_W+30:31]),
	.mul_r 						(grp31_r)
	);



//GROUP-4
sca_mul grp32(
	.bit_a						(op_a[G_DAT_W-33]),
	.vec_b						(op_b[G_DAT_W+31:32]),
	.mul_r 						(grp32_r)
	);

sca_mul grp33(
	.bit_a						(op_a[G_DAT_W-34]),
	.vec_b						(op_b[G_DAT_W+32:33]),
	.mul_r 						(grp33_r)
	);

sca_mul grp34(
	.bit_a						(op_a[G_DAT_W-35]),
	.vec_b						(op_b[G_DAT_W+33:34]),
	.mul_r 						(grp34_r)
	);

sca_mul grp35(
	.bit_a						(op_a[G_DAT_W-36]),
	.vec_b						(op_b[G_DAT_W+34:35]),
	.mul_r 						(grp35_r)
	);

sca_mul grp36(
	.bit_a						(op_a[G_DAT_W-37]),
	.vec_b						(op_b[G_DAT_W+35:36]),
	.mul_r 						(grp36_r)
	);

sca_mul grp37(
	.bit_a						(op_a[G_DAT_W-38]),
	.vec_b						(op_b[G_DAT_W+36:37]),
	.mul_r 						(grp37_r)
	);

sca_mul grp38(
	.bit_a						(op_a[G_DAT_W-39]),
	.vec_b						(op_b[G_DAT_W+37:38]),
	.mul_r 						(grp38_r)
	);

sca_mul grp39(
	.bit_a						(op_a[G_DAT_W-40]),
	.vec_b						(op_b[G_DAT_W+38:39]),
	.mul_r 						(grp39_r)
	);




//GROUP-5
sca_mul grp40(
	.bit_a						(op_a[G_DAT_W-41]),
	.vec_b						(op_b[G_DAT_W+39:40]),
	.mul_r 						(grp40_r)
	);

sca_mul grp41(
	.bit_a						(op_a[G_DAT_W-42]),
	.vec_b						(op_b[G_DAT_W+40:41]),
	.mul_r 						(grp41_r)
	);

sca_mul grp42(
	.bit_a						(op_a[G_DAT_W-43]),
	.vec_b						(op_b[G_DAT_W+41:42]),
	.mul_r 						(grp42_r)
	);

sca_mul grp43(
	.bit_a						(op_a[G_DAT_W-44]),
	.vec_b						(op_b[G_DAT_W+42:43]),
	.mul_r 						(grp43_r)
	);

sca_mul grp44(
	.bit_a						(op_a[G_DAT_W-45]),
	.vec_b						(op_b[G_DAT_W+43:44]),
	.mul_r 						(grp44_r)
	);

sca_mul grp45(
	.bit_a						(op_a[G_DAT_W-46]),
	.vec_b						(op_b[G_DAT_W+44:45]),
	.mul_r 						(grp45_r)
	);

sca_mul grp46(
	.bit_a						(op_a[G_DAT_W-47]),
	.vec_b						(op_b[G_DAT_W+45:46]),
	.mul_r 						(grp46_r)
	);

sca_mul grp47(
	.bit_a						(op_a[G_DAT_W-48]),
	.vec_b						(op_b[G_DAT_W+46:47]),
	.mul_r 						(grp47_r)
	);




//GROUP-6
sca_mul grp48(
	.bit_a						(op_a[G_DAT_W-49]),
	.vec_b						(op_b[G_DAT_W+47:48]),
	.mul_r 						(grp48_r)
	);

sca_mul grp49(
	.bit_a						(op_a[G_DAT_W-50]),
	.vec_b						(op_b[G_DAT_W+48:49]),
	.mul_r 						(grp49_r)
	);

sca_mul grp50(
	.bit_a						(op_a[G_DAT_W-51]),
	.vec_b						(op_b[G_DAT_W+49:50]),
	.mul_r 						(grp50_r)
	);

sca_mul grp51(
	.bit_a						(op_a[G_DAT_W-52]),
	.vec_b						(op_b[G_DAT_W+50:51]),
	.mul_r 						(grp51_r)
	);

sca_mul grp52(
	.bit_a						(op_a[G_DAT_W-53]),
	.vec_b						(op_b[G_DAT_W+51:52]),
	.mul_r 						(grp52_r)
	);

sca_mul grp53(
	.bit_a						(op_a[G_DAT_W-54]),
	.vec_b						(op_b[G_DAT_W+52:53]),
	.mul_r 						(grp53_r)
	);

sca_mul grp54(
	.bit_a						(op_a[G_DAT_W-55]),
	.vec_b						(op_b[G_DAT_W+53:54]),
	.mul_r 						(grp54_r)
	);

sca_mul grp55(
	.bit_a						(op_a[G_DAT_W-56]),
	.vec_b						(op_b[G_DAT_W+54:55]),
	.mul_r 						(grp55_r)
	);


//GROUP-7
sca_mul grp56(
	.bit_a						(op_a[G_DAT_W-57]),
	.vec_b						(op_b[G_DAT_W+55:56]),
	.mul_r 						(grp56_r)
	);

sca_mul grp57(
	.bit_a						(op_a[G_DAT_W-58]),
	.vec_b						(op_b[G_DAT_W+56:57]),
	.mul_r 						(grp57_r)
	);

sca_mul grp58(
	.bit_a						(op_a[G_DAT_W-59]),
	.vec_b						(op_b[G_DAT_W+57:58]),
	.mul_r 						(grp58_r)
	);

sca_mul grp59(
	.bit_a						(op_a[G_DAT_W-60]),
	.vec_b						(op_b[G_DAT_W+58:59]),
	.mul_r 						(grp59_r)
	);

sca_mul grp60(
	.bit_a						(op_a[G_DAT_W-61]),
	.vec_b						(op_b[G_DAT_W+59:60]),
	.mul_r 						(grp60_r)
	);

sca_mul grp61(
	.bit_a						(op_a[G_DAT_W-62]),
	.vec_b						(op_b[G_DAT_W+60:61]),
	.mul_r 						(grp61_r)
	);

sca_mul grp62(
	.bit_a						(op_a[G_DAT_W-63]),
	.vec_b						(op_b[G_DAT_W+61:62]),
	.mul_r 						(grp62_r)
	);

sca_mul grp63(
	.bit_a						(op_a[G_DAT_W-64]),
	.vec_b						(op_b[G_DAT_W+62:63]),
	.mul_r 						(grp63_r)
	);

/*
always @(posedge clk) begin
	if (~rst_b) 
		tmp0 <= {G_DAT_W{1'b0}};
	else 
		tmp0 <= grp0_r ^ grp1_r ^ grp2_r ^ grp3_r ^ grp4_r ^ grp5_r ^ grp6_r ^ grp7_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp1 <= {G_DAT_W{1'b0}};
	else 
		tmp1 <= grp8_r ^ grp9_r ^ grp10_r ^ grp11_r ^ grp12_r ^ grp13_r ^ grp14_r ^ grp15_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp2 <= {G_DAT_W{1'b0}};
	else 
		tmp2 <= grp16_r ^ grp17_r ^ grp18_r ^ grp19_r ^ grp20_r ^ grp21_r ^ grp22_r ^ grp23_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp3 <= {G_DAT_W{1'b0}};
	else 
		tmp3 <= grp24_r ^ grp25_r ^ grp26_r ^ grp27_r ^ grp28_r ^ grp29_r ^ grp30_r ^ grp31_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp4 <= {G_DAT_W{1'b0}};
	else 
		tmp4 <= grp32_r ^ grp33_r ^ grp34_r ^ grp35_r ^ grp36_r ^ grp37_r ^ grp38_r ^ grp39_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp5 <= {G_DAT_W{1'b0}};
	else 
		tmp5 <= grp40_r ^ grp41_r ^ grp42_r ^ grp43_r ^ grp44_r ^ grp45_r ^ grp46_r ^ grp47_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp6 <= {G_DAT_W{1'b0}};
	else 
		tmp6 <= grp48_r ^ grp49_r ^ grp50_r ^ grp51_r ^ grp52_r ^ grp53_r ^ grp54_r ^ grp55_r;  
end

always @(posedge clk) begin
	if (~rst_b) 
		tmp7 <= {G_DAT_W{1'b0}};
	else 
		tmp7 <= grp56_r ^ grp57_r ^ grp58_r ^ grp59_r ^ grp60_r ^ grp61_r ^ grp62_r ^ grp63_r;  
end
*/

assign tmp0 = grp0_r ^ grp1_r ^ grp2_r ^ grp3_r ^ grp4_r ^ grp5_r ^ grp6_r ^ grp7_r;  
assign tmp1 = grp8_r ^ grp9_r ^ grp10_r ^ grp11_r ^ grp12_r ^ grp13_r ^ grp14_r ^ grp15_r;  
assign tmp2 = grp16_r ^ grp17_r ^ grp18_r ^ grp19_r ^ grp20_r ^ grp21_r ^ grp22_r ^ grp23_r;  
assign tmp3 = grp24_r ^ grp25_r ^ grp26_r ^ grp27_r ^ grp28_r ^ grp29_r ^ grp30_r ^ grp31_r; 
assign tmp4 = grp32_r ^ grp33_r ^ grp34_r ^ grp35_r ^ grp36_r ^ grp37_r ^ grp38_r ^ grp39_r; 
assign tmp5 = grp40_r ^ grp41_r ^ grp42_r ^ grp43_r ^ grp44_r ^ grp45_r ^ grp46_r ^ grp47_r;  
assign tmp6 = grp48_r ^ grp49_r ^ grp50_r ^ grp51_r ^ grp52_r ^ grp53_r ^ grp54_r ^ grp55_r;  
assign tmp7 = grp56_r ^ grp57_r ^ grp58_r ^ grp59_r ^ grp60_r ^ grp61_r ^ grp62_r ^ grp63_r;

//pipeline
always @(posedge clk) begin
	if (~rst_b) 
		mul_r <= {G_DAT_W{1'b0}};
	else 
		mul_r <= tmp0 ^ tmp1 ^ tmp2 ^ tmp3 ^ tmp4 ^ tmp5 ^ tmp6 ^ tmp7; 	
end

endmodule



module sca_mul
#(  parameter 					r = 10163,
	parameter               	G_ADDR_W = 8,
    parameter               	G_DAT_W = 64,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14)
(
	input 						bit_a,
	input [G_DAT_W-1:0] 		vec_b,

	output [G_DAT_W-1:0]		mul_r
	);

generate
  genvar i;
  for (i = 0; i < G_DAT_W; i = i + 1) begin : gen1
      assign mul_r[i] = bit_a & vec_b[i];
   end
endgenerate 

endmodule