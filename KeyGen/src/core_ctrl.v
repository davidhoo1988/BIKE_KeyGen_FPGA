`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2019 19:36:46
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

	input 				g_gen_done,
	input 				h0_gen_done,
	input 				h1_gen_done,
    input               f0_gen_done,
    input               f1_gen_done,

	output [2:0]		current_state,

	output reg			g_gen_start,
	output reg			h0_gen_start,
	output reg			h1_gen_start,
    output reg          f_gen_start
    );

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				G_GEN = 3'd1, //generate one entry of the dense polynomial g
				H0_GEN = 3'd2, //generate one entry of the dense polynomial h0
				H1_GEN = 3'd3, //generate one entry of the dense polynomial h1
                F_GEN = 3'd4;  //generate the resulting dense polynomials f0/f1

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
                next_state = G_GEN;
            else
                next_state = INIT;  

        G_GEN:
            if (g_gen_done)
                next_state = H0_GEN;
            else   
                next_state = G_GEN;  

        H0_GEN:
        	if (h0_gen_done)
        		next_state = H1_GEN;
        	else 
        		next_state = H0_GEN;	

        H1_GEN:
        	if (h1_gen_done)
        		next_state = F_GEN;
        	else 
        		next_state = H1_GEN;

        F_GEN:
            if (f0_gen_done && f1_gen_done)
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
        		g_gen_start = 1;
        	else 
        		g_gen_start = 0;	
        	h0_gen_start = 0;
        	h1_gen_start = 0;
            f_gen_start = 0;
        end

        G_GEN: begin
        	g_gen_start = 0;
        	if (g_gen_done)
        		h0_gen_start = 1;
        	else 
        		h0_gen_start = 0;	
        	h1_gen_start = 0;
            f_gen_start = 0;
        end

        H0_GEN: begin
        	g_gen_start = 0;
        	h0_gen_start = 0;
        	if (h0_gen_done)
        		h1_gen_start = 1;
        	else 
        		h1_gen_start = 0;	
            f_gen_start = 0;
        end

        H1_GEN: begin
        	g_gen_start = 0;
        	h0_gen_start = 0; 
        	h1_gen_start = 0; 
            if (h1_gen_done)
                f_gen_start = 1;
            else 
                f_gen_start = 0;    
        end

        F_GEN: begin
            g_gen_start = 0;
            h0_gen_start = 0; 
            h1_gen_start = 0; 
            f_gen_start = 0;
        end

        default: begin
			g_gen_start = 0;
        	h0_gen_start = 0; 
        	h1_gen_start = 0; 
            f_gen_start = 0;
        end
    endcase
end

assign current_state = state;

endmodule
