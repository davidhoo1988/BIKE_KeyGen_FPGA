module add_ctrl
#(  parameter 					r = 10163,
	parameter					G_DAT_DEP = 159,
	parameter                   G_ADDR_W = 8,
    parameter                   G_DAT_W = 64,
    parameter                   H_ADDR_W = 7,
    parameter                   H_DAT_W = 14,
    parameter					H_DAT_DEP = 67)
(
	input 						clk,
	input 						rst_b,
	input 						start,
	output reg 					done,

	output reg [H_ADDR_W-1:0] 	h_addra,
	output reg 					h_wea,
	output reg [H_DAT_W-1:0] 	h_douta,
	input 	   [H_DAT_W-1:0] 	h_dina, 

	output reg [G_ADDR_W-1:0] 	f_addra,
	output reg 					f_wea,
	output reg [G_DAT_W-1:0]	f_douta,
	input 	   [G_DAT_W-1:0] 	f_dina
	);

wire [5:0] offset;
wire [G_DAT_W-7:0] base;

reg [3:0] cnt;
reg [G_DAT_W-1:0] rotate;


reg f_rd_done;
reg ld_done;
reg rot_done;
reg f_wr_done;

//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		INIT = 3'd0, //do nothing, then get prepared
				READ_H = 3'd1, // read an entry from the sparse polynomial h0
				READ_F = 3'd2, //read an entry from the dense polynomial f0 = gh0
				LOAD = 3'd3, //load the corresponding entries from f0 = gh0
				ROTATE = 3'd4,
				ADD = 3'd5,
				WRITE_F = 3'd6; //write the corresponding entries of f0 = h1 + gh0

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
                next_state = READ_F;  
            else 
            	next_state = READ_H;          

        READ_F:
        	if (cnt == 2)
        		next_state = ROTATE;
        	else 
        		next_state = READ_F;	

        ROTATE:
        	if (rot_done)
        		next_state = WRITE_F;
        	else 
        		next_state = ROTATE;
        		
        WRITE_F:
        	if (done)
        		next_state = INIT;
        	else if (f_wr_done)
        		next_state = READ_H;	
        	else 
        		next_state = WRITE_F;

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
			f_rd_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;

			cnt <= 0;
			rotate <= {G_DAT_W{1'b0}};

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end

		READ_H: begin
			done <= 0;
			f_rd_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;

			if (cnt == 2)
				cnt <= 0;
			else	
				cnt <= cnt + 1'b1;
			rotate <= {G_DAT_W{1'b0}};

			h_addra <= h_addra;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end

		READ_F: begin
			done <= 0;
			f_rd_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;

			if (cnt == 2)
				cnt <= 0;
			else	
				cnt <= cnt + 1'b1;
			rotate <= {64'h8000_0000_0000_0000};

			h_addra <= h_addra;	
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= base;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end

		ROTATE: begin			
			f_rd_done <= 0;
			if (cnt == 5) begin
				if (h_addra == H_DAT_DEP-1)
					done <= 1;
				else 
					done <= 0;	
				f_wr_done <= 1;
			end	
			else begin
				done <= 0;	
				f_wr_done <= 0;	
			end

			if (cnt == 5)
				cnt <= 0;
			else	
				cnt <= cnt + 1'b1;

			if (cnt == 4)
				rot_done <= 1;
			else 
				rot_done <= 0;	

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

			h_addra <= h_addra;	
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= base;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end

		WRITE_F: begin
			done <= 0;
			f_rd_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;

			cnt <= 0;
			rotate <= {G_DAT_W{1'b0}};

			h_addra <= h_addra + 1'b1;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= base;
			f_wea <= 1;
			f_douta <= rotate ^ f_dina;
		end

		default: begin
			done <= 0;
			f_rd_done <= 0;
			rot_done <= 0;
			f_wr_done <= 0;

			cnt <= 0;
			rotate <= {G_DAT_W{1'b0}};

			h_addra <= 0;
			h_wea <= 0;
			h_douta <= {H_DAT_W{1'b0}};

			f_addra <= 0;
			f_wea <= 0;
			f_douta <= {G_DAT_W{1'b0}};
		end
	endcase
end

assign base = h_dina[H_DAT_W-1:6];
assign offset = h_dina[5:0];

endmodule