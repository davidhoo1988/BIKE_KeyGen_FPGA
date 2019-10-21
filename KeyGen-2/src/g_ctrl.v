`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2019 10:29:27
// Design Name: 
// Module Name: g_ctrl
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



module g_ctrl
#(  parameter                   RNG_DAT_W = 64,
    parameter                   G_ADDR_W = 8,
    parameter                   G_DAT_W = 64)

(   input 						clk, 				
	input 						rst_b, 
	input 						start,
    output reg                  done,

	output reg					fifo_rng_rd, // to read FIFO_rng
    input                       fifo_rng_empty,
	input [RNG_DAT_W-1:0]		fifo_rng_din,// dat from FIFO_rng
	output reg [1:0]			rng_start, // to outer RNG

	output reg [G_ADDR_W-1:0]	g_addr,
	output reg 					g_we,
	output reg [G_DAT_W-1:0]	g_dout
	);


reg [1:0] g_addr_sel;
reg [G_ADDR_W-1:0] g_addr_tmp;
always @(posedge clk) begin
    if (~rst_b) // reset
        g_addr_tmp <= 0;
    else if (g_addr_sel == 1) 
        g_addr_tmp <= g_addr_tmp + 1;
    else if (g_addr_sel == 2)
        g_addr_tmp <= 0;    
    else 
        g_addr_tmp <= g_addr_tmp;  
end

always @(posedge clk) begin
    if (~rst_b)
        g_addr <= 0;
    else 
        g_addr <= g_addr_tmp;    
end

reg g_we_tmp;
always @(posedge clk) begin
    if (~rst_b)
        g_we <= 0;
    else 
        g_we <= g_we_tmp;    
end

reg [1:0] rng_start_sel;
always @(posedge clk) begin
    if (~rst_b)
        rng_start <= 0;
    else if (rng_start_sel == 1)
        rng_start <= 1;
    else if (rng_start_sel == 2)
        rng_start <= 2; 
    else 
        rng_start <= 0;           
end


reg hw; //hw < r = 10163 // 1 --- add  2 --- clear  0 --- hold
reg [1:0] hw_sel, hw_sel_tmp;
wire hw_partial, hw_partial2;
always @(posedge clk) begin
    if (~rst_b)
        hw <= 0;
    else if (hw_sel_tmp == 1)
        hw <= hw ^ hw_partial;
    else if (hw_sel_tmp == 2)
        hw <= 0;    
    else 
        hw <= hw;        
end

always @(posedge clk) begin
    if (~rst_b)
        hw_sel_tmp <= 0;
    else     
        hw_sel_tmp <= hw_sel;  
end


//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 2'd0, //do nothing, then get prepared
				WAIT = 2'd1, // wait for an valid entry
				G_GEN = 2'd2; //generate one entry of the dense polynomial g

//----------------------------------------------------------
//1st always block, sequential state transition
//----------------------------------------------------------
reg    [1:0]   state, next_state;
always @ (posedge clk)
	  if (!rst_b)            
			state <= INIT;        
	  else                  
			state <= next_state; 

//----------------------------------------------------------
//2nd always block, combinational condition judgement
//----------------------------------------------------------	
always @(*) begin
    case (state)
        INIT: 
            if (start)
                next_state = WAIT;
            else
                next_state = INIT;  

        WAIT:
            if (~fifo_rng_empty)
                next_state = G_GEN;
            else   
                next_state = WAIT;  
        G_GEN:
        	if (done)
        		next_state = INIT;
        	else 
        		next_state = WAIT;	         
   
        default:
            next_state = INIT;        
    endcase
end


//----------------------------------------------------------
//3rd sequential block, the sequential FSM output
//----------------------------------------------------------	
always @(*) begin
    case (state)
        INIT: begin
        	fifo_rng_rd = 0;
        	if (start)
        		rng_start_sel = 2;
        	else 
        		rng_start_sel = 0;	

        	g_addr_sel = 0;
        	g_we_tmp = 0;
            if (g_addr != 158)
        	   g_dout = fifo_rng_din;
            else 
                g_dout = hw^hw_partial2 == 1'b1 ? fifo_rng_din & ~(64'h1fff) : fifo_rng_din & ~(64'h1fff) ^ 64'h2000; 
            hw_sel = 0;

            done = 0;
        end

        WAIT: begin
        	rng_start_sel = 1;
        	if (~fifo_rng_empty)
        		fifo_rng_rd = 1;
        	else 
        		fifo_rng_rd = 0;	

        	g_addr_sel = 0;
        	g_we_tmp = 0;
        	g_dout = fifo_rng_din;
            hw_sel = 0;

            done = 0;
        end

        G_GEN: begin
        	rng_start_sel = 1;
        	fifo_rng_rd = 0;

        	if (g_addr == 158) begin
        		g_addr_sel = 2;
        		done = 1;
        	end 	
        	else begin
        		g_addr_sel = 1;
        		done = 0;	
        	end		
        	g_we_tmp = 1;
            g_dout = fifo_rng_din;
            hw_sel = 1;
        end

        default: begin
        	fifo_rng_rd = 0;
            rng_start_sel = 0;  

            g_addr_sel = 0;
            g_we_tmp = 0;
            g_dout = 0;
            hw_sel = 0;

            done = 0;
        end
    endcase
end


hw_sum hw_sum(
    .op             (fifo_rng_din),
    .hw             (hw_partial),
    .hw2             (hw_partial2)
    );

endmodule


module hw_sum
#(  parameter               DAT_W = 64)
(
    input [DAT_W-1:0]   op,
    output              hw,
    output              hw2
    );

wire [DAT_W-1:0] tmp, tmp2;

assign tmp[0] = op[0];
assign tmp2[0] = op[0];
generate
  genvar i;
  for (i = 1; i < DAT_W; i = i + 1)
    begin : gen_hw_sum
      assign tmp[i] = op[i] ^ tmp[i-1];
    end
  for (i = 1; i < 51; i = i + 1)
    begin : gen_hw_sum2
      assign tmp2[i] = op[i] ^ tmp2[i-1];
    end
endgenerate 

assign hw = tmp[DAT_W-1];
assign hw2 = tmp2[51-1];
endmodule