`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:26:04 11/14/2018 
// Design Name: 
// Module Name:    alien_unit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alien_unit(
		input clk, reset, 
		input [9:0] x,y,
		output reg [7:0] alien_color
    );
	 
	 reg [4:0] alien_col,alien_row;	 
	 reg [9:0] alien_x,alien_y;
	 
	 
//square_wave_gen #(.SYSCLK_MHZ(31'd100000000), .TARGET_CLK_MHZ(31'd21449672))
//alien_motion_clk (
//    .clk(clk), 
//    .reset(reset), 
//    .square_wave(motion_tic)
//    );
//always @(posedge motion_tic)
//	
//	begin
//		alien_x <= alien_x + 1'b1;
//		alien_y <= alien_y + 1'b1;		
//	end

 localparam 		alien_x0 = 6'd32,
						alien_y0 = 6'd32;
	 //active x,y video regions
 localparam [9:0]	  av_x = 640;
 localparam [9:0]  av_y = 480;
	
	 //image file dimensions
	 localparam [5:0] alien_x_pixels = 32;
	 localparam [5:0] alien_y_pixels = 32;
	
	//localparam [15:0]ship_pixels = 64;
assign alien_x_range = (x >= alien_x) && (x < alien_x + alien_x_pixels);
assign alien_y_range = (y >= alien_y) && (y < alien_y + alien_y_pixels);
wire [7:0] rgb_data;

//always@(posedge reset or posedge motion_tic)
//	if(reset == 1'b1) 
//	begin
//		alien_x <= alien_x0;
//		alien_y <= alien_y0;
//	end
//	else if(motion_tic == 1'b1) 
//	begin
//		if(alien_y > 480)
//			alien_y <= alien_y0;
//			else
//			alien_y <= alien_y + 1'b1;
//	end

always @*
	if(alien_x_range && alien_y_range) 
		alien_color <= rgb_data;
	else 
		alien_color <= 8'd0;
		

always @*
begin
	alien_col = x - alien_x;
	alien_row = y - alien_y;
end

wire [9:0] alien_pixel;

assign alien_pixel = {alien_row,alien_col};
/*alien_rom alien_img (
    .address(alien_pixel), 
    .rgb_data(rgb_data)
    );*/



endmodule
