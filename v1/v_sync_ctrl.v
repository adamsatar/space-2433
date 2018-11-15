`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:57 11/14/2018 
// Design Name: 
// Module Name:    v_sync_ctrl 
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
//parameter vSynchPulse=10'd2, vFrontPorch=10'd10, vBackPorch=10'd29; //vsynch=520
//////////////////////////////////////////////////////////////////////////////////
module v_sync_ctrl #(parameter AV_Y = 10'd480,V_SYNC_PULSE = 2'd2, V_FRONT_PORCH = 4'd10, V_BACK_PORCH = 5'd29)
	(
				
					input clk, reset, line_end,
					output v_sync,
					output [9:0] y
   );
	 
	 
	 clked_negative_oneshot v_sync_oneshot (
    .clk(clk), 
    .reset(reset), 
    .input_pulse(line_end), 
    .oneshot(next_line_oneshot)
    );

localparam Y_TOTAL = AV_Y + V_SYNC_PULSE + V_FRONT_PORCH + V_BACK_PORCH;


assign frame_end = y == Y_TOTAL - 1'b1;


assign v_sync = ~(y>=(AV_Y+V_FRONT_PORCH)&&y<(AV_Y+V_FRONT_PORCH+V_SYNC_PULSE));

nbit_cntr #(.PARALLEL_LOAD(1'b0),.BITS(6'd32),.INITIAL_COUNT(1'b0),.END_COUNT(Y_TOTAL)) //get  rid of 520 magic
y_counter(
				 .clk(clk), 
				 .reset(reset), 
				 .condition0(frame_end||next_line_oneshot), 
				 .condition1(frame_end), 
				 .count(y), 
				 .count_done()
			);



endmodule
