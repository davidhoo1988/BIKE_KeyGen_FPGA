//===============================================================================
//                         Pseudo Random Number Generator With LDGM Code Signature
//  ----------------------------------------------------------------------------
//  File Name            : ./auto/prng.v
//  File Revision        : 1.0
//  Author               : David J.W. HU
//  Email                 :davidhoo471494221@gmail.com
//  History:            
//								2016.9		Rev1.0	David 
//  ----------------------------------------------------------------------------
//  Description      : This module is the random number generator of our processor
//						using "Linear Congruent Generator" approach.
						//this->seed = this->seed * 1103515245 + 12345; 	 
						//return (unsigned int)(this->seed/65536) % 32768;
//  ----------------------------------------------------------------------------
//===============================================================================





 module prng_lcg
(
	input wire 					clk,
	input wire 					rst_b,
	input wire 	[1:0]			start, //'1' generate a random number with internal seed state , '2' generate a number via  prng_t_dat as its seed
	input wire 	[63:0]	prng_t_dat, //initial value of LSFR
	output reg 			valid, 
	output reg  [63:0] 	prng_r_dat
);

//----------------------------------------------------------
// Signal Declaration
//---------------------------------------------------------- 
wire 	[126:0]					mul_r, lcg_arith;
wire 	[63:0] 					prng_seed;

reg 							cnt1_sel;
reg 	[3:0]					cnt1;//cnt1 <= 4

//reg 	[1:0] 					cnt2_sel;
//reg 	[3:0] 					cnt2;//cnt2 <= 8

reg 	[1:0]					prng_typ_sel; //'0' hold prng_typ_reg, '1' for updating seed externally, '2' for updating seed internally




//----------------------------------------------------------
// FSM state signal Declaration
//----------------------------------------------------------		
parameter 		ST_PRE = 2'd0, //do nothing, then get prepared
				RNG_GEN = 2'd1; //generate random numbers


//----------------------------------------------------------
//1st always block, sequential state transition
//----------------------------------------------------------
reg    [1:0]   NextState, CurrentState;
always @ (posedge clk)
	  if (!rst_b)            
			CurrentState <= ST_PRE;        
	  else                  
			CurrentState <= NextState; 

//----------------------------------------------------------
//2nd always block, combinational condition judgement
//----------------------------------------------------------		
always @ (*) begin
       case (CurrentState)
			ST_PRE:	begin
							if (start)
								NextState = RNG_GEN;
							else
								NextState = ST_PRE;						
			end
			RNG_GEN: begin
							if(valid)
								NextState = ST_PRE;
							else
								NextState = RNG_GEN;	
			end
			default:
				NextState = ST_PRE;
		endcase
end	

//----------------------------------------------------------
//3rd sequential block, the sequential FSM output
//----------------------------------------------------------		
always @ (*) begin
	case (CurrentState)
		ST_PRE: begin
			cnt1_sel = 0;
			valid = 0;
			if (start == 2)
				prng_typ_sel = 1;
			else
				prng_typ_sel = 0;	
		end	

		RNG_GEN: begin						
			cnt1_sel = 1;
			if (cnt1 == 10) begin
				prng_typ_sel = 2;	
				valid = 0;
			end	
			else if (cnt1 == 11) begin
				prng_typ_sel = 0;	
				valid = 1;
			end
			else begin
				prng_typ_sel = 0;	
				valid = 0;
			end				
		end

		default: begin
			cnt1_sel = 0;
			valid = 0;
			prng_typ_sel = 0;	
		end	

	endcase
end	
//----------------------------------------------------------
// logic computation part
//----------------------------------------------------------							
assign lcg_arith = mul_r + 64'd1442695040888963407;
assign prng_seed = lcg_arith[63:0];


//----------------------------------------------------------
// register part
//----------------------------------------------------------
always @(posedge clk) begin
	if (!rst_b)
		prng_r_dat <= 0;
	else if (prng_typ_sel == 2'd1)
		prng_r_dat <= prng_t_dat;
	else if (prng_typ_sel == 2'd2)
		prng_r_dat <= prng_seed;
	else	
		prng_r_dat <= prng_r_dat;
end

always @(posedge clk) begin
	if (!rst_b)
		cnt1 <= 0;
	else if (cnt1_sel == 1)
		cnt1 <= (cnt1 == 4'd11) ? 4'd0 : cnt1 + 1'd1;
	else
		cnt1 <= 0;		
end

/*always @(posedge clk) begin
	if (!rst_b)
		cnt2 <= 0;
	else if (cnt2_sel == 1)	
		cnt2 <= cnt2 + 1'd1;
	else if (cnt2_sel == 2)
		cnt2 <= 0;	
	else
		cnt2 <= cnt2;	
end*/


//10 cycles delay
mul_64bit multiplier( // 64bit * 63bit(const=6364136223846793005)
	//input
	.CLK			(clk				), 
	.A				(prng_r_dat			),
	//output
	.P				(mul_r				)
);



endmodule
