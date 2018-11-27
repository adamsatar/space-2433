`timescale 1ns / 1ps


module laser_unit(
    
    input clk,  reset, 
    input [9:0] x,y,ship_x,ship_y,
    input shoot,
    
    output reg  [7:0] laser_color

    );
    
    reg[9:0] laser_x, laser_y;
    	 //image file dimensions
    localparam [9:0] laser_x_pixels = 2;
    localparam [9:0] laser_y_pixels = 5;;
   
    localparam [15:0]ship_x_pixels = 64;
   
   reg [9:0] laser_x0,laser_y0;  
   
assign laser_x_range = (x >= laser_x) && (x < laser_x +laser_x_pixels);
assign laser_y_range = (y >= laser_y) && (y < laser_y + laser_y_pixels);

always @*
	if(laser_x_range && laser_y_range) 
		laser_color <= 255;
	else 
		laser_color <= 8'd0;

always @*
    begin
        laser_x0 <=  ship_x + ship_x_pixels/2 - laser_x_pixels/2;
        laser_y0 <= ship_y-laser_y_pixels;
    end




//animation timer
//SYSCLK_MHZ = 7'd100, TARGET_CLK_MHZ
square_wave_gen #(.SYSCLK_MHZ(100000000),.TARGET_CLK_MHZ(100))

 animate_laser_unit (
    .clk(clk), 
    .reset(reset), 
    .start(1'b1),
    .square_wave(animate_laser) 
    );
    

    
   always @(posedge animate_laser or posedge reset)
   if(reset == 1'b1)
   begin
        laser_y <= laser_y0;
        laser_x <= laser_x0;
   end
    
       
  else if(laser_y < 0)
     begin
            laser_y <= laser_y0;
            laser_x <= laser_x0;
    end
    else
        begin
            laser_y <= laser_y - 4'd4;
        end
  
    
endmodule
