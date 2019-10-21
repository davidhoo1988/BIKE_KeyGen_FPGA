`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2019 10:17:14
// Design Name: 
// Module Name: mul_ctrl
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


module mul_ctrl
#(  parameter 					r = 10163,
	parameter					G_DAT_DEP = 159,
	parameter                   G_ADDR_W = 8,
    parameter                   G_DAT_W = 64,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14,
    parameter					H_DAT_DEP = 71)
(
	input						clk,
	input 						rst_b,
	input 						start,
	output reg 					done,

	output reg [G_ADDR_W-1:0]	g_addra,
	output reg 					g_wea,
	output reg [G_DAT_W-1:0]	g_douta,
	input      [G_DAT_W-1:0]	g_dina, 
	output reg [G_ADDR_W-1:0]	g_addrb,
	output reg 					g_web,
	output reg [G_DAT_W-1:0]	g_doutb,
	input      [G_DAT_W-1:0]	g_dinb,

	output reg [H_ADDR_W-1:0]	h_addra,
	output reg 					h_wea,
	output reg [H_DAT_W-1:0]	h_douta,
	input      [H_DAT_W-1:0]	h_dina, 

	output reg [G_ADDR_W-1:0]	f_addra,
	output reg 					f_wea,
	output reg [G_DAT_W-1:0]	f_douta,
	input      [G_DAT_W-1:0]	f_dina

    );

wire [H_DAT_W-1:0] h_dina_inv;
wire [5:0] offset, offset2;
wire [G_DAT_W-7:0] base;

reg [3:0] cnt;
reg h_flag;
reg [5:0] offset_reg,offset_reg2;

reg [2*G_DAT_W-1:0] rotate;

reg g_rd_done;
reg ld_done;
reg rot_done;
reg [1:0] f_wr_done;

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				READ_H = 3'd1, // read an entry from the sparse polynomial h
				READ_G = 3'd2, //read an entry from the dense polynomial g
				LOAD = 3'd3, //load the corresponding entrys from g
				ROTATE = 3'd4,
				ADD = 3'd5,
				WRITE_F = 3'd6;

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
                next_state = READ_H;
            else
                next_state = INIT;  

        READ_H:
        	if (cnt == 2)
                next_state = READ_G;  
            else 
            	next_state = READ_H;          

        READ_G:
        	if (g_rd_done)
        		next_state = LOAD;
        	else 
        		next_state = READ_G;	

        LOAD:	
        	if (ld_done)
        		next_state = ROTATE;
        	else 
        		next_state = LOAD;

        ROTATE:
        	if (rot_done)
        		next_state = ADD;
        	else 
        		next_state = ROTATE;
        		
        ADD:
        	next_state = WRITE_F;

        WRITE_F:
        	if (done)
        		next_state = INIT;
        	else if (h_flag)
        		next_state = READ_H;	
        	else 
        		next_state = ROTATE;

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
			g_rd_done <= 0;
			ld_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;
			h_flag <= 0;

			cnt <= 0;
			offset_reg <= 0;
			offset_reg2 <= 0;

			rotate <= {2*G_DAT_W{1'b0}};

			g_addra <= 0;
			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};
			g_addrb <= 0;
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end

		READ_H: begin
			done <= 0;
			g_rd_done <= 0;
			ld_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;
			h_flag <= 0;

			if (cnt != 2)
				cnt <= cnt + 1;
			else 
				cnt <= 0;	
			offset_reg <= offset_reg;
			offset_reg2 <= offset_reg2;

			rotate <= {2*G_DAT_W{1'b0}};

			g_addra <= 0;
			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};
			g_addrb <= 0;
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			h_addra <= h_addra;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};			
		end

		READ_G: begin
			done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;
			h_flag <= 0;
			if (!g_rd_done)
				cnt <= cnt + 1'd1;
			else 
				cnt <= 0;	
			offset_reg <= offset;
			offset_reg2 <= offset;

			rotate <= {2*G_DAT_W{1'b0}};

			if (base == G_DAT_DEP - 2 && cnt == 0 && offset_reg > 50) begin //if exception occurs
				g_addra <= base;
				g_addrb <= base + 1'd1;
				g_rd_done <= 0;
				ld_done <= 0;
			end
			else if (base == G_DAT_DEP - 2 && cnt == 1 && offset_reg > 50) begin //if exception occurs
				g_addra <= base + 1'd1;
				g_addrb <= 0;
				g_rd_done <= 1;
				ld_done <= 0;
			end
			else  if (cnt == 0) begin
				g_addra <= base;
				g_addrb <= base == G_DAT_DEP - 1 ? 0 : base + 1'd1;
				g_rd_done <= 0;
				ld_done <= 0;
			end
			else begin
				g_addra <= base;
				g_addrb <= base == G_DAT_DEP - 1 ? 0 : base + 1'd1;
				g_rd_done <= 1;
				ld_done <= 0;
			end

			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			h_addra <= h_addra;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};			
		end

		LOAD: begin
			done <= 0;
			g_rd_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;
			h_flag <= 0;
			if (ld_done)
				offset_reg <= g_addra == 0 ? offset2 : offset;
			else 
				offset_reg <= offset_reg;	
			offset_reg2 <= offset_reg2;

			if (ld_done)
				cnt <= 0;
			else 
				cnt <= cnt + 1'b1;	
			
			if (base == G_DAT_DEP - 2 && cnt == 0 && offset_reg > 50) begin
				rotate <= {g_dina,g_dinb[G_DAT_W-1:G_DAT_W-51],13'd0};
				ld_done <= 1;
			end
			else if (base == G_DAT_DEP - 2 && cnt == 1 && offset_reg > 50) begin
				rotate <= {rotate[2*G_DAT_W-1:2*G_DAT_W-115],g_dinb[G_DAT_W-1:G_DAT_W-13]};
				ld_done <= 0;	
			end	
			else if (base == G_DAT_DEP - 1) begin
				rotate <= {g_dina[G_DAT_W-1:G_DAT_W-51],g_dinb,13'b0};
				ld_done <= 1;
			end
			else begin
				rotate <= {g_dina,g_dinb};
				ld_done <= 1;
			end

			if (cnt == 0) begin
				h_addra <= h_addra;	
				g_addra <= g_addra != G_DAT_DEP - 1 ? g_addra + 1'd1 : 0;
				g_addrb <= g_addrb != G_DAT_DEP - 1 ? g_addrb + 1'd1 : 0;
			end
			else begin
				h_addra <= h_addra;
				g_addra <= g_addra;
				g_addrb <= g_addrb;
			end

			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end

		ROTATE: begin
			done <= 0;
			g_rd_done <= 0;
			ld_done <= 0;
			f_wr_done <= 0;
			h_flag <= h_flag;
			
			if (cnt == 5)
				cnt <= 0;
			else	
				cnt <= cnt + 1;

			if (cnt == 4)
				rot_done <= 1;
			else 
				rot_done <= 0;	

			if (cnt == 0 && offset_reg2[0])
				rotate <= {rotate[2*G_DAT_W-2:0],1'b0};
			else if (cnt == 1 && offset_reg2[1])
				rotate <= {rotate[2*G_DAT_W-3:0],2'b0};
			else if (cnt == 2 && offset_reg2[2])
				rotate <= {rotate[2*G_DAT_W-5:0],4'b0};
			else if (cnt == 3 && offset_reg2[3])
				rotate <= {rotate[2*G_DAT_W-9:0],8'b0};
			else if (cnt == 4 && offset_reg2[4])
				rotate <= {rotate[2*G_DAT_W-17:0],16'b0};
			else if (cnt == 5 && offset_reg2[5])
				rotate <= {rotate[2*G_DAT_W-33:0],32'b0};
			else 
				rotate <= rotate;	

			
			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};			
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			if (cnt == 2 && h_flag) begin //get data from mem_h
				h_addra <= h_addra;
				g_addra <= base;
				g_addrb <= base + 1'd1 == G_DAT_DEP ? 0 : base + 1'd1;
				offset_reg <= offset; 
				offset_reg2 <= offset_reg2;
			end
			else if (cnt == 3 && base == G_DAT_DEP - 2 && offset_reg > 50 && h_flag) begin //exception
				h_addra <= h_addra;
				g_addra <= base + 1'b1;
				g_addrb <= 0;
				offset_reg <= offset_reg;
				offset_reg2 <= offset_reg2;
			end
			else if (cnt == 3 && g_addra == G_DAT_DEP - 2 && offset_reg > 50) begin //exception
				h_addra <= h_addra;
				g_addra <= G_DAT_DEP - 1;
				g_addrb <= 0;
				offset_reg <= offset_reg;
				offset_reg2 <= offset_reg2;
			end
			else begin
				h_addra <= h_addra;
				g_addra <= g_addra;
				g_addrb <= g_addrb;
				offset_reg <= offset_reg;
				offset_reg2 <= offset_reg2;
			end

			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= f_addra;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};	
		end

		ADD: begin
			if (h_addra == H_DAT_DEP-1'b1 && f_addra == G_DAT_DEP-1'b1) 
				done <= 1;
			else
				done <= 0;	
			g_rd_done <= 0;
			ld_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;	

			offset_reg <= offset_reg;
			offset_reg2 <= offset_reg2;
			cnt <= 0;

			if (g_addra == G_DAT_DEP-1 && offset_reg > 50) //get data from mem_g, exception mode
				rotate <= {g_dina,g_dinb[G_DAT_W-1:G_DAT_W-51],13'd0};
			else if (g_addra == G_DAT_DEP-1 && (offset_reg < 50 || offset_reg == 50))
				rotate <= {g_dina[G_DAT_W-1:G_DAT_W-51],g_dinb,13'd0};
			else 	
				rotate <= {g_dina,g_dinb};	


			g_addra <= g_addra;
			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};
			g_addrb <= g_addrb;
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};
			if (f_addra == G_DAT_DEP-1) begin
				h_addra <= h_addra + 1;
				h_flag <= 1; //new h should be used
			end				
			else begin
				h_addra <= h_addra;	
				h_flag <= 0;
			end

			f_addra <= f_addra;
			f_wea <= 1;
			f_douta <= f_addra != G_DAT_DEP-1 ? f_dina ^ rotate[2*G_DAT_W-1:2*G_DAT_W-G_DAT_W] : {f_dina[G_DAT_W-1:G_DAT_W-51] ^ rotate[2*G_DAT_W-1:2*G_DAT_W-51],13'b0};
		end

		WRITE_F: begin	
			done <= 0;	
			g_rd_done <= 0;
			ld_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;

			if (g_addra == G_DAT_DEP-1) begin
				offset_reg <= offset2;	
				offset_reg2 <= offset_reg;			
			end
			else begin
				offset_reg <= offset_reg;
				offset_reg2 <= offset_reg;
			end	
			

			cnt <= 0;			
			if (g_addra == G_DAT_DEP-1 && offset_reg > 50)//get data from mem_g, exception mode
				rotate <= {rotate[2*G_DAT_W-1:2*G_DAT_W-115],g_dinb[G_DAT_W-1:G_DAT_W-13]};
			else 
				rotate <= rotate;	

			g_addra <= g_addra != G_DAT_DEP - 1 ? g_addra + 1'd1 : 0;
			g_wea <= 0;
			g_douta <= {G_DAT_W{1'b0}};
			g_addrb <= g_addrb != G_DAT_DEP - 1 ? g_addrb + 1'd1 : 0;
			g_web <= 0;
			g_doutb <= {G_DAT_W{1'b0}};	

			
			h_wea <= 0;
			h_addra <= h_addra;	
			h_douta <= {H_DAT_W{1'b0}};
			h_flag <= h_flag;

			if (f_addra != G_DAT_DEP-1)
				f_addra <= f_addra + 1'b1;
			else 
				f_addra <= 0;	
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};	
		end

	endcase
end

assign h_dina_inv = h_dina == 0 ? 0 : r - h_dina;
assign base = h_dina_inv[H_DAT_W-1:6];
assign offset = h_dina_inv[5:0];
assign offset2 = offset > 50 ? offset-51 : offset+13; 

endmodule
