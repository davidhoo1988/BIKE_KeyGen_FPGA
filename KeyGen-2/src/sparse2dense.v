`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2019 10:51:40
// Design Name: 
// Module Name: sparse2dense
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


module sparse2dense
#(  parameter 					r = 10163,
	parameter               	G_ADDR_W = 8,
    parameter               	G_DAT_W = 64,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14)
(
	input						clk,
	input 						rst_b,
	input 						start,
	output reg 					done,

	output reg [H_ADDR_W-1:0]	h_spa_addra,
	output reg 					h_spa_wea,
	input      [H_DAT_W-1:0]	h_spa_dina, 

	output reg [G_ADDR_W-1:0]	h_dsn_addra,
	output reg 					h_dsn_wea,
	output reg [G_DAT_W-1:0]	h_dsn_douta,
	input      [G_DAT_W-1:0]	h_dsn_dina
    );

wire [H_DAT_W-1-6:0] base;
wire [5:0] offset;

reg rd_done, chg_done;
reg [5:0] cnt;
reg [G_DAT_W-1:0] rotate;

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 2'd0, //do nothing, then get prepared
				RD_H = 2'd1, // read sparse H
				CHG  = 2'd2, // change one entry in sparse H to dense form
				WR_H = 2'd3; // write back dense H

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
                next_state = RD_H;
            else
                next_state = INIT;  

        RD_H:
        	if (rd_done)
            	next_state = CHG;
            else 
            	next_state = RD_H;	

        CHG:
        	if (chg_done)
        		next_state = WR_H;
        	else 
        		next_state = CHG;	

        WR_H:	
        	if (done)
        		next_state = INIT;
        	else 
        		next_state = RD_H;
        				          
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
			h_spa_addra <= 0;
			h_spa_wea <= 0;

			h_dsn_addra <= 0;
			h_dsn_wea <= 0;
			h_dsn_douta <= 0;

			rd_done <= 0;
			chg_done <= 0;
			done <= 0;
			cnt <= 0;
			rotate <= {G_DAT_W{1'b0}};

		end

		RD_H: begin
			if (cnt == 2)
				cnt <= 0;
			else
				cnt <= cnt + 1'b1;

			if (cnt == 1)
				rd_done <= 1;
			else 
				rd_done <= 0;	
			chg_done <= 0;
			done <= 0;

			h_spa_addra <= h_spa_addra;
			h_spa_wea <= 0;

			h_dsn_addra <= 0;
			h_dsn_wea <= 0;
			h_dsn_douta <= 0;

			rotate <= {64'h8000_0000_0000_0000};
		end

		CHG: begin
			if (cnt == 5)
				cnt <= 0;
			else
				cnt <= cnt + 1'b1;

			if (cnt == 4)
				chg_done <= 1;
			else 
				chg_done <= 0;

			rd_done <= 0;
			if (cnt == 5 && h_spa_addra == 70)
				done <= 1;
			else 
				done <= 0;	

			if (cnt == 0 && offset[0])
				rotate <= {1'b0,rotate[G_DAT_W-1:1]};
			else if (cnt == 1 && offset[1])
				rotate <= {2'b0,rotate[G_DAT_W-1:2]};
			else if (cnt == 2 && offset[2])
				rotate <= {4'b0,rotate[G_DAT_W-1:4]};
			else if (cnt == 3 && offset[3])
				rotate <= {8'b0,rotate[G_DAT_W-1:8]};
			else if (cnt == 4 && offset[4])
				rotate <= {16'b0,rotate[G_DAT_W-1:16]};
			else if (cnt == 5 && offset[5])
				rotate <= {32'b0,rotate[G_DAT_W-1:32]};
			else 
				rotate <= rotate;

			h_spa_addra <= h_spa_addra;
			h_spa_wea <= 0;

			h_dsn_addra <= base;
			h_dsn_wea <= 0;
			h_dsn_douta <= 0;			
		end

		WR_H: begin
			if (h_spa_addra == 70)
				h_spa_addra <= 0;
			else 
				h_spa_addra <= h_spa_addra + 1'b1;	
			h_spa_wea <= 0;

			h_dsn_addra <= h_dsn_addra;
			h_dsn_wea <= 1;
			h_dsn_douta <= h_dsn_dina ^ rotate;

			rd_done <= 0;
			chg_done <= 0;
			done <= 0;
			cnt <= 0;
			rotate <= {G_DAT_W{1'b0}};
		end

		default: begin
			h_spa_addra <= 0;
			h_spa_wea <= 0;

			h_dsn_addra <= 0;
			h_dsn_wea <= 0;
			h_dsn_douta <= 0;

			rd_done <= 0;
			chg_done <= 0;
			cnt <= 0;
			rotate <= {G_DAT_W{1'b0}};
		end

	endcase
end


assign base = h_spa_dina[H_DAT_W-1:6];
assign offset = h_spa_dina[5:0];

endmodule
