`timescale 1ns / 1ps
//Adam Satar
//11.4.18
//title screen module; contains title screen rom
module title_screen(
	input clk,reset,
				input [9:0] x,
				input [9:0] y,
			//	input [9:0] ship_x, //from game module where rot/rotb update these
				//input[9:0] ship_y,

				output reg [7:0] title_color
    );
 //active x,y video regions
	 localparam av_x = 640;
	 localparam av_y = 480;
	 //image file dimensions
	 
	 localparam title_x_pixels = 512;
     localparam title_y_pixels = 128;
	 localparam title_pixels = title_x_pixels * title_y_pixels;
	 
	 //top left corner of image --> anchor point
	 localparam title_x = (av_x - title_x_pixels)/2;
	 localparam title_y = 8'd40; //offset title 80 pixels from top (arbitrary)
	//y_padding == title_y0
	

assign title_x_range = (x >= title_x) && (x < title_x + title_x_pixels);
assign title_y_range = (y >= title_y) && (y < title_y + title_y_pixels);	 
wire [7:0] rgb_data;

always @*
	if(title_x_range && title_y_range) 
		title_color <= rgb_data;
	else 
		title_color <= 8'd0;
		


reg [8:0] title_col;
reg [6:0] title_row;

always @*
begin
	title_col = x - title_x;
	title_row = y - title_y;
end

wire [15:0] title_pixel;

//assign ship_addra = ((ship_line_number)*(ship_x_pixels) + ship_pixel_number);
	assign title_pixel = {title_row,title_col};
	
parameter filepath = "/home/adam/repos/space-2433/extras/title_512x128_hex.data";
ram #(.filepath(filepath),.DATA_WIDTH(8), .DATA_DEPTH( 65536),.ADDR_BITS(16))
game_title_img (
    .addra(title_pixel), 
    .dout(rgb_data)
    );


endmodule
