`timescale 1ns / 1ps
//Source: http://www.bigmessowires.com/2009/06/21/fpga-pong/
//
// -----------------------------------------------
// updates the ball and paddle positions, and
// determines the output video image
// This is the original game module with Reset being added
// -----------------------------------------------
//Heavily modified by
//Adam Satar
//ece433 pong
//11.1.18
module game_module2018fall(
				input [9:0] x,
				input [9:0] y,
				input rota,
				input rotb,
				
								input p1_rota,
				input p1_rotb,
				
				
				output [2:0] red,
				output [2:0] green,
				output [1:0] blue,
				input reset,
				input clk,
				output reg [6:0] score,
				output reg [2:0] sound_to_play,
				input title_screen_on,
				input one_second_oneshot,
				
				output reg [3:0] game_event,
				output reg [9:0] ship_x, ship_y,
				output reg [7:0] ship_line_number, ship_pixel_number,
				
				
								output reg [9:0] p1_ship_x, p1_ship_y,
				output reg [7:0] p1_ship_line_number, p1_ship_pixel_number,
				
				input inc_score_signal
				);
		

	


always @(posedge clk) 
if (inc_score_signal == 1'b1)
	score <= score + 1'b1;
		
		

		
		
		
		
		
// paddle movement		
reg [8:0] paddlePosition;
reg [2:0] quadAr, quadBr;
always @(posedge clk) quadAr <= {quadAr[1:0], rota};
always @(posedge clk) quadBr <= {quadBr[1:0], rotb};


// SHIP p1		
//reg [8:0] paddlePosition;
reg [2:0] p1_quadAr, p1_quadBr;
always @(posedge clk) p1_quadAr <= {p1_quadAr[1:0], p1_rota};
always @(posedge clk) p1_quadBr <= {p1_quadBr[1:0], p1_rotb};



localparam arena_y_offset = 8'd100;



 localparam ship_y_offset = 64;
	 //active x,y video regions
	 localparam av_x = 640;
	 localparam av_y = 480;
	 //image file dimensions
	//localparam ship_x_pixels = 16;
	//localparam ship_y_pixels = 13;
	localparam ship_x_pixels = 64;
	localparam ship_y_pixels = 64;
	localparam ship_pixels = 4096;
	
	//ship_x_pixels * ship_y_pixels;
	 
//	 //bottom center
	 localparam ship_x0 = (av_x/2 - ship_x_pixels/2); 
    localparam ship_y0 = av_y - ship_y_offset; 
	//y_padding == title_y0






//ship movement

always @(posedge clk or posedge reset) begin
	
	if(reset == 1'b1) 
	begin
		ship_x <= ship_x0;
		ship_y <= ship_y0;
		

		
	//	ship_line_number <= 1'b0;
		//ship_pixel_number <= 1'b0;
	end
	else if(quadAr[2] ^ quadAr[1] ^ quadBr[2] ^ quadBr[1])
		begin
//move right
	if(quadAr[2] ^ quadBr[1]) begin
		//if(ship_x < 508)        // make sure the value doesn't overflow
		if(ship_x < (av_x - ship_x_pixels - 1'b1))
			ship_x <= ship_x - 3'd4;
	end
	//move left
	else begin
	
	//	if(ship_x > 3)        // make sure the value doesn't underflow
	//		ship_x <= ship_x - 3'd4;
	
		if(ship_x > 0)
			ship_x <= ship_x + 3'd4;
	end
end
end


 localparam p1_ship_x_offset = 10'd0;
	 //active x,y video regions
 localparam   p1_av_x = 10'd640;
 localparam  p1_av_y = 10'd480;
	
	 //image file dimensions
	 localparam p1_ship_x_pixels = 10'd32;
	 localparam p1_ship_y_pixels = 10'd32;
	
	localparam p1_ship_pixels = 16'd1024;




	 localparam p1_ship_y0 = (av_y/2 - p1_ship_y_pixels/2); 
    localparam p1_ship_x0 = p1_ship_x_offset;

/////SHIP P1
always @(posedge clk or posedge reset) begin
	
	if(reset == 1'b1) 
	begin

		
				p1_ship_x <= p1_ship_x0;
		p1_ship_y <= p1_ship_y0;
		
	
	end
	else if(p1_quadAr[2] ^ p1_quadAr[1] ^ p1_quadBr[2] ^ p1_quadBr[1])
		begin
//move right aka up
	if(p1_quadAr[2] ^ p1_quadBr[1]) begin

		if(p1_ship_y > arena_y_offset)
			p1_ship_y <= p1_ship_y - 3'd4;
		//else p1_ship_y <= p1_ship_y;
	end
	//move left //aka down
	else begin

		if(p1_ship_y < av_y)
			p1_ship_y <= p1_ship_y + 3'd4;
			//else 
			//p1_ship_y <= p1_ship_y;
	end
end
end


// ball movement	
reg [9:0] ballX;
reg [8:0] ballY;
reg ballXdir, ballYdir;
reg bounceX, bounceY, bounce_paddle;
	
wire endOfFrame = (x == 0 && y == 480);
	

endmodule
