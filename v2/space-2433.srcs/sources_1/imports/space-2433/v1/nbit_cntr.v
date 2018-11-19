`timescale 1ns / 1ps
//Adam Satar
//11.13.18
//universal up down counter with parallel load and count_done signal
//outputs the current count value
//takes two 1 bit condition signals and concatenates them to determine the 
//current state
//00 is idle
//01 is count up
//10 is count down
//11 is parallel load
//.PARALLEL_LOAD(1'b0),.BITS(6'd32),.INITIAL_COUNT(1'b0),.END_COUNT(EndCount))
module nbit_cntr #(parameter BITS = 6'd25, INITIAL_COUNT = 25
'd0, END_COUNT = 25'd12, PARALLEL_LOAD = 25'd0)
(	
	input clk,reset,condition0,condition1,
	//input [BITS - 1:0] initial_count, end_count,p_load,
	output reg [BITS - 1: 0] count,
	output reg count_done
);


reg [BITS - 1: 0] next_count;

localparam idle_state = 2'b00, count_up_state = 2'b01, count_down_state = 2'b10, p_load_state = 2'b11;

always @(posedge clk or posedge reset)
	if(reset == 1'b1)
		count <= INITIAL_COUNT;
	else 
		count <= next_count;
		
always @(count or condition0 or condition1)
	case ({condition1, condition0})
		idle_state:			begin next_count <= count; count_done <= 1'b0; end //idle
		count_up_state: 	begin if(count == END_COUNT - 1'b1) begin count_done <= 1'b1; next_count <= 1'b0;end 
									 else begin count_done <= 1'b0; next_count <= count + 1'b1; end //count up
								end
		count_down_state: begin if(count == INITIAL_COUNT) begin count_done <= 1'b1; next_count <= END_COUNT; end
										else begin count_done <= 1'b0; next_count <= count - 1'b1; end //count down
								end
		p_load_state: 		begin next_count <= PARALLEL_LOAD; count_done <= 1'b0; end //parallel load
	endcase 
	
endmodule 








	
 

