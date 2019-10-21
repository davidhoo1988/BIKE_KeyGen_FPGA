`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:34:57 09/01/2016
// Design Name:   prng_lcg
// Module Name:   Z:/David On My Mac/Dropbox/LW_LDGM_Code/hardware/siggen/src/prng_lcg_tb.v
// Project Name:  siggen
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: prng_lcg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module prng_lcg_tb;
	parameter PERIOD = 10;
	// Inputs
	reg clk;
	reg rst_b;
	reg [1:0] start;
	reg [63:0] prng_t_dat;

	// Outputs
	wire valid;
	wire [63:0] prng_r_dat;

	// Instantiate the Unit Under Test (UUT)
	prng_lcg uut (
		.clk(clk), 
		.rst_b(rst_b), 
		.start(start), 
		.prng_t_dat(prng_t_dat), 
		.valid(valid), 
		.prng_r_dat(prng_r_dat)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_b = 0;
		start = 0;
		prng_t_dat = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst_b = 1;
		start = 2;
		prng_t_dat = 64'd123;
		#20;
		rst_b = 1;
		start = 1;

		#1000;
		start = 2;
		prng_t_dat = 64'd321;

		#20;
		start = 0;
	end

	//-----------assign clk----------------------------------
	initial begin
		forever
			#(PERIOD/2) clk = ~clk;
	end
      
endmodule

