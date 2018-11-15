`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:20:16 11/13/2018 
// Design Name: 
// Module Name:    clked_negative_oneshot 
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
module clked_negative_oneshot(
	input clk, reset, input_pulse,
	output reg oneshot
);




parameter state0=0, state1=1, state2=2, state3=3;
reg [1:0] state;

always@(state)
	if(state==state1) oneshot<=1;
	else oneshot<=0;

always @ (posedge clk)
	if(reset==1)	state <= 1; else
	case (state)
	0:	if (input_pulse==1) state<=state0; else state<=state1;
	1:	if (input_pulse==1) state<=state0; else state<=state3;
	2:	state<=state0;
	3:	if (input_pulse==1) state<=state0; else state<=state3;
	endcase
endmodule

