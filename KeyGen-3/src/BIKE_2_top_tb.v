`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 10:48:46
// Design Name: 
// Module Name: BIKE_2_top_tb
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


module BIKE_2_top_tb(

    );
	parameter PERIOD = 10;

	// Inputs
	reg clk;
	reg rst_b;
	reg start;
	reg [63:0] prng_t_dat;

	// Outputs
	wire g_out;
	wire f0_out;
	wire f1_out;
	

	//inter-connections
	wire [1:0] rng_start;
	wire rng_valid;
	wire [63:0] prng_r_dat;


	// Instantiate the Unit Under Test (UUT)
	BIKE_2_top uut(
	    .clk			(clk),
	    .rst_b			(rst_b),
	    .start 			(start),
		//RNG interface    
	    .rng_valid 		(rng_valid),
	    .rng_in 		(prng_r_dat),
	    .rng_start		(rng_start),
		//memory interface
		.g_out			(g_out),
		.f0_out			(f0_out)
    );

    prng_lcg rng(
		.clk 			(clk),
		.rst_b 			(rst_b),
		.start 			(rng_start), //'1' generate a random number with internal seed state , '2' generate a number via  prng_t_dat as its seed
		.prng_t_dat 	(prng_t_dat), //initial value of LSFR
		.valid 			(rng_valid), 
		.prng_r_dat 	(prng_r_dat)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_b = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst_b = 1;
		start = 0;
		prng_t_dat = 64'd1234;

		#20;
		start = 1;

		#40;
		start = 0;
	end

	//-----------assign clk----------------------------------
	initial begin
		forever
			#(PERIOD/2) clk = ~clk;
	end





endmodule
