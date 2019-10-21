`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2019 09:37:27
// Design Name: 
// Module Name: BIKE_2_top
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

module BIKE_2_top
#(  parameter 				r = 10163,
	parameter               RNG_DAT_W = 64,
    parameter               G_ADDR_W = 8,
    parameter               G_DAT_W = 64,
    parameter				H_ADDR_W = 7,
    parameter				H_DAT_W = 14
    )
(
    input 					clk,
    input 					rst_b,
    input 					start,
	//RNG interface    
    input 					rng_valid,
    input [RNG_DAT_W-1:0] 	rng_in,
    output reg [1:0]		rng_start,
	//memory interface
	output 					h0_out,
	output 					h1_out,
	output					f_out   
    );

//declare core_ctrl
wire					h0_ctrl_done, h1_ctrl_done, inv_ctrl_done, mul_ctrl_done;
wire					h0_ctrl_start, h1_ctrl_start, inv_ctrl_start, mul_ctrl_start;

wire [2:0]				state;	
reg [2:0] 				state_tmp;				


//declare h_ctrl 
wire 					h0_ctrl_wea, h0_ctrl_web;
wire [H_ADDR_W-1:0] 	h0_ctrl_addra, h0_ctrl_addrb;
wire [H_DAT_W-1:0] 		h0_ctrl_douta, h0_ctrl_doutb;

wire 					h0_ctrl_rng_rd;
wire 					h0_ctrl_rng_wr;
wire [1:0]				h0_ctrl_rng_start;


wire 					h1_ctrl_wea, h1_ctrl_web;
wire [H_ADDR_W-1:0] 	h1_ctrl_addra, h1_ctrl_addrb;
wire [H_DAT_W-1:0] 		h1_ctrl_douta, h1_ctrl_doutb;

wire 					h1_ctrl_rng_rd;
wire 					h1_ctrl_rng_wr;
wire [1:0]				h1_ctrl_rng_start;


//declare spa2dsn
wire 					spa2dsn_start, spa2dsn_done;

wire [H_ADDR_W-1:0] 	spa2dsn_h0_addra;
wire 					spa2dsn_h0_wea;

wire [G_ADDR_W-1:0] 	spa2dsn_h0_bk_addra;
wire 					spa2dsn_h0_bk_wea;
wire [G_DAT_W-1:0]		spa2dsn_h0_bk_douta;


//declare inv_ctrl
wire 					inv_ctrl_op0_wea, inv_ctrl_op0_web;
wire [G_ADDR_W-1:0]		inv_ctrl_op0_addra, inv_ctrl_op0_addrb;
wire [G_DAT_W-1:0]		inv_ctrl_op0_douta, inv_ctrl_op0_doutb;

wire 					inv_ctrl_op1_wea, inv_ctrl_op1_web;
wire [G_ADDR_W-1:0]		inv_ctrl_op1_addra, inv_ctrl_op1_addrb;
wire [G_DAT_W-1:0]		inv_ctrl_op1_douta, inv_ctrl_op1_doutb;

wire 					inv_ctrl_re_wea, inv_ctrl_re_web;
wire [G_ADDR_W-1:0]		inv_ctrl_re_addra, inv_ctrl_re_addrb;
wire [G_DAT_W-1:0]		inv_ctrl_re_douta, inv_ctrl_re_doutb;

wire 					inv_ctrl_h0_wea;
wire [G_ADDR_W-1:0]		inv_ctrl_h0_addra;
wire [G_DAT_W-1:0]		inv_ctrl_h0_douta;

//declare mul_ctrl
wire 					mul_ctrl_op0_wea, mul_ctrl_op0_web;
wire [G_ADDR_W-1:0]		mul_ctrl_op0_addra, mul_ctrl_op0_addrb;
wire [G_DAT_W-1:0]		mul_ctrl_op0_douta, mul_ctrl_op0_doutb;

wire 					mul_ctrl_h1_wea;
wire [H_ADDR_W-1:0]		mul_ctrl_h1_addra;
wire [H_DAT_W-1:0]		mul_ctrl_h1_douta;

wire 					mul_ctrl_f_wea;
wire [G_ADDR_W-1:0]		mul_ctrl_f_addra;
wire [G_DAT_W-1:0]		mul_ctrl_f_douta;


//declare fifo h0_rng
reg 					h0_rng_rd_en;
reg 					h0_rng_wr_en;
wire [G_DAT_W-1:0] 		h0_rng_out;
wire 					h0_rng_empty;
//declare fifo h1_rng
reg 					h1_rng_rd_en;
reg 					h1_rng_wr_en;
wire [G_DAT_W-1:0] 		h1_rng_out;
wire 					h1_rng_empty;

//declare mem_h
reg 					h0_wea, h0_web;
reg [H_ADDR_W-1:0]		h0_addra, h0_addrb;
reg [H_DAT_W-1:0] 		h0_dina, h0_dinb;
wire [H_DAT_W-1:0]		h0_douta, h0_doutb;

reg 					h1_wea, h1_web;
reg [H_ADDR_W-1:0]		h1_addra, h1_addrb;
reg [H_DAT_W-1:0] 		h1_dina, h1_dinb;
wire [H_DAT_W-1:0]		h1_douta, h1_doutb;

reg 					h0_bk_wea, h0_bk_web;
reg [G_ADDR_W-1:0]		h0_bk_addra, h0_bk_addrb;
reg [G_DAT_W-1:0] 		h0_bk_dina, h0_bk_dinb;
wire [G_DAT_W-1:0]		h0_bk_douta, h0_bk_doutb;

//declare intermediate memory for dense_multiplication
reg 					op0_wea, op0_web;
reg [G_ADDR_W-1:0]		op0_addra, op0_addrb;
reg [G_DAT_W-1:0] 		op0_dina, op0_dinb;
wire [G_DAT_W-1:0]		op0_douta, op0_doutb;

reg 					op1_wea, op1_web;
reg [G_ADDR_W-1:0]		op1_addra, op1_addrb;
reg [G_DAT_W-1:0] 		op1_dina, op1_dinb;
wire [G_DAT_W-1:0]		op1_douta, op1_doutb;

reg 					re_wea, re_web;
reg [G_ADDR_W-1:0]		re_addra, re_addrb;
reg [G_DAT_W-1:0] 		re_dina, re_dinb;
wire [G_DAT_W-1:0]		re_douta, re_doutb;

//declare mem_f,  f = h0^{-1}*h1
reg 					f_wea, f_web;
reg [G_ADDR_W-1:0]		f_addra, f_addrb;
reg [G_DAT_W-1:0] 		f_dina, f_dinb;
wire [G_DAT_W-1:0]		f_douta, f_doutb;


core_ctrl core_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(start),


	.h0_gen_done			(h0_ctrl_done),
	.h1_gen_done			(h1_ctrl_done),
	.inv_gen_done 			(inv_ctrl_done),
	.spa2dsn_done 			(spa2dsn_done),
	.mul_gen_done 			(mul_ctrl_done),

	.current_state 			(state),

	.h0_gen_start 			(h0_ctrl_start),
	.h1_gen_start 			(h1_ctrl_start),
	.spa2dsn_start 			(spa2dsn_start),
	.inv_gen_start			(inv_ctrl_start),
	.mul_gen_start 			(mul_ctrl_start)
    );


//control logic for generating polynomial h0,h1
h0_ctrl h0_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(h0_ctrl_start),
	.done 					(h0_ctrl_done),

	.fifo_rng_rd			(h0_ctrl_rng_rd),
	.fifo_rng_wr 			(h0_ctrl_rng_wr),
	.fifo_rng_empty 		(h0_rng_empty),
	.fifo_rng_din			(h0_rng_out),
	.rng_start				(h0_ctrl_rng_start),
	
	.h_addra 				(h0_ctrl_addra),
	.h_wea 					(h0_ctrl_wea),
	.h_douta 				(h0_ctrl_douta),
	.h_dina 				(h0_douta),
	.h_addrb 				(h0_ctrl_addrb),
	.h_web 					(h0_ctrl_web),
	.h_doutb 				(h0_ctrl_doutb),
	.h_dinb 				(h0_doutb)
	);

h1_ctrl h1_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(h1_ctrl_start),
	.done 					(h1_ctrl_done),

	.fifo_rng_rd			(h1_ctrl_rng_rd),
	.fifo_rng_wr 			(h1_ctrl_rng_wr),
	.fifo_rng_empty 		(h1_rng_empty),
	.fifo_rng_din			(h1_rng_out),
	.rng_start				(h1_ctrl_rng_start),
	
	.h_addra 				(h1_ctrl_addra),
	.h_wea 					(h1_ctrl_wea),
	.h_douta 				(h1_ctrl_douta),
	.h_dina 				(h1_douta),
	.h_addrb 				(h1_ctrl_addrb),
	.h_web 					(h1_ctrl_web),
	.h_doutb 				(h1_ctrl_doutb),
	.h_dinb 				(h1_doutb)
	);

//control logic for converting sparse form to dnese form
sparse2dense  spa2dsn (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(spa2dsn_start),
	.done 					(spa2dsn_done),

	.h_spa_addra			(spa2dsn_h0_addra),
	.h_spa_wea				(spa2dsn_h0_wea),
	.h_spa_dina				(h0_douta), 

	.h_dsn_addra			(spa2dsn_h0_bk_addra),
	.h_dsn_wea				(spa2dsn_h0_bk_wea),
	.h_dsn_douta			(spa2dsn_h0_bk_douta),
	.h_dsn_dina 			(h0_bk_douta)
    );


//control logic for multiplicative inverse h0^{-1}
inv_ctrl inv_ctrl(
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(inv_ctrl_start),
	.done 					(inv_ctrl_done),

	.op0_addra 				(inv_ctrl_op0_addra),
	.op0_wea 				(inv_ctrl_op0_wea),
	.op0_douta 				(inv_ctrl_op0_douta),
	.op0_dina 				(op0_douta),
	.op0_addrb				(inv_ctrl_op0_addrb),
	.op0_web 				(inv_ctrl_op0_web),
	.op0_doutb 				(inv_ctrl_op0_doutb),
	.op0_dinb 				(op0_doutb),

	.op1_addra 				(inv_ctrl_op1_addra),
	.op1_wea 				(inv_ctrl_op1_wea),
	.op1_douta 				(inv_ctrl_op1_douta),
	.op1_dina 				(op1_douta),
	.op1_addrb 				(inv_ctrl_op1_addrb),
	.op1_web 				(inv_ctrl_op1_web),
	.op1_doutb 				(inv_ctrl_op1_doutb),
	.op1_dinb 				(op1_doutb),

	.re_addra 				(inv_ctrl_re_addra),
	.re_wea					(inv_ctrl_re_wea),
	.re_douta 				(inv_ctrl_re_douta),
	.re_dina 				(re_douta),
	.re_addrb 				(inv_ctrl_re_addrb),
	.re_web 				(inv_ctrl_re_web),
	.re_doutb 				(inv_ctrl_re_doutb),
	.re_dinb 				(re_doutb),

	.h0_addra 				(inv_ctrl_h0_addra),
	.h0_wea 				(inv_ctrl_h0_wea),
	.h0_douta 				(inv_ctrl_h0_douta),
	.h0_dina 				(h0_bk_douta)
	);

//control logic for sparse multiplication h0^{-1}*h1
mul_ctrl mul_ctrl(
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(mul_ctrl_start),
	.done 					(mul_ctrl_done),

	.g_addra 				(mul_ctrl_op0_addra),
	.g_wea 					(mul_ctrl_op0_wea),
	.g_douta 				(mul_ctrl_op0_douta),
	.g_dina					(op0_douta), 
	.g_addrb				(mul_ctrl_op0_addrb),
	.g_web 					(mul_ctrl_op0_web),
	.g_doutb				(mul_ctrl_op0_doutb),
	.g_dinb 				(op0_doutb),

	.h_addra 				(mul_ctrl_h1_addra),
	.h_wea 					(mul_ctrl_h1_wea),
	.h_douta 				(mul_ctrl_h1_douta),
	.h_dina 				(h1_douta), 

	.f_addra 				(mul_ctrl_f_addra),
	.f_wea 					(mul_ctrl_f_wea),
	.f_douta 				(mul_ctrl_f_douta),
	.f_dina 				(f_douta)
    );


fifo_rng h0_rng (
  .clk 						(clk),                // input wire clk
  .srst 					(1'b0),              // input wire srst
  .din 						(rng_in),                // input wire [63 : 0] din
  .wr_en 					(h0_rng_wr_en),            // input wire wr_en
  .rd_en 					(h0_rng_rd_en),            // input wire rd_en
  .dout 					(h0_rng_out),              // output wire [63 : 0] dout
  .full 					(),              // output wire full
  .empty 					(h0_rng_empty),            // output wire empty
  .data_count 				()  // output wire [3 : 0] data_count
);

fifo_rng h1_rng (
  .clk 						(clk),                // input wire clk
  .srst 					(1'b0),              // input wire srst
  .din 						(rng_in),                // input wire [63 : 0] din
  .wr_en 					(h1_rng_wr_en),            // input wire wr_en
  .rd_en 					(h1_rng_rd_en),            // input wire rd_en
  .dout 					(h1_rng_out),              // output wire [63 : 0] dout
  .full 					(),              // output wire full
  .empty 					(h1_rng_empty),            // output wire empty
  .data_count 				()  // output wire [3 : 0] data_count
);


// sparse polynomial h0, w/2=71 addresses, each address contains 14-bit data
mem_h h0 (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(h0_wea),      // input wire [0 : 0] wea
  .addra 					(h0_addra),  // input wire [6 : 0] addra
  .dina 					(h0_dina),    // input wire [13 : 0] dina
  .douta 					(h0_douta),  // output wire [13 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(h0_web),      // input wire [0 : 0] web
  .addrb  					(h0_addrb),  // input wire [6 : 0] addrb
  .dinb 					(h0_dinb),    // input wire [13 : 0] dinb
  .doutb 					(h0_doutb)  // output wire [13 : 0] doutb
);

// dense polynomial h0, r/d=159 addresses, each address contains 64-bit data
mem_g h0_bk (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(h0_bk_wea),      // input wire [0 : 0] wea
  .addra 					(h0_bk_addra),  // input wire [6 : 0] addra
  .dina 					(h0_bk_dina),    // input wire [13 : 0] dina
  .douta 					(h0_bk_douta),  // output wire [13 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(h0_bk_web),      // input wire [0 : 0] web
  .addrb  					(h0_bk_addrb),  // input wire [6 : 0] addrb
  .dinb 					(h0_bk_dinb),    // input wire [13 : 0] dinb
  .doutb 					(h0_bk_doutb)  // output wire [13 : 0] doutb	
);

// sparse polynomial h1, w/2=71 addresses, each address contains 14-bit data
mem_h h1 (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(h1_wea),      // input wire [0 : 0] wea
  .addra 					(h1_addra),  // input wire [6 : 0] addra
  .dina 					(h1_dina),    // input wire [13 : 0] dina
  .douta 					(h1_douta),  // output wire [13 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(h1_web),      // input wire [0 : 0] web
  .addrb  					(h1_addrb),  // input wire [6 : 0] addrb
  .dinb 					(h1_dinb),    // input wire [13 : 0] dinb
  .doutb 					(h1_doutb)  // output wire [13 : 0] doutb
);


//intermediate results, the inverse h0^{-1} is stored here
mem_g mul_op0 (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(op0_wea),      // input wire [0 : 0] wea
  .addra 					(op0_addra),  // input wire [6 : 0] addra
  .dina 					(op0_dina),    // input wire [13 : 0] dina
  .douta 					(op0_douta),  // output wire [13 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(op0_web),      // input wire [0 : 0] web
  .addrb  					(op0_addrb),  // input wire [6 : 0] addrb
  .dinb 					(op0_dinb),    // input wire [13 : 0] dinb
  .doutb 					(op0_doutb)  // output wire [13 : 0] doutb	
);

mem_g mul_op1 (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(op1_wea),      // input wire [0 : 0] wea
  .addra 					(op1_addra),  // input wire [6 : 0] addra
  .dina 					(op1_dina),    // input wire [13 : 0] dina
  .douta 					(op1_douta),  // output wire [13 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(op1_web),      // input wire [0 : 0] web
  .addrb  					(op1_addrb),  // input wire [6 : 0] addrb
  .dinb 					(op1_dinb),    // input wire [13 : 0] dinb
  .doutb 					(op1_doutb)  // output wire [13 : 0] doutb	
);

mem_g mul_re (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(re_wea),      // input wire [0 : 0] wea
  .addra 					(re_addra),  // input wire [6 : 0] addra
  .dina 					(re_dina),    // input wire [13 : 0] dina
  .douta 					(re_douta),  // output wire [13 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(re_web),      // input wire [0 : 0] web
  .addrb  					(re_addrb),  // input wire [6 : 0] addrb
  .dinb 					(re_dinb),    // input wire [13 : 0] dinb
  .doutb 					(re_doutb)  // output wire [13 : 0] doutb	
);


// final result, dense polynomial f0, r/d=159 addresses, each address contains 64-bit data
mem_g f (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(f_wea),      // input wire [0 : 0] wea
  .addra 					(f_addra),  // input wire [7 : 0] addra
  .dina 					(f_dina),    // input wire [63 : 0] dina
  .douta 					(f_douta),  // output wire [63 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b0),      // input wire enb
  .web 						(f_web),      // input wire [0 : 0] web
  .addrb 					(f_addrb),  // input wire [7 : 0] addrb
  .dinb 					(f_dinb),    // input wire [63 : 0] dinb
  .doutb 					(f_doutb)  // output wire [63 : 0] doutb
);




always @(posedge clk) begin
	if (!rst_b) // reset
		h0_rng_rd_en <= 1'b0;
	else if (state == 1) 
		h0_rng_rd_en <= h0_ctrl_rng_rd;	
	else 
		h0_rng_rd_en <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_rng_rd_en <= 1'b0;
	else if (state == 2) 
		h1_rng_rd_en <= h1_ctrl_rng_rd;	
	else 
		h1_rng_rd_en <= 1'b0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		h0_rng_wr_en <= 1'b0;
	else if (state == 1)
		h0_rng_wr_en <= rng_valid && h0_ctrl_rng_wr && rng_in[H_DAT_W-1:0] < r && rng_in[16+H_DAT_W-1:16] < r;	
	else 
		h0_rng_wr_en <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_rng_wr_en <= 1'b0;
	else if (state == 2)
		h1_rng_wr_en <= rng_valid && h1_ctrl_rng_wr && rng_in[H_DAT_W-1:0] < r && rng_in[16+H_DAT_W-1:16] < r;	
	else 
		h1_rng_wr_en <= 1'b0;
end
	

always @(posedge clk) begin
	if (!rst_b) // reset
		rng_start <= 2'b0;
	else if (state == 1)
		rng_start <= h0_ctrl_rng_start;	
	else if (state == 2)
		rng_start <= h1_ctrl_rng_start;	
	else 
		rng_start <= 2'b0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		h0_wea <= 1'b0;
	else if (state_tmp == 1) //H0_GEN
		h0_wea <= h0_ctrl_wea;
	else if (state_tmp == 2) //SPA2DSN GEN
		h0_wea <= spa2dsn_h0_wea;	
	else 
		h0_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_addra <= 0;
	else if (state_tmp == 1) 
		h0_addra <= h0_ctrl_addra;
	else if (state_tmp == 2) //SPA2DSN GEN
		h0_addra <= spa2dsn_h0_addra;
	else 
		h0_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_dina <= 0;
	else if (state_tmp == 1) 
		h0_dina <= h0_ctrl_douta;	
	else 
		h0_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_web <= 1'b0;
	else if (state_tmp == 1) 
		h0_web <= h0_ctrl_web;
	else 
		h0_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_addrb <= 0;
	else if (state_tmp == 1) 
		h0_addrb <= h0_ctrl_addrb;
	else 
		h0_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_dinb <= 0;
	else if (state_tmp == 1) 
		h0_dinb <= h0_ctrl_doutb;
	else 
		h0_dinb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_wea <= 1'b0;
	else if (state_tmp == 2) //H1_GEN
		h1_wea <= h1_ctrl_wea;
	else if (state_tmp == 4) //F_GEN
		h1_wea <= mul_ctrl_h1_wea;
	else 
		h1_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_addra <= 0;
	else if (state_tmp == 2) //H1_GEN
		h1_addra <= h1_ctrl_addra;
	else if (state_tmp == 4) //F_GEN
		h1_addra <= mul_ctrl_h1_addra;
	else 
		h1_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_dina <= 0;
	else if (state_tmp == 2) //H1_GEN
		h1_dina <= h1_ctrl_douta;
	else if (state_tmp == 4) //F_GEN
		h1_dina <= mul_ctrl_h1_douta;
	else 
		h1_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_web <= 1'b0;
	else if (state_tmp == 2) //H1_GEN
		h1_web <= h1_ctrl_web;
	else 
		h1_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_addrb <= 0;
	else if (state_tmp == 2) //H1_GEN
		h1_addrb <= h1_ctrl_addrb;
	else 
		h1_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_dinb <= 0;
	else if (state_tmp == 2) //H1_GEN
		h1_dinb <= h1_ctrl_doutb;
	else 
		h1_dinb <= 0;
end

//h0_bk
always @(posedge clk) begin
	if (!rst_b) // reset
		h0_bk_wea <= 1'b0;
	else if (state_tmp == 2) //SPA2DSN GEN
		h0_bk_wea <= spa2dsn_h0_bk_wea;	
	else if (state_tmp == 3) //INV GEN
		h0_bk_wea <= inv_ctrl_h0_wea;	
	else 
		h0_bk_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_bk_addra <= 0;
	else if (state_tmp == 2) //SPA2DSN GEN
		h0_bk_addra <= spa2dsn_h0_bk_addra;
	else if (state_tmp == 3) //INV GEN	
		h0_bk_addra <= inv_ctrl_h0_addra;
	else 
		h0_bk_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_bk_dina <= 0;
	else if (state_tmp == 2) //SPA2DSN GEN
		h0_bk_dina <= spa2dsn_h0_bk_douta;	
	else if (state_tmp == 3) //INV GEN
		h0_bk_dina <= inv_ctrl_h0_douta;
	else 
		h0_bk_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_bk_web <= 1'b0;
	else 
		h0_bk_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_bk_addrb <= 0;
	else 
		h0_bk_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_bk_dinb <= 0;
	else 
		h0_bk_dinb <= 0;
end

//mul_op0
always @(posedge clk) begin
	if (!rst_b) // reset
		op0_wea <= 1'b0;
	else if (state_tmp == 3) //INV GEN
		op0_wea <= inv_ctrl_op0_wea;
	else if (state_tmp == 4) //F_GEN	
		op0_wea <= mul_ctrl_op0_wea;	
	else 
		op0_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op0_addra <= 0;
	else if (state_tmp == 3) //INV GEN
		op0_addra <= inv_ctrl_op0_addra;
	else if (state_tmp == 4) //F_GEN	
		op0_addra <= mul_ctrl_op0_addra;	
	else 
		op0_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op0_dina <= 0;
	else if (state_tmp == 3) //INV GEN
		op0_dina <= inv_ctrl_op0_douta;	
	else if (state_tmp == 4) //F_GEN	
		op0_dina <= mul_ctrl_op0_douta;
	else 
		op0_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op0_web <= 1'b0;
	else if (state_tmp == 4) //F_GEN
		op0_web <= mul_ctrl_op0_web;		
	else 
		op0_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op0_addrb <= 0;	
	else if (state_tmp == 4) //F_GEN
		op0_addrb <= mul_ctrl_op0_addrb;
	else 
		op0_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op0_dinb <= 0;	
	else if (state_tmp == 4) //F_GEN
		op0_dinb <= mul_ctrl_op0_doutb;
	else 
		op0_dinb <= 0;
end

//mul_op1
always @(posedge clk) begin
	if (!rst_b) // reset
		op1_wea <= 1'b0;
	else if (state_tmp == 3) //INV GEN
		op1_wea <= inv_ctrl_op1_wea;		
	else 
		op1_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op1_addra <= 0;
	else if (state_tmp == 3) //INV GEN
		op1_addra <= inv_ctrl_op1_addra;		
	else 
		op1_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op1_dina <= 0;
	else if (state_tmp == 3) //INV GEN
		op1_dina <= inv_ctrl_op1_douta;		
	else 
		op1_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op1_web <= 1'b0;	
	else if (state_tmp == 3) //INV GEN
		op1_web <= inv_ctrl_op1_web;	
	else 
		op1_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op1_addrb <= 0;	
	else if (state_tmp == 3) //INV GEN
		op1_addrb <= inv_ctrl_op1_addrb;	
	else 
		op1_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		op1_dinb <= 0;	
	else if (state_tmp == 3) //INV GEN
		op1_dinb <= inv_ctrl_op1_doutb;
	else 
		op1_dinb <= 0;
end

//mul_re
always @(posedge clk) begin
	if (!rst_b) // reset
		re_wea <= 1'b0;
	else if (state_tmp == 2) //SPA2DSN GEN
		re_wea <= spa2dsn_h0_bk_wea;
	else if (state_tmp == 3) //INV GEN
		re_wea <= inv_ctrl_re_wea;		
	else 
		re_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		re_addra <= 0;
	else if (state_tmp == 2) //SPA2DSN GEN
		re_addra <= spa2dsn_h0_bk_addra;
	else if (state_tmp == 3) //INV GEN
		re_addra <= inv_ctrl_re_addra;
	else 
		re_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		re_dina <= 0;
	else if (state_tmp == 2) //SPA2DSN GEN
		re_dina <= spa2dsn_h0_bk_douta;	
	else if (state_tmp == 3) //INV GEN
		re_dina <= inv_ctrl_re_douta;
	else 
		re_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		re_web <= 1'b0;
	else if (state_tmp == 3) //INV GEN
		re_web <= inv_ctrl_re_web;	
	else 
		re_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		re_addrb <= 0;
	else if (state_tmp == 3) //INV GEN
		re_addrb <= inv_ctrl_re_addrb;	
	else 
		re_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		re_dinb <= 0;
	else if (state_tmp == 3) //INV GEN
		re_dinb <= inv_ctrl_re_doutb;
	else 
		re_dinb <= 0;
end



always @(posedge clk) begin
	if (!rst_b) // reset
		f_wea <= 1'b0;
	else if (state_tmp == 4) //F_GEN
		f_wea <= mul_ctrl_f_wea;	
	else 
		f_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		f_addra <= 0;
	else if (state_tmp == 4) //F_GEN
		f_addra <= mul_ctrl_f_addra;	
	else 
		f_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		f_dina <= 0;
	else if (state_tmp == 4) //F_GEN
		f_dina <= mul_ctrl_f_douta;	
	else 
		f_dina <= 0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		state_tmp <= 0;
	else
		state_tmp <= state;
end


assign h0_out = op0_douta[0];
assign h1_out = op1_douta[0];
assign f_out = f_douta[0];



endmodule
