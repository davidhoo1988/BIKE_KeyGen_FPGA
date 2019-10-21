`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2019 09:37:27
// Design Name: 
// Module Name: BIKE_1_top
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
#(  parameter 				r = 11027,
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
	output 					g_out,
	output					f0_out  
    );

//declare core_ctrl
wire 					g_ctrl_done;
wire 					g_ctrl_start;

wire					h0_ctrl_done, h1_ctrl_done;
wire					h0_ctrl_start, h1_ctrl_start;

wire [2:0]				state;	
reg [2:0] 				state_tmp;				

//declare g_ctrl 
wire 					g_ctrl_we;
wire [G_ADDR_W-1:0] 	g_ctrl_addr;
wire [G_DAT_W-1:0] 		g_ctrl_dout;
wire 					g_ctrl_rng_rd;
wire [1:0]				g_ctrl_rng_start;

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

//declare mul_ctrl
wire 					mul0_ctrl_start;
wire 					mul0_ctrl_done;

wire 					mul0_ctrl_g_wea, mul0_ctrl_g_web;
wire [G_ADDR_W-1:0] 	mul0_ctrl_g_addra, mul0_ctrl_g_addrb;
wire [G_DAT_W-1:0] 		mul0_ctrl_g_douta, mul0_ctrl_g_doutb;

wire 					mul0_ctrl_h_wea;
wire [H_ADDR_W-1:0] 	mul0_ctrl_h_addra;
wire [H_DAT_W-1:0] 		mul0_ctrl_h_douta;

wire 					mul0_ctrl_f_wea, mul0_ctrl_f_web;
wire [G_ADDR_W-1:0] 	mul0_ctrl_f_addra, mul0_ctrl_f_addrb;
wire [G_DAT_W-1:0] 		mul0_ctrl_f_douta, mul0_ctrl_f_doutb;

//declare add_ctrl
wire 					add_ctrl_start;
wire 					add_ctrl_done;

wire 					add_ctrl_h_wea;
wire [H_ADDR_W-1:0] 	add_ctrl_h_addra;
wire [H_DAT_W-1:0] 		add_ctrl_h_douta;

wire 					add_ctrl_f_wea;
wire [G_ADDR_W-1:0] 	add_ctrl_f_addra;
wire [G_DAT_W-1:0] 		add_ctrl_f_douta;



//declare fifo_rng
reg 					rng_rd_en;
reg 					rng_wr_en;
wire [G_DAT_W-1:0] 		rng_out;
wire 					rng_empty;
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

//declare mem_g
reg 					g_wea;
reg [G_ADDR_W-1:0]		g_addra;
reg [G_DAT_W-1:0] 		g_dina;
wire [G_DAT_W-1:0]		g_douta;

reg 					g_web;
reg [G_ADDR_W-1:0]		g_addrb;
reg [G_DAT_W-1:0] 		g_dinb;
wire [G_DAT_W-1:0]		g_doutb;


//declare mem_h
reg 					h0_wea, h0_web;
reg [H_ADDR_W-1:0]		h0_addra, h0_addrb;
reg [H_DAT_W-1:0] 		h0_dina, h0_dinb;
wire [H_DAT_W-1:0]		h0_douta, h0_doutb;

reg 					h1_wea, h1_web;
reg [H_ADDR_W-1:0]		h1_addra, h1_addrb;
reg [H_DAT_W-1:0] 		h1_dina, h1_dinb;
wire [H_DAT_W-1:0]		h1_douta, h1_doutb;

//declare mem_f
reg 					f0_wea, f0_web;
reg [G_ADDR_W-1:0]		f0_addra, f0_addrb;
reg [G_DAT_W-1:0] 		f0_dina, f0_dinb;
wire [G_DAT_W-1:0]		f0_douta, f0_doutb;



core_ctrl core_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(start),

	.g_gen_done 			(g_ctrl_done),
	.h0_gen_done			(h0_ctrl_done),
	.h1_gen_done			(h1_ctrl_done),
	.f0_gen_done			(mul0_ctrl_done),
	.add_gen_done 			(add_ctrl_done),

	.current_state 			(state),

	.g_gen_start 			(g_ctrl_start),
	.h0_gen_start 			(h0_ctrl_start),
	.h1_gen_start 			(h1_ctrl_start),
	.f_gen_start			(mul0_ctrl_start),
	.add_gen_start			(add_ctrl_start)
    );

//control logic for generating polynomial g
g_ctrl g_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(g_ctrl_start),
	.done 					(g_ctrl_done),

	.fifo_rng_rd			(g_ctrl_rng_rd),
	.fifo_rng_empty 		(rng_empty),
	.fifo_rng_din			(rng_out),
	.rng_start				(g_ctrl_rng_start),
	
	.g_addr 				(g_ctrl_addr),
	.g_we 					(g_ctrl_we),
	.g_dout 				(g_ctrl_dout)
	);


//control logic for generating polynomial h0,h1
h_ctrl h0_ctrl (
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

h_ctrl h1_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(h0_ctrl_start),
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


mul_ctrl mul0_ctrl (
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(mul0_ctrl_start),
	.done 					(mul0_ctrl_done),

	.g_addra 				(mul0_ctrl_g_addra),
	.g_wea 					(mul0_ctrl_g_wea),
	.g_douta 				(mul0_ctrl_g_douta),
	.g_dina 				(g_douta), 
	.g_addrb 				(mul0_ctrl_g_addrb),
	.g_web 					(mul0_ctrl_g_web),
	.g_doutb 				(mul0_ctrl_g_doutb),
	.g_dinb 				(g_doutb),

	.h_addra 				(mul0_ctrl_h_addra),
	.h_wea 					(mul0_ctrl_h_wea),
	.h_douta 				(mul0_ctrl_h_douta),
	.h_dina 				(h0_douta), 

	.f_addra 				(mul0_ctrl_f_addra),
	.f_wea   				(mul0_ctrl_f_wea),
	.f_douta 				(mul0_ctrl_f_douta),
	.f_dina					(f0_douta)
    );


add_ctrl add_ctrl(
	.clk 					(clk),
	.rst_b 					(rst_b),
	.start 					(add_ctrl_start),
	.done 					(add_ctrl_done),

	.h_addra 				(add_ctrl_h_addra),
	.h_wea 					(add_ctrl_h_wea),
	.h_douta 				(add_ctrl_h_douta),
	.h_dina 				(h1_douta), 

	.f_addra 				(add_ctrl_f_addra),
	.f_wea   				(add_ctrl_f_wea),
	.f_douta 				(add_ctrl_f_douta),
	.f_dina					(f0_douta)
	);


fifo_rng rng (
  .clk 						(clk),                // input wire clk
  .srst 					(1'b0),              // input wire srst
  .din 						(rng_in),                // input wire [63 : 0] din
  .wr_en 					(rng_wr_en),            // input wire wr_en
  .rd_en 					(rng_rd_en),            // input wire rd_en
  .dout 					(rng_out),              // output wire [63 : 0] dout
  .full 					(),              // output wire full
  .empty 					(rng_empty),            // output wire empty
  .data_count 				()  // output wire [3 : 0] data_count
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

// dense polynomial g, r/d=173 addresses
mem_g g (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(g_wea),      // input wire [0 : 0] wea
  .addra 					(g_addra),  // input wire [7 : 0] addra
  .dina 					(g_dina),    // input wire [63 : 0] dina
  .douta 					(g_douta),  // output wire [63 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b1),      // input wire enb
  .web 						(g_web),      // input wire [0 : 0] web
  .addrb 					(g_addrb),  // input wire [7 : 0] addrb
  .dinb 					(g_dinb),    // input wire [63 : 0] dinb
  .doutb 					(g_doutb)  // output wire [63 : 0] doutb
);



// sparse polynomial h0, w/2=67 addresses, each address contains 14-bit data
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

// sparse polynomial h1, w/2=67 addresses, each address contains 14-bit data
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


// final result, dense polynomial f0,f1, r/d=173 addresses, each address contains 64-bit data
mem_g f0 (
  .clka 					(clk),    // input wire clka
  .ena 						(1'b1),      // input wire ena
  .wea 						(f0_wea),      // input wire [0 : 0] wea
  .addra 					(f0_addra),  // input wire [7 : 0] addra
  .dina 					(f0_dina),    // input wire [63 : 0] dina
  .douta 					(f0_douta),  // output wire [63 : 0] douta
  .clkb 					(clk),    // input wire clkb
  .enb 						(1'b0),      // input wire enb
  .web 						(f0_web),      // input wire [0 : 0] web
  .addrb 					(f0_addrb),  // input wire [7 : 0] addrb
  .dinb 					(f0_dinb),    // input wire [63 : 0] dinb
  .doutb 					(f0_doutb)  // output wire [63 : 0] doutb
);



always @(posedge clk) begin
	if (!rst_b) // reset
		rng_rd_en <= 1'b0;
	else if (state == 1) 
		rng_rd_en <= g_ctrl_rng_rd;	
	else 
		rng_rd_en <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_rng_rd_en <= 1'b0;
	else if (state == 2) 
		h0_rng_rd_en <= h0_ctrl_rng_rd;	
	else 
		h0_rng_rd_en <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_rng_rd_en <= 1'b0;
	else if (state == 3) 
		h1_rng_rd_en <= h1_ctrl_rng_rd;	
	else 
		h1_rng_rd_en <= 1'b0;
end

	


always @(posedge clk) begin
	if (!rst_b) // reset
		rng_wr_en <= 1'b0;
	else if (state == 1) 
		rng_wr_en <= rng_valid;
	else 
		rng_wr_en <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_rng_wr_en <= 1'b0;
	else if (state == 2)
		h0_rng_wr_en <= rng_valid && h0_ctrl_rng_wr && rng_in[H_DAT_W-1:0] < r && rng_in[16+H_DAT_W-1:16] < r;	
	else 
		h0_rng_wr_en <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_rng_wr_en <= 1'b0;
	else if (state == 3)
		h1_rng_wr_en <= rng_valid && h1_ctrl_rng_wr && rng_in[H_DAT_W-1:0] < r && rng_in[16+H_DAT_W-1:16] < r;	
	else 
		h1_rng_wr_en <= 1'b0;
end
	

always @(posedge clk) begin
	if (!rst_b) // reset
		rng_start <= 2'b0;
	else if (state == 1) 
		rng_start <= g_ctrl_rng_start;
	else if (state == 2)
		rng_start <= h0_ctrl_rng_start;	
	else if (state == 3)
		rng_start <= h1_ctrl_rng_start;	
	else 
		rng_start <= 2'b0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		g_wea <= 1'b0;
	else if (state_tmp == 1) //G_GEN
		g_wea <= g_ctrl_we;
	else if (state_tmp == 4) //F_GEN	
		g_wea <= mul0_ctrl_g_wea;
	else 
		g_wea <= 1'b0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		g_addra <= 0;
	else if (state_tmp == 1) 
		g_addra <= g_ctrl_addr;
	else if (state_tmp == 4)
		g_addra <= mul0_ctrl_g_addra;	
	else 
		g_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		g_dina <= 0;
	else if (state_tmp == 1) 
		g_dina <= g_ctrl_dout;
	else if (state_tmp == 4)
		g_dina <= mul0_ctrl_g_douta;	
	else 
		g_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		g_web <= 1'b0;
	else if (state_tmp == 4) //F_GEN	
		g_web <= mul0_ctrl_g_web;
	else 
		g_web <= 1'b0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		g_addrb <= 0;
	else if (state_tmp == 4)
		g_addrb <= mul0_ctrl_g_addrb;	
	else 
		g_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		g_dinb <= 0;
	else if (state_tmp == 4)
		g_dinb <= mul0_ctrl_g_doutb;	
	else 
		g_dinb <= 0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		h0_wea <= 1'b0;
	else if (state_tmp == 2) //H0_GEN
		h0_wea <= h0_ctrl_wea;
	else if (state_tmp == 4) //F_GEN
		h0_wea <= mul0_ctrl_h_wea;	
	else 
		h0_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_addra <= 0;
	else if (state_tmp == 2) 
		h0_addra <= h0_ctrl_addra;
	else if (state_tmp == 4)
		h0_addra <= mul0_ctrl_h_addra;	
	else 
		h0_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_dina <= 0;
	else if (state_tmp == 2) 
		h0_dina <= h0_ctrl_douta;
	else if (state_tmp == 4)
		h0_dina <= mul0_ctrl_h_douta;	
	else 
		h0_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_web <= 1'b0;
	else if (state_tmp == 2) 
		h0_web <= h0_ctrl_web;
	else 
		h0_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_addrb <= 0;
	else if (state_tmp == 2) 
		h0_addrb <= h0_ctrl_addrb;
	else 
		h0_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h0_dinb <= 0;
	else if (state_tmp == 2) 
		h0_dinb <= h0_ctrl_doutb;
	else 
		h0_dinb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_wea <= 1'b0;
	else if (state_tmp == 3) 
		h1_wea <= h1_ctrl_wea;
	else if (state_tmp == 5)
		h1_wea <= add_ctrl_h_wea;	
	else 
		h1_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_addra <= 0;
	else if (state_tmp == 3) 
		h1_addra <= h1_ctrl_addra;
	else if (state_tmp == 5)
		h1_addra <= add_ctrl_h_addra;	
	else 
		h1_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_dina <= 0;
	else if (state_tmp == 3) 
		h1_dina <= h1_ctrl_douta;
	else if (state_tmp == 5)
		h1_dina <= add_ctrl_h_douta;	
	else 
		h1_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_web <= 1'b0;
	else if (state_tmp == 3) 
		h1_web <= h1_ctrl_web;
	else 
		h1_web <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_addrb <= 0;
	else if (state_tmp == 3) 
		h1_addrb <= h1_ctrl_addrb;
	else 
		h1_addrb <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		h1_dinb <= 0;
	else if (state_tmp == 3) 
		h1_dinb <= h1_ctrl_doutb;
	else 
		h1_dinb <= 0;
end


always @(posedge clk) begin
	if (!rst_b) // reset
		f0_wea <= 1'b0;
	else if (state_tmp == 4) //F_GEN
		f0_wea <= mul0_ctrl_f_wea;	
	else if (state_tmp == 5)
		f0_wea <= add_ctrl_f_wea;	
	else 
		f0_wea <= 1'b0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		f0_addra <= 0;
	else if (state_tmp == 4) //F_GEN
		f0_addra <= mul0_ctrl_f_addra;	
	else if (state_tmp == 5)
		f0_addra <= add_ctrl_f_addra;	
	else 
		f0_addra <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		f0_dina <= 0;
	else if (state_tmp == 4) //F_GEN
		f0_dina <= mul0_ctrl_f_douta;	
	else if (state_tmp == 5)
		f0_dina <= add_ctrl_f_douta;	
	else 
		f0_dina <= 0;
end

always @(posedge clk) begin
	if (!rst_b) // reset
		state_tmp <= 0;
	else
		state_tmp <= state;
end


assign g_out = g_douta[0];
assign f0_out = f0_douta[0];


endmodule
