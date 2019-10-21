`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2019 11:09:50
// Design Name: 
// Module Name: exp_ctrl
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


module exp_ctrl
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
	output reg					done,
	input [13:0]				exp_deg,

	output reg [G_ADDR_W-1:0]	re_addra,
	output reg 					re_wea,
	output reg [G_DAT_W-1:0]	re_douta,
	input [G_DAT_W-1:0] 		re_dina,

	output reg [G_ADDR_W-1:0]	op0_addra,
	output reg 					op0_wea,
	output reg [G_DAT_W-1:0]	op0_douta,
	input [G_DAT_W-1:0] 		op0_dina
    );

reg [H_DAT_W-1:0] 		r_RESULT;
reg [4:0] 				cnt;		
reg [H_DAT_W-1:0] 		idx;
reg [5:0]					full;

reg [G_DAT_W-1:0]		rotate, data;

wire [5:0] 				offset;
reg [5:0]				offset_reg;
wire [H_DAT_W-1-6:0]	base;

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				RD = 3'd1, //read memory re
				LD = 3'd2, //load data
				ROT = 3'd3, //rotate data
				INS = 3'd4,
				WR = 3'd5; //write op0



reg 			rd_done, rot_done, ins_done;

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
        	if (rd_done)
        		next_state = LD;
        	else 
        		next_state = RD;	

        LD:
        	next_state = ROT;

        ROT:
        	if (rot_done)
        		next_state = INS;
        	else 
        		next_state = ROT;	
        INS:
        	if (ins_done)
        		next_state = WR;
        	else 	
        		next_state = ROT;
       	WR: 
       		if (done)
       			next_state = INIT;
       		else
       			next_state = ROT;
  			     			            
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
			rd_done <= 0;
			rot_done <= 0;
			ins_done <= 0;	

			cnt <= 0;
			idx <= 0;
			full <= 0;
			offset_reg <= 0;

			data <= {G_DAT_W{1'b0}};
			rotate <= {G_DAT_W{1'b0}};

			re_addra <= 0;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};

			op0_addra <= -1;
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};
		end

		RD: begin
			done <= 0;
			rot_done <= 0;
			ins_done <= 0;	

			rotate <= {G_DAT_W{1'b0}};
			data <= {G_DAT_W{1'b0}};
			full <= 0;

			if (cnt == 5)
				cnt <= 0;
			else 
				cnt <= cnt + 1'd1;	

			if (cnt == 4)
				rd_done <= 1;
			else 
				rd_done <= 0;	
			
			if (cnt == 0 && op0_addra != 255) //255 == -1
				idx <= idx + r_RESULT < r ? idx + r_RESULT : idx + r_RESULT - r;
			else 
				idx <= idx;	

			offset_reg <= offset;

			if (cnt == 1)
				re_addra <= base;
			else 
				re_addra <= re_addra;	
			re_wea <= 0;
			re_douta <= 0;

			op0_addra <= op0_addra;	
			op0_wea <= 0;
			op0_douta <= {G_DAT_W{1'b0}};
		end

		LD: begin
			done <= 0;
			rd_done <= 0;
			rot_done <= 0;
			ins_done <= 0;	

			cnt <= 0;
			idx <= idx;
			full <= 0;
			
			offset_reg <= offset_reg;

			data <= {G_DAT_W{1'b0}};
			rotate <= re_dina;//load data to reg rotate

			re_addra <= re_addra;
			re_wea <= re_wea;
			re_douta <= re_douta;

			op0_addra <= op0_addra;
			op0_wea <= 0;
			op0_douta <= 0;
		end

		ROT: begin
			
			if (cnt == 5 && op0_addra != G_DAT_DEP-2 && full == G_DAT_W-1) begin //because op0_addr counts from -1 and thus ends in G_DAT_DEP-2
				ins_done <= 1;
				done <= 0;
			end
			else if (cnt == 5 && op0_addra == G_DAT_DEP-2 && full == 51-1) begin
				ins_done <= 1;
				done <= 1;
			end
			else begin
				ins_done <= 0;	
				done <= 0;
			end	
			rd_done <= 0;
			if (cnt == 4)
				rot_done <= 1;
			else 
				rot_done <= 0;	

			if (cnt == 5)
				cnt <= 0;
			else 
				cnt <= cnt + 1'd1;	
			idx <= idx;
			full <= full;

			data <= data;	

			if (cnt == 0 && offset_reg[0])
				rotate <= {rotate[G_DAT_W-2:0],1'b0};
			else if (cnt == 1 && offset_reg[1])
				rotate <= {rotate[G_DAT_W-3:0],2'b0};
			else if (cnt == 2 && offset_reg[2])
				rotate <= {rotate[G_DAT_W-5:0],4'b0};
			else if (cnt == 3 && offset_reg[3])
				rotate <= {rotate[G_DAT_W-9:0],8'b0};
			else if (cnt == 4 && offset_reg[4])
				rotate <= {rotate[G_DAT_W-17:0],16'b0};
			else if (cnt == 5 && offset_reg[5])
				rotate <= {rotate[G_DAT_W-33:0],32'b0};
			else 
				rotate <= rotate;	

			if (cnt == 0)
				idx <= idx + r_RESULT < r ? idx + r_RESULT : idx + r_RESULT - r;
			else 
				idx <= idx;	

			offset_reg <= offset_reg;

			if (cnt == 1)
				re_addra <= base;
			else 
				re_addra <= re_addra;
			re_wea <= 0;
			re_douta <= 0;

			
			op0_addra <= op0_addra;
			op0_wea <= 0;
			op0_douta <= 0;
		end

		INS: begin
			done <= done;
			rd_done <= 0;
			rot_done <= 0;
			ins_done <= 0;	

			cnt <= 0;
			idx <= idx;
			offset_reg <= offset; 
			full <= full + 1'b1;	
			
			data <= {data[G_DAT_W-2:0], rotate[G_DAT_W-1]}; //insert one bit data
			rotate <= re_dina;

			re_addra <= re_addra;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};

			if (ins_done)
				op0_addra <= op0_addra + 1'b1;
			else 
				op0_addra <= op0_addra;
			op0_wea <= op0_wea;
			op0_douta <= 0;
		end

		WR: begin
			done <= 0;
			rd_done <= 0;
			rot_done <= 0;
			ins_done <= 0;	

			cnt <= 0;
			idx <= idx;
			full <= 0;
			offset_reg <= offset_reg;
			
			data <= {G_DAT_W{1'b0}};
			rotate <= rotate;

			re_addra <= re_addra;
			re_wea <= 0;
			re_douta <= {G_DAT_W{1'b0}};

			op0_addra <= op0_addra;
			op0_wea <= 1'b1;
			if (done)
				op0_douta <= {data[50:0],13'b0};
			else 	
				op0_douta <= data;
		end

	endcase
end


always @(*) //2^-n mod r
  begin
    case (exp_deg)
      14'd1 : r_RESULT <= {14'd5082};
      14'd2 : r_RESULT <= {14'd2541};
      14'd4 : r_RESULT <= {14'd3176};
      14'd9 : r_RESULT <= {14'd2640};
      14'd19 : r_RESULT <= {14'd9054};
      14'd39 : r_RESULT <= {14'd79};
      14'd79 : r_RESULT <= {14'd8202};
      14'd158 : r_RESULT <= {14'd3907};
      14'd317 : r_RESULT <= {14'd4993};
      14'd635 : r_RESULT <= {14'd105};
      14'd1270 : r_RESULT <= {14'd862};
      14'd2540 : r_RESULT <= {14'd1145};
      14'd5080 : r_RESULT <= {14'd10161};
      default : r_RESULT <= 0; 
    endcase
  end


  assign base = idx[H_DAT_W-1:6];
  assign offset = idx[5:0];














endmodule
