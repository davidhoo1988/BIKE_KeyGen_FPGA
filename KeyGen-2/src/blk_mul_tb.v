`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 19:45:13
// Design Name: 
// Module Name: blk_mul_tb
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


module blk_mul_tb(

    );

parameter PERIOD = 10;

	// Inputs
	reg clk;
	reg rst_b;
	reg [63:0] op_a;
	reg [126:0] op_b;

	// Outputs
	wire [7:0] mul_r;


	// Instantiate the Unit Under Test (UUT)
	blk_mul uut(
	.clk 		(clk),
	.rst_b 		(rst_b),

	.op_a_tmp 	(op_a),
	.op_b_tmp 	(op_b),

	.mul_r 		(mul_r)
    );


    initial begin
		// Initialize Inputs
		clk = 0;
		rst_b = 0;

		#100;
        
		// Add stimulus here
		rst_b = 1;
		op_a = 64'h23e65a79baf76f81;
		op_b = 127'h2dca01e3358487132aa4b17208f3f9e5;

		#50;
		op_a = 64'h523322b7ec86433;
		op_b = 127'h4418157f59ad35f41ede7d4e350ae;

		#50;
		op_a = 64'heecda65fcea41a53;
		op_b = 127'hc7355ef2e86bed1542b95e48364829c;

	end

	//-----------assign clk----------------------------------
	initial begin
		forever
			#(PERIOD/2) clk = ~clk;
	end

endmodule
