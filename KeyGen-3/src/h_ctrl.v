`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2019 20:24:31
// Design Name: 
// Module Name: h_ctrl
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


module h_ctrl
#(  parameter 					r = 11027,
	parameter                   RNG_DAT_W = 64,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14)
(
	input						clk,
	input 						rst_b,
	input 						start,
	output reg 					done,

	output reg 					fifo_rng_rd,
	output reg 					fifo_rng_wr,
	input 						fifo_rng_empty,
	input [RNG_DAT_W-1:0]		fifo_rng_din,
	output reg [1:0]			rng_start,
	
	output reg [H_ADDR_W-1:0]	h_addra,
	output reg 					h_wea,
	output reg [H_DAT_W-1:0]	h_douta,
	input      [H_DAT_W-1:0]	h_dina, 
	output reg [H_ADDR_W-1:0]	h_addrb,
	output reg 					h_web,
	output reg [H_DAT_W-1:0]	h_doutb,
	input      [H_DAT_W-1:0]	h_dinb
    );


wire [H_DAT_W-1:0] rand1, rand2;

reg [5:0] cnt;
reg [6:0] entry_num;


reg [1:0] h_gen_done, h_chk_done;
//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 2'd0, //do nothing, then get prepared
				WAIT = 2'd1, // wait for an valid entry
				H_GEN = 2'd2, //generate one entry of the dense polynomial g
				H_CHK = 2'd3; //check if this entry is duplicate or not

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
                next_state = H_GEN;
            else   
                next_state = WAIT;  

        H_GEN:
        	if (h_gen_done == 1)
        		next_state = H_CHK;
        	else 
        		next_state = H_GEN;	

        H_CHK:	
        	if (done)
        		next_state = INIT;
        	else if (h_chk_done)
        		next_state = WAIT;
        	else 
        		next_state = H_CHK;
        				          
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
			h_gen_done <= 0;
			h_chk_done <= 0;

			cnt <= 0;
			entry_num <= 0;

			fifo_rng_rd <= 0;
			fifo_rng_wr <= 0;
			if (start)
				rng_start <= 1;
			else 
				rng_start <= 0;	

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};
			h_addrb <= 0;
			h_web <= 0;
			h_doutb <= {H_DAT_W{1'b0}};
	
		end

		WAIT: begin
			done <= 0;
			h_gen_done <= 0;
			h_chk_done <= 0;

			cnt <= 0;
			entry_num <= entry_num;

			fifo_rng_wr <= 1;
			rng_start <= 1;
			if (~fifo_rng_empty) 
				fifo_rng_rd <= 1;
			else 
				fifo_rng_rd <= 0;

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};
			h_addrb <= 0;
			h_web <= 0;
			h_doutb <= {H_DAT_W{1'b0}};
		end

		H_GEN: begin
			done <= 0;
			h_chk_done <= 0;

			fifo_rng_rd <= 0;
			fifo_rng_wr <= 1;
			rng_start <= 1;

			entry_num <= entry_num;

			if (cnt == 0) begin
				h_gen_done <= 1; //jump to H_CHK
				cnt <= 0;
			end

			else  begin
				h_gen_done <= 0;
				if (h_gen_done != 0)
					cnt <= 0;
				else 	
					cnt <= cnt + 1'b1;
			end

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};
			h_addrb <= 1;
			h_web <= 0;
			h_doutb <= {H_DAT_W{1'b0}};
		end

		H_CHK: begin
			h_gen_done <= 0;

			fifo_rng_rd <= 0;
			fifo_rng_wr <= 1;
			rng_start <= 1;

			if ( (entry_num != 66 && (h_dina == rand1 || h_dina == rand2 || h_dinb == rand1 || h_dinb == rand2)) || (h_dina == rand1  || h_dinb == rand1) ) begin//violation occurs
			//if (h_dina == rand1 || h_dina == rand2 || h_dinb == rand1 || h_dinb == rand2) begin
				h_chk_done <= 1;
				done <= 0;
				entry_num <= entry_num;
				cnt <= 0;

				h_addra <= 0;
				h_wea <= 0;
				h_douta <= {H_DAT_W{1'b0}};
				h_addrb <= 1;
				h_web <= 0;
				h_doutb <= {H_DAT_W{1'b0}};	
			end	
			else if (cnt == entry_num[6:1]) begin//no violation occurs, write rand1, rand2
				h_chk_done <= 1;
				cnt <= 0;

				if (entry_num == 66) begin
					entry_num <= entry_num + 1'd1;
					done <= 1;

					h_addra <= cnt*2;
					h_wea <= 1;
					h_douta <= rand1;
					h_addrb <= 0;
					h_web <= 0;
					h_doutb <= {H_DAT_W{1'b0}};
				end
				else begin
					entry_num <= entry_num + 2'd2;
					done <= 0;

					h_addra <= cnt*2;
					h_wea <= 1;
					h_douta <= rand1;
					h_addrb <= cnt*2 + 1'b1;
					h_web <= 1;
					h_doutb <= rand2;
				end 			
			end
			else begin
				h_chk_done <= 0;
				entry_num <= entry_num;
				cnt <= cnt + 1'b1;
				done <= 0;	
				if (done || h_chk_done) begin//w/2
					h_addra <= 0;
					h_wea <= 0;
					h_douta <= {H_DAT_W{1'b0}};
					h_addrb <= 1;
					h_web <= 0;
					h_doutb <= {H_DAT_W{1'b0}};	
				end
				else begin
					h_addra <= h_addra + 2;
					h_wea <= 0;
					h_douta <= {H_DAT_W{1'b0}};
					h_addrb <= h_addrb == 69 ? 0 : h_addrb + 2;
					h_web <= 0;
					h_doutb <= {H_DAT_W{1'b0}};	
				end
			end
		end

		default: begin
			done <= 0;
			h_gen_done <= 0;
			h_chk_done <= 0;

			fifo_rng_rd <= 0;
			fifo_rng_wr <= 0;
			rng_start <= 0;	

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};
			h_addrb <= 0;
			h_web <= 0;
			h_doutb <= {H_DAT_W{1'b0}};		
		end
	endcase

end


assign rand1 = fifo_rng_din[H_DAT_W-1:0];
assign rand2 = fifo_rng_din[16+H_DAT_W-1:16];

endmodule