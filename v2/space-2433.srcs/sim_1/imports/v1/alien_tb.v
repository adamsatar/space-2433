`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:46:16 11/14/2018
// Design Name:   alien_unit
// Module Name:   /home/adam/repos/space-2433/v1/alien_tb.v
// Project Name:  v1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alien_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alien_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [9:0] x;
	reg [9:0] y;

	// Outputs
	wire [7:0] alien_color;

wire [4:0] alien_x, alien_y;
wire [4:0] alien_row, alien_col;
wire [9:0] alien_pixel;
 

	// Instantiate the Unit Under Test (UUT)
	alien_unit uut (
		.clk(clk), 
		.reset(reset), 
		.x(x), 
		.y(y), 
		.alien_color(alien_color)
	);
assign alien_pixel = uut.alien_pixel;
assign alien_x = uut.alien_x;
assign alien_y = uut.alien_y;	
assign alien_row = uut.alien_row;
assign alien_col = uut.alien_col; 
localparam alien_y0 = 32, alien_x0 = 32,alien_x_pixels = 32, alien_y_pixels = 32;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		x = 0;
		y = 0;

		// Wait 100 ns for global reset to finish
	
        
		// Add stimulus here

	end
      
			initial fork
		#2 reset = 0;
	join
	
	always #1 clk = ~clk;
	
	always @(posedge clk) begin
	
		if(y == alien_y0 + alien_y_pixels - 1'b1)
			begin
				y <= alien_y0;
			end
	
		else if(x == alien_x0 + alien_x_pixels - 1'b1) 
			begin
				y <= y + 1;
				x <=alien_x0;
			end
		else x <= x + 1;
			
//if(ypos == ship_y0 + ship_y_pixels) $stop;
		
	end
endmodule

