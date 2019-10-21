`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2019 19:36:46
// Design Name: 
// Module Name: core_ctrl
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


module core_ctrl(
	input 				clk,
	input 				rst_b,
	input 				start,

	input 				h0_gen_done,
	input 				h1_gen_done,
    input               spa2dsn_done,
    input               inv_gen_done,
    input               mul_gen_done,

	output [2:0]		current_state,

	output reg			h0_gen_start,
	output reg			h1_gen_start,
    output reg          spa2dsn_start,
    output reg          inv_gen_start,
    output reg          mul_gen_start
    );

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				H0_GEN = 3'd1, //generate one entry of the sparse polynomial h0
				H1_GEN = 3'd2, //generate one entry of the sparse polynomial h1, concurrently executes spa2dsn
                INV_GEN = 3'd3,//generate the inverse of h0
                F_GEN = 3'd4;//generate the final result h0^{-1}*h1

reg 			done;
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
                next_state = H0_GEN;
            else
                next_state = INIT;  
 

        H0_GEN:
        	if (h0_gen_done)
        		next_state = H1_GEN;
        	else 
        		next_state = H0_GEN;	

        H1_GEN:
        	if (h1_gen_done)
        		next_state = INV_GEN;
        	else 
        		next_state = H1_GEN;  

        INV_GEN:
            if (inv_gen_done)
                next_state = F_GEN;    		
            else 
                next_state = INV_GEN;   

        F_GEN:
            if (mul_gen_done)
                next_state = INIT;
            else 
                next_state = F_GEN;  	         
   
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
        	if (start)
        		h0_gen_start = 1;
        	else 
        		h0_gen_start = 0;	       	
        	h1_gen_start = 0;
            spa2dsn_start = 0;
            inv_gen_start = 0;
            mul_gen_start = 0;
        end

        H0_GEN: begin
        	h0_gen_start = 0;
            inv_gen_start = 0;
            mul_gen_start = 0;
        	if (h0_gen_done) begin
        		h1_gen_start = 1;
                spa2dsn_start = 1;
            end
        	else begin
        		h1_gen_start = 0;
                spa2dsn_start = 0;
            end	
            
        end

        H1_GEN: begin
        	h0_gen_start = 0; 
        	h1_gen_start = 0;  
            spa2dsn_start = 0;
            mul_gen_start = 0;
            if (h1_gen_done)
                inv_gen_start = 1;
            else 
                inv_gen_start = 0;    
        end

        INV_GEN: begin
            h0_gen_start = 0; 
            h1_gen_start = 0; 
            spa2dsn_start = 0;
            inv_gen_start = 0; 
            if (inv_gen_done)
                mul_gen_start = 1; 
            else    
                mul_gen_start = 0;    
        end


        default: begin
        	h0_gen_start = 0; 
        	h1_gen_start = 0; 
            spa2dsn_start = 0;
            inv_gen_start = 0; 
            mul_gen_start = 0;
        end
    endcase
end

assign current_state = state;

endmodule
