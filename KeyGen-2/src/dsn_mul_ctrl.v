`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2019 11:55:09
// Design Name: 
// Module Name: dsn_mul_ctrl
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


module dsn_mul_ctrl
#( 
	parameter 					r = 10163,
	parameter               	G_ADDR_W = 8,
    parameter               	G_DAT_W = 64,
    parameter					G_DAT_DEP = 159,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14)
(
	input 						clk,
	input 						rst_b,
	input 						start,
	output reg					done,

	output reg [G_ADDR_W-1:0] 	op0_addra,
	output reg 					op0_wea,
	output reg [G_DAT_W-1:0]	op0_douta,
	input [G_DAT_W-1:0] 		op0_dina,

	output reg [G_ADDR_W-1:0] 	op1_addra,
	output reg 					op1_wea,
	output reg [G_DAT_W-1:0]	op1_douta,
	input [G_DAT_W-1:0] 		op1_dina,
	output reg [G_ADDR_W-1:0] 	op1_addrb,
	output reg 					op1_web,
	output reg [G_DAT_W-1:0]	op1_doutb,
	input [G_DAT_W-1:0] 		op1_dinb,


	output reg [G_ADDR_W-1:0] 	re_addra,
	output reg 					re_wea,
	output reg [G_DAT_W-1:0]	re_douta,
	input [G_DAT_W-1:0] 		re_dina,
	output reg [G_ADDR_W-1:0] 	re_addrb,
	output reg 					re_web,
	output reg [G_DAT_W-1:0]	re_doutb,
	input [G_DAT_W-1:0] 		re_dinb		
    );


reg [7:0] 				cnt;
reg [H_DAT_W-1:0] 		idx;
reg [1:0]				cond; //1 --- diagonal  2 --- upper half    3 --- lower half

reg [3*G_DAT_W-1:0]		data;

reg [G_DAT_W-1:0] 		op_a;
reg [2*G_DAT_W-2:0] 	op_b;
wire [G_DAT_W-1:0]		mul_r;

wire [G_DAT_W-1:0]		add_r;
//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				RD = 3'd1, //read memory re
				LD = 3'd2, //load data
				ROT = 3'd3,
				MUL = 3'd4, //rotate data
				ADD = 3'd5,
				WR = 3'd6, //write op0
				WR_2 = 3'd7;


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
                next_state = RD;
            else
                next_state = INIT;  

        RD:
        	if (cnt == 4)
        		next_state = LD;
        	else 
        		next_state = RD;	

        LD:
        	if (cnt == 1)
        		next_state = ROT;
        	else 
        		next_state = LD;	

        ROT:
        	next_state = MUL;

        MUL:	
        	if (idx == G_DAT_DEP-1)
        		next_state = WR_2;	
        	else 
        		next_state = WR;	
       	
       	WR: 
       		if (cnt == G_DAT_DEP-2-idx)
       			next_state = WR_2;
       		else 	
       			next_state = WR;	

       	WR_2:
       		if (done)
       			next_state = INIT;
       		else
       			next_state = RD;	
 			     			            
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
			idx <= {H_DAT_W{1'b0}};
			cnt <= 0;
			if (start)
				cond <= 1;
			else 
				cond <= 0;	

			data <= {(3*G_DAT_W){1'b0}};

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

			op_a <= {G_DAT_W{1'b0}};
			op_b <= {(2*G_DAT_W-1){1'b0}};
		end

		RD: begin
			done <= 0;
			cond <= cond;
			idx <= idx;
			if (cnt == 4)
				cnt <= 0;
			else 
				cnt <= cnt + 1'b1;

			data <= {(3*G_DAT_W){1'b0}};

			if (cnt == 4 && cond == 2)
				re_addra <= idx;
			else if (cnt == 4)
				re_addra <= 0;	
			else 
				re_addra <= 0;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};
			re_addrb <= 0;
			re_web <= 0;
			re_doutb <= {G_DAT_W{1'b0}};

			if (cnt == 2 && cond == 3)
				op0_addra <= idx;
			else if (cnt == 2)
				op0_addra <= 0;	
			else if (cnt == 3 || cnt == 4)
				op0_addra <= op0_addra + 1;	
			else 
				op0_addra <= 0;	
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};

			if (cond == 1) begin //diagonal, read {n-2,n-1,0} only
				if (cnt == 0) begin
					op1_addra <= G_DAT_DEP-2;
					op1_addrb <= G_DAT_DEP-1;
				end
				else if (cnt == 1) begin
					op1_addra <= G_DAT_DEP-1;
					op1_addrb <= 0;
				end
				else begin
					op1_addra <= op1_addra;
					op1_addrb <= op1_addrb;
				end
			end
			else if (cond == 2) begin //upper half, {0,1} -> {1,2} -> ... -> {n-2,n-1} where idx starts at 1,2,...,n-1
				if (cnt == 0) begin
					op1_addra <= idx-1;
					op1_addrb <= idx;
				end
				else begin
					op1_addra <= op1_addra;	
					op1_addrb <= op1_addrb;	
				end	
			end
			else begin //cond == 3(lower half), {n-3,n-2,n-1} -> {n-4,n-3,n-2} -> ... -> {0,1,2} -> {n-1,0,1} where idx starts at 1,2,...,n-1
				if (cnt == 0) begin
					op1_addra <= idx == G_DAT_DEP-1 ? G_DAT_DEP-1 : G_DAT_DEP-2-idx;
					op1_addrb <= G_DAT_DEP-2-idx+1;
				end
				else if (cnt == 1) begin
					op1_addra <= G_DAT_DEP-2-idx+1;
					op1_addrb <= G_DAT_DEP-2-idx+2;
				end
				else begin
					op1_addra <= op1_addra;	
					op1_addrb <= op1_addrb;	
				end
			end
			op1_wea <= 0;
			op1_douta <= {G_DAT_W{1'b0}};
			op1_web <= 0;
			op1_doutb <= {G_DAT_W{1'b0}};

			op_a <= {G_DAT_W{1'b0}};
			op_b <= {(2*G_DAT_W-1){1'b0}};

		end

		LD: begin
			done <= 0;
			cond <= cond;
			idx <= idx;
			if (cnt == 1)
				cnt <= 0;
			else 
				cnt <= cnt + 1'b1;

			if (cond == 1) begin
				if (cnt == 0)
					data <= {op1_dina,op1_dinb,{G_DAT_W{1'b0}}};
				else 
					data <= {data[3*G_DAT_W-1:2*G_DAT_W-51],op1_dinb,13'b0};	
			end
			else if (cond == 2) begin
				if (cnt == 0)
					data <= {op1_dina,op1_dinb,{G_DAT_W{1'b0}}};
				else 
					data <= data;	
			end
			else begin
				if (cnt == 0 && op1_addra != G_DAT_DEP-1)
					data <= {op1_dina,op1_dinb,{G_DAT_W{1'b0}}};
				else if (cnt == 0 && op1_addra == G_DAT_DEP-1)	
					data <= {op1_dina[G_DAT_W-1:G_DAT_W-51],op1_dinb,{(G_DAT_W+13)*{1'b0}}};
				else if (op1_addra != G_DAT_DEP-1)
					data <= {data[3*G_DAT_W-1:G_DAT_W],op1_dinb};
				else 
					data <= {data[3*G_DAT_W-1:2*G_DAT_W-51],op1_dinb,13'b0};
			end

			
			re_addra <= re_addra + 1'b1;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};

			re_addrb <= 0;
			re_web <= 0;
			re_doutb <= {G_DAT_W{1'b0}};

			op0_addra <= op0_addra + 1'b1;
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};

			op1_addra <= op1_addra;
			op1_wea <= 0;
			op1_douta <= {G_DAT_W{1'b0}};
			op1_addrb <= op1_addrb;
			op1_web <= 0;
			op1_doutb <= {G_DAT_W{1'b0}};

			op_a <= {G_DAT_W{1'b0}};
			op_b <= {(2*G_DAT_W-1){1'b0}};
		end

		ROT: begin
			done <= 0;
			idx <= idx;
			cnt <= 0;
			cond <= cond;	

			data <= data;

			re_addra <= re_addra + 1'b1;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};
			re_addrb <= 0;
			re_web <= 0;
			re_doutb <= {G_DAT_W{1'b0}};

			op0_addra <= op0_addra + 1'b1;
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};

			op1_addra <= op1_addra;
			op1_wea <= 0;
			op1_douta <= {G_DAT_W{1'b0}};
			op1_addrb <= op1_addrb;
			op1_web <= 0;
			op1_doutb <= {G_DAT_W{1'b0}};

			op_a <= op0_dina;
			if (cond == 1)
				op_b <= data[3*G_DAT_W-53:G_DAT_W-51];
			else if (cond == 2)
				op_b <= data[3*G_DAT_W-2:G_DAT_W];
			//else if (cond == 3 && op1_addra == 0)
				//op_b <= data[3*G_DAT_W-40:G_DAT_W-38];		
			else 
				op_b <= data[3*G_DAT_W-53:G_DAT_W-51];	
		end

		MUL: begin
			if (cond == 3 && idx == G_DAT_DEP-1)
				done <= 1;
			else 
				done <= 0;	
			idx <= idx;
			cnt <= 0;
			cond <= cond;	

			data <= {(3*G_DAT_W){1'b0}};

			re_addra <= re_addra + 1'b1;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};
			if (cond == 2 && idx == G_DAT_DEP-1)
				re_addrb <= G_DAT_DEP-2;
			else if (cond == 3 && idx == G_DAT_DEP-1)
				re_addrb <= -1;	
			else 
				re_addrb <= 0;	
			re_web <= 0;
			re_doutb <= {G_DAT_W{1'b0}};

			op0_addra <= op0_addra + 1'b1;
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};

			op1_addra <= op1_addra;
			op1_wea <= 0;
			op1_douta <= {G_DAT_W{1'b0}};
			op1_addrb <= op1_addrb;
			op1_web <= 0;
			op1_doutb <= {G_DAT_W{1'b0}};

			op_a <= op0_dina;
			op_b <= op_b;
		end

		WR: begin
			done <= 0;	
			idx <= idx;
			if (cnt != G_DAT_DEP-2-idx)
				cnt <= cnt + 1'b1;
			else 
				cnt <= 0;	

			cond <= cond;	

			data <= {(3*G_DAT_W){1'b0}};

			re_addra <= re_addra + 1'b1;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};
			if (cnt == 0 && cond == 2)
				re_addrb <= idx;
			else if (cnt == 0)
				re_addrb <= 0;	
			else 
				re_addrb <= re_addrb + 1'b1;	
			re_web <= 1;
			re_doutb <= cond == 1 ? mul_r : add_r;

			op0_addra <= op0_addra + 1'b1;
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};

			op1_addra <= op1_addra;
			op1_wea <= 0;
			op1_douta <= {G_DAT_W{1'b0}};
			op1_addrb <= op1_addrb;
			op1_web <= 0;
			op1_doutb <= {G_DAT_W{1'b0}};

			op_a <= op0_dina;
			op_b <= op_b;
		end

		WR_2: begin
			done <= 0;
			if ((cond == 2 || cond == 3) && idx == G_DAT_DEP-1)
				idx <= 1'b1;
			else 
				idx <= idx + 1'b1;	
			cnt <= 0;	
			if (cond == 1)
				cond <= 2;	
			else if (cond == 2 && idx == G_DAT_DEP-1)
				cond <= 3;	
			else 
				cond <= cond;	

			data <= {(3*G_DAT_W){1'b0}};

			re_addra <= 0;
			re_wea <= 0;
			re_douta <= 0;
			re_addrb <= re_addrb + 1'b1;
			re_web <= 1;
			if (cond == 1)
				re_doutb <= {mul_r[G_DAT_W-1:G_DAT_W-51],13'b0};
			else if (cond == 2)
				re_doutb <= {add_r[G_DAT_W-1:G_DAT_W-51],13'b0};
			else 
				re_doutb <= add_r;		

			op0_addra <= 0;
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};

			op1_addra <= op1_addra;
			op1_wea <= 0;
			op1_douta <= {G_DAT_W{1'b0}};
			op1_addrb <= op1_addrb;
			op1_web <= 0;
			op1_doutb <= {G_DAT_W{1'b0}};

			op_a <= op_a;
			op_b <= op_b;
		end
	endcase
end




blk_mul blk_mul(
	.clk 		(clk),
	.rst_b 		(rst_b),

	.op_a 		(op_a),
	.op_b 		(op_b),

	.mul_r 		(mul_r)
    );

assign add_r = re_dina ^ mul_r;

endmodule
