`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:41:08 11/14/2018 
// Design Name: 
// Module Name:    h_sync_ctrl 
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
module h_sync_ctrl #(parameter AV_X = 10'd640,H_SYNC_PULSE = 7'd95, H_FRONT_PORCH = 5'd25, H_BACK_PORCH = 6'd40)
	 (					 input clk,vga_clk,reset,
						 output line_end,h_sync,
						 output [9:0] x
    );


clked_negative_oneshot h_sync_oneshot (
    .clk(clk), 
    .reset(reset), 
    .input_pulse(vga_clk), 
    .oneshot(next_pixel_oneshot)
    );
	 
localparam X_TOTAL = AV_X + H_SYNC_PULSE + H_FRONT_PORCH + H_BACK_PORCH;
	 
//localparam X_TOTAL = 800;

//ClockedNegativeOneShot PixelClockUnit(PixelClock, PixelClockOneShot, reset, clock);
//assign LineEnd=xcount==EndCount -1'b1;	//reset counter

assign line_end = x == X_TOTAL - 1'b1;

//assign LineEnd = count_done;
//wire [xresolution-1:0] EndCount=SynchPulse+FrontPorch+ActiveVideo+BackPorch;
//synch pulse appears at the end of the line and after front porch to mimic the pong video_timer
//hsync <= ~(xpos > 664 && xpos <= 760);  // active for 95 clocks
assign h_sync = ~(x>=(AV_X+H_FRONT_PORCH)&&x<=(AV_X+H_FRONT_PORCH+H_SYNC_PULSE));

//always@(xcount, SynchPulse, BackPorch, ActiveVideo, FrontPorch)
//always@(xcount) 
//	xposition<=xcount;	//the game circuit does not work if xposition does not run from 0 to 800. JJS

	 
nbit_cntr #(.PARALLEL_LOAD(1'b0),.BITS(6'd32),.INITIAL_COUNT(1'b0),.END_COUNT(X_TOTAL)) //get rid of 800 magic
x_counter(
				 .clk(clk), 
				 .reset(reset), 
				 .condition0(line_end||next_pixel_oneshot), 
				 .condition1(line_end), 
				 .count(x), 
				 .count_done()
			);

endmodule
