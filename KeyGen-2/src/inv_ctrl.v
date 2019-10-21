`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2019 20:10:28
// Design Name: 
// Module Name: inv_ctrl
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


module inv_ctrl
#(  parameter 					r = 10163,
	parameter               	G_ADDR_W = 8,
    parameter               	G_DAT_W = 64,
    parameter					G_DAT_DEP = 159,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14)
(
	input 						clk,
	input 						rst_b,
	input 						start,
	output reg 					done,

	output reg [G_ADDR_W-1:0]	op0_addra,
	output reg 					op0_wea,
	output reg [G_DAT_W-1:0]	op0_douta,
	input [G_DAT_W-1:0]			op0_dina,
	output reg [G_ADDR_W-1:0]	op0_addrb,
	output reg 					op0_web,
	output reg [G_DAT_W-1:0]	op0_doutb,
	input [G_DAT_W-1:0]			op0_dinb,

	output reg [G_ADDR_W-1:0]	op1_addra,
	output reg 					op1_wea,
	output reg [G_DAT_W-1:0]	op1_douta,
	input [G_DAT_W-1:0] 		op1_dina,
	output reg [G_ADDR_W-1:0]	op1_addrb,
	output reg 					op1_web,
	output reg [G_DAT_W-1:0]	op1_doutb,
	input [G_DAT_W-1:0] 		op1_dinb,

	output reg [G_ADDR_W-1:0]	re_addra,
	output reg 					re_wea,
	output reg [G_DAT_W-1:0]	re_douta,
	input [G_DAT_W-1:0] 		re_dina,
	output reg [G_ADDR_W-1:0]	re_addrb,
	output reg 					re_web,
	output reg [G_DAT_W-1:0]	re_doutb,
	input [G_DAT_W-1:0] 		re_dinb,

	output reg [G_ADDR_W-1:0]	h0_addra,
	output reg 					h0_wea,
	output reg [G_DAT_W-1:0]	h0_douta,
	input [G_DAT_W-1:0] 		h0_dina
	);

reg [H_DAT_W:0]		r_RESULT;
reg [4:0]		cnt;

//declare exp_ctrl 
wire [G_ADDR_W-1:0] 	exp_re_addra;
wire 					exp_re_wea;
wire [G_DAT_W-1:0]		exp_re_douta;

wire [G_ADDR_W-1:0] 	exp_op0_addra;
wire 					exp_op0_wea;
wire [G_DAT_W-1:0]		exp_op0_douta;


//declare mul_ctrl
wire [G_ADDR_W-1:0] 	mul_re_addra;
wire 					mul_re_wea;
wire [G_DAT_W-1:0]		mul_re_douta;
wire [G_ADDR_W-1:0] 	mul_re_addrb;
wire 					mul_re_web;
wire [G_DAT_W-1:0]		mul_re_doutb;

wire [G_ADDR_W-1:0] 	mul_op0_addra;
wire 					mul_op0_wea;
wire [G_DAT_W-1:0]		mul_op0_douta;

wire [G_ADDR_W-1:0] 	mul_op1_addra;
wire 					mul_op1_wea;
wire [G_DAT_W-1:0]		mul_op1_douta;
wire [G_ADDR_W-1:0] 	mul_op1_addrb;
wire 					mul_op1_web;
wire [G_DAT_W-1:0]		mul_op1_doutb;

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				MUL = 3'd1, //dense multiplication
				EXP = 3'd2, //exp two-power-n
				REFRESH = 3'd3; //update op1


reg 			mul_start, exp_start, fresh_done;
wire 			mul_done, exp_done;

//----------------------------------------------------------
//1st always block, sequential state transition
//----------------------------------------------------------
reg    [2:0]   state, next_state;
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
                next_state = EXP;
            else
                next_state = INIT;  

        MUL:
        	if (mul_done)
        		next_state = EXP;
        	else 
        		next_state = MUL;	

        EXP:
        	if (exp_done)
        		next_state = REFRESH; 
        	else 
        		next_state = EXP;

        REFRESH:
        	if (done)
        		next_state = INIT;
        	else if (fresh_done)
        		next_state = MUL;
        	else 
        		next_state = REFRESH;	
  			     			            
        default:
            next_state = INIT;        
    endcase
end


//----------------------------------------------------------
//3rd sequential block, the sequential FSM output
//----------------------------------------------------------	
always @(posedge clk) begin
	case (state)
		INIT: begin
			done <= 0;
			fresh_done <= 0;
			mul_start <= 0;
			if (start)
				exp_start <= 1;
			else 
				exp_start <= 0;	
			cnt <= 1;

			h0_addra <= 0;
			h0_wea <= 0;
			h0_douta <= {G_DAT_W{1'b0}};

			re_addra <= 0; 
			re_wea <= 0; 
			re_douta <= {G_DAT_W{1'b0}}; 
			re_addrb <= 0; 
			re_web <= 0; 
			re_doutb <= {G_DAT_W{1'b0}}; 

			op0_addra <= 0; 
			op0_wea <= 0; 
			op0_douta <= {G_DAT_W{1'b0}}; 

			op1_addra <= 0; 
			op1_wea <= 0; 
			op1_douta <= {G_DAT_W{1'b0}}; 
			op1_addrb <= 0; 
			op1_web <= 0; 
			op1_doutb <= {G_DAT_W{1'b0}}; 
		end

		EXP: begin //mul_re ---> mul_op0
			done <= 0;
			fresh_done <= 0;
			exp_start <= 0;	
			mul_start <= 0;			

			cnt <= cnt;

			h0_addra <= 0;
			h0_wea <= 0;
			h0_douta <= {G_DAT_W{1'b0}};

			if (exp_done) begin
				re_addra <= 0;
				re_wea <= 0;
				re_douta <= {G_DAT_W{1'b0}};
			end
			else begin
				re_addra <= exp_re_addra;
				re_wea <= exp_re_wea;
				re_douta <= exp_re_douta;
			end
			//update the last entry remaining in state 'MUL'
			re_addrb <= mul_re_addrb; 
			re_web <= mul_re_web; 
			re_doutb <= mul_re_doutb;

			op0_addra <= exp_op0_addra;
			op0_wea <= exp_op0_wea;
			op0_douta <= exp_op0_douta;

			op1_addra <= 0; 
			op1_wea <= 0; 
			op1_douta <= {G_DAT_W{1'b0}}; 
			op1_addrb <= 0; 
			op1_web <= 0; 
			op1_doutb <= {G_DAT_W{1'b0}}; 
		end

		REFRESH: begin
			if (cnt == 21)
				done <= 1;
			else 
				done <= 0;	
			if (op1_addra == G_DAT_DEP-3)
				fresh_done <= 1;
			else 
				fresh_done <= 0;	
			exp_start <= 0;	
			if (fresh_done)
				mul_start <= 1;
			else 
				mul_start <= 0;		
			cnt <= cnt;

			op0_addra <= exp_op0_addra;
			op0_wea <= exp_op0_wea;
			op0_douta <= exp_op0_douta;

			op1_addrb <= 0; 
			op1_web <= 0; 
			op1_doutb <= {G_DAT_W{1'b0}}; 

			if (r_RESULT[0] == 1'b0) begin //load h0 to mul_op1
				if (h0_addra != G_DAT_DEP+3)
					h0_addra <= h0_addra + 1'b1;
				else 
					h0_addra <= 0;	
				h0_wea <= 0;
				h0_douta <= {G_DAT_W{1'b0}};	

				re_addra <= 0; 
				re_wea <= 0; 
				re_douta <= {G_DAT_W{1'b0}}; 
				re_addrb <= 0; 
				re_web <= 0; 
				re_doutb <= {G_DAT_W{1'b0}}; 

				if (h0_addra == 3) begin
					op1_addra <= op1_addra; 
					op1_wea <= 1; 
				end 
				else if (h0_addra > 3) begin
					op1_addra <= op1_addra + 1'b1;
					op1_wea <= 1;
				end
				else begin
					op1_addra <= 0; 
					op1_wea <= 0; 
				end
				op1_douta <= h0_dina; 
			end

			else begin //load mul_re to mul_op1
				h0_addra <= 0;
				h0_wea <= 0;
				h0_douta <= {G_DAT_W{1'b0}};	

				if (re_addra != G_DAT_DEP+3)
					re_addra <= re_addra + 1'b1;
				else 
					re_addra <= 0;	 
				re_wea <= 0; 
				re_douta <= {G_DAT_W{1'b0}}; 
				re_addrb <= 0; 
				re_web <= 0; 
				re_doutb <= {G_DAT_W{1'b0}}; 

				if (re_addra == 3) begin
					op1_addra <= op1_addra; 
					op1_wea <= 1; 
				end 
				else if (re_addra > 3) begin
					op1_addra <= op1_addra + 1'b1;
					op1_wea <= 1;
				end
				else begin
					op1_addra <= 0; 
					op1_wea <= 0; 
				end
				op1_douta <= re_dina;
			end
		end

		MUL: begin
			done <= 0;
			fresh_done <= 0;
			mul_start <= 0;	
			if (mul_done) begin
				cnt <= cnt + 1'b1;
				exp_start <= 1;	
			end
			else begin
				cnt <= cnt;
				exp_start <= 0;	
			end
			
			h0_addra <= 0;
			h0_wea <= 0;
			h0_douta <= {G_DAT_W{1'b0}};

			re_addra <= mul_re_addra;
			re_wea <= mul_re_wea;
			re_douta <= mul_re_douta;
			re_addrb <= mul_re_addrb; 
			re_web <= mul_re_web; 
			re_doutb <= mul_re_doutb; 

			op0_addra <= mul_op0_addra;
			op0_wea <= mul_op0_wea;
			op0_douta <= mul_op0_douta;

			op1_addra <= mul_op1_addra; 
			op1_wea <= mul_op1_wea; 
			op1_douta <= mul_op1_douta; 
			op1_addrb <= mul_op1_addrb; 
			op1_web <= mul_op1_web; 
			op1_doutb <= mul_op1_doutb; 
		end
	endcase
end


exp_ctrl exp(
	.clk				(clk),
	.rst_b				(rst_b),
	.start				(exp_start),
	.done 				(exp_done),
	.exp_deg 			(r_RESULT[14:1]),

	.re_addra 			(exp_re_addra),
	.re_wea 			(exp_re_wea),
	.re_douta 			(exp_re_douta),
	.re_dina 			(re_dina),

	.op0_addra 			(exp_op0_addra),
	.op0_wea 			(exp_op0_wea),
	.op0_douta 			(exp_op0_douta),
	.op0_dina			(op0_dina)
	);


dsn_mul_ctrl mul(
	.clk				(clk),
	.rst_b				(rst_b),
	.start				(mul_start),
	.done 				(mul_done),

	.op0_addra 			(mul_op0_addra),
	.op0_wea 			(mul_op0_wea),
	.op0_douta 			(mul_op0_douta),
	.op0_dina			(op0_dina),

	.op1_addra 			(mul_op1_addra),
	.op1_wea 			(mul_op1_wea),
	.op1_douta 			(mul_op1_douta),
	.op1_dina			(op1_dina),
	.op1_addrb 			(mul_op1_addrb),
	.op1_web 			(mul_op1_web),
	.op1_doutb 			(mul_op1_doutb),
	.op1_dinb			(op1_dinb),

	.re_addra 			(mul_re_addra),
	.re_wea 			(mul_re_wea),
	.re_douta 			(mul_re_douta),
	.re_dina 			(re_dina),	
	.re_addrb 			(mul_re_addrb),
	.re_web 			(mul_re_web),
	.re_doutb 			(mul_re_doutb),
	.re_dinb 			(re_dinb)	
	);


always @(*)
  begin
    case (cnt)
      5'd1 : r_RESULT <= {14'd1,1'd0};
      5'd2 : r_RESULT <= {14'd2,1'd1};
      5'd3 : r_RESULT <= {14'd4,1'd1};
      5'd4 : r_RESULT <= {14'd1,1'd0};
      5'd5 : r_RESULT <= {14'd9,1'd1};
      5'd6 : r_RESULT <= {14'd1,1'd0};
      5'd7 : r_RESULT <= {14'd19,1'd1};
      5'd8 : r_RESULT <= {14'd1,1'd0};
      5'd9 : r_RESULT <= {14'd39,1'd1};
      5'd10 : r_RESULT <= {14'd1,1'd0};
      5'd11 : r_RESULT <= {14'd79,1'd1};
      5'd12 : r_RESULT <= {14'd158,1'd1};
      5'd13 : r_RESULT <= {14'd1,1'd0};
      5'd14 : r_RESULT <= {14'd317,1'd1};
      5'd15 : r_RESULT <= {14'd1,1'd0};
      5'd16 : r_RESULT <= {14'd635,1'd1};
      5'd17 : r_RESULT <= {14'd1270,1'd1};
      5'd18 : r_RESULT <= {14'd2540,1'd1};
      5'd19 : r_RESULT <= {14'd5080,1'd1};
      5'd20 : r_RESULT <= {14'd1,1'd0};
      5'd21 : r_RESULT <= {14'd1,1'd0}; //final square op0 <- re*re
      default : r_RESULT <= 0; 
    endcase
  end

/*
always @(posedge clk) begin
	if (!rst_b)
		re_addra <= 0; 
	else if (state == EXP) 
		re_addra <= exp_re_addra;
	else 
		re_addra <= re_addra;	
end

always @(posedge clk) begin
	if (!rst_b)
		re_wea <= 0; 
	else if (state == EXP) 
		re_wea <= exp_re_wea;
	else 
		re_wea <= re_wea;	
end

always @(posedge clk) begin
	if (!rst_b)
		re_douta <= {G_DAT_W{1'b0}}; 
	else if (state == EXP) 
		re_douta <= exp_re_douta;
	else 
		re_douta <= re_douta;	
end



always @(posedge clk) begin
	if (!rst_b)
		op0_addra <= 0; 
	else if (state == EXP) 
		op0_addra <= exp_op0_addra;
	else 
		op0_addra <= op0_addra;	
end

always @(posedge clk) begin
	if (!rst_b)
		op0_wea <= 0; 
	else if (state == EXP) 
		op0_wea <= exp_op0_wea;
	else 
		op0_wea <= op0_wea;	
end

always @(posedge clk) begin
	if (!rst_b)
		op0_douta <= {G_DAT_W{1'b0}}; 
	else if (state == EXP) 
		op0_douta <= exp_op0_douta;
	else 
		op0_douta <= op0_douta;	
end
*/

endmodule
