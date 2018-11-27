`timescale 1ns / 1ps
//Adam Satar
//11.7.18
//ece433 pong
//module for the ship game entity graphical display

module ship_unit(	
				input clk,reset,
				input [9:0] x,
				input [9:0] y,
				input [9:0] ship_x, //from game module where rot/rotb update these
				input[9:0] ship_y,
				input move_right,
				input move_left,
				
//				input [9:0] p1_ship_x, //from game module where rot/rotb update these
//				input[9:0] p1_ship_y,
//				
//				
			
			//	output[7:0] monster_color,
				output reg [7:0] ship_color
//				output reg  [7:0] p1_ship_color
				//input rota,
				//input rotb,
    );
	 
	 

//ship gfx 
reg [5:0] ship_col,ship_row;	 	 
wire [7:0] ship_data, monster_data;
//reg [11:0] ship_addra;	
wire [9:0] ship_addra;



	//reg [5:0] ship_line_number, ship_pixel_number;

 localparam [9:0] ship_y_offset = 64;
	 //active x,y video regions
 localparam [9:0]	  av_x = 640;
 localparam [9:0]  av_y = 480;
	
	 //image file dimensions
	 localparam [9:0] ship_x_pixels = 64;
	 localparam [9:0] ship_y_pixels = 64;

	 localparam ship_x0 = (av_x/2 - ship_x_pixels/2); 
    localparam ship_y0 = av_y - ship_y_offset; 


//reg [9:0]ship_x,ship_y;

//ship movement
//ship movement

//always @(posedge clk or posedge reset) begin
	
//	if(reset == 1'b1) 
//	begin
//		ship_x <= ship_x0;
//		ship_y <= ship_y0;

//	end
//	else if(move_right == 1'b1)
//		begin
////move right
////	if(quadAr[2] ^ quadBr[1]) begin
//		//if(ship_x < 508)        // make sure the value doesn't overflow
//		if(ship_x < (av_x - ship_x_pixels - 1'b1))
//			ship_x <= ship_x - 3'd4;
//	end
//	//move left
//	else if (move_left == 1'b1)begin
//		if(ship_x > 0)
//			ship_x <= ship_x + 3'd4;
//	end
//	else begin
//	   ship_x <= ship_x; 
//	   ship_y <= ship_y;
//	end
//end


	//localparam [15:0]ship_pixels = 64;
assign ship_x_range = (x >= ship_x) && (x < ship_x + ship_x_pixels);
assign ship_y_range = (y >= ship_y) && (y < ship_y + ship_y_pixels);
wire [7:0] rgb_data;

always @*
	if(ship_x_range && ship_y_range) 
		ship_color <= rgb_data;
	else 
		ship_color <= 8'd0;
		

always @*
begin
	ship_col = x - ship_x;
	ship_row = y - ship_y;
end

wire [11:0] ship_pixel;

//assign ship_addra = ((ship_line_number)*(ship_x_pixels) + ship_pixel_number);
	assign ship_pixel = {ship_row,ship_col};
	
	
	localparam filepath = "/home/adam/repos/space-2433/extras/ship_64x64_hex.data";
	ram #(.filepath(filepath),.ADDR_BITS(12))
	ship_ram
		(
           .addra(ship_pixel),
           .dout(rgb_data)
        
        );

  endmodule


