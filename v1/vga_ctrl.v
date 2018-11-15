`timescale 1ns / 1ps

module vga_ctrl #(parameter RESOLUTION_BITS = 4'd10, SYS_CLK_MHZ = 7'd100, 
									AV_X = 10'd640, H_SYNC_PULSE = 7'd95, H_FRONT_PORCH = 5'd25, H_BACK_PORCH = 6'd40, 
									AV_Y = 10'd480, V_SYNC_PULSE = 3'd2, V_FRONT_PORCH = 4'd10, V_BACK_PORCH = 5'd29)
									
									
	(
		input clk, reset, 
		output h_sync, v_sync,
		output [RESOLUTION_BITS - 1'b1: 0] x,y
   );
	
	
square_wave_gen vga_clk_unit (
    .clk(clk), 
    .reset(reset), 
    .square_wave(vga_clk)
    );


//wire LineEnd;
// Instantiate the module
h_sync_ctrl #(.AV_X(AV_X),.H_SYNC_PULSE(H_SYNC_PULSE),.H_FRONT_PORCH(H_FRONT_PORCH),.H_BACK_PORCH(H_BACK_PORCH))
h_sync_unit (
		.clk(clk),
    .vga_clk(vga_clk), 
    .reset(reset),
    .line_end(line_end),
	 .h_sync(h_sync),
	.x(x)
    );




//
//hsyncModule2018fall hsyncUnit(H_SYNC_PULSE, H_BACK_PORCH,  AV_X, H_FRONT_PORCH, 
//h_sync, LineEnd, x, vga_clk, reset, clk);
//


//module vsyncModule2018fallTemplate(LineEnd, vSynchPulse, vFrontPorch, Yresolution, 
////vBackPorch, vsync, ypos, reset, clock);
//vsyncModule2018fallTemplate vsyncUnit(LineEnd, V_SYNC_PULSE, V_FRONT_PORCH, AV_Y, 
//V_BACK_PORCH, v_sync, y, reset, clk);

//vsyncModule2018fallTemplate vsyncUnit(line_end, V_SYNC_PULSE, V_FRONT_PORCH, AV_Y, 
//V_BACK_PORCH, v_sync, y, reset, clk);
//


// Instantiate the module
v_sync_ctrl #(.AV_Y(AV_Y),.V_SYNC_PULSE(V_SYNC_PULSE),.V_FRONT_PORCH(V_FRONT_PORCH),.V_BACK_PORCH(V_BACK_PORCH))
v_sync_unit 
	(
			 .clk(clk), 
			 .reset(reset), 
			 .line_end(line_end), 
			 .v_sync(v_sync), 
			.y(y)
	);




/*

h_sync_ctrl #(.AV_Y(AV_Y),.V_SYNC_PULSE(V_SYNC_PULSE),.V_FRONT_PORCH(V_FRONT_PORCH),.V_BACK_PORCH(V_BACK_PORCH))
v_sync_unit (
		.clk(clk),

    .reset(reset)
	 .v_sync(v_sync),
	.y(y)
    );



*/


endmodule

