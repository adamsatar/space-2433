`timescale 1ns / 1ps
//Adam Satar
//11.1.18
//debounce module with delay timer
module debouncer(
		input clk, reset, input_pulse,
		output reg debounced_output
    );
	 
	 localparam idle_state = 2'b00,
					delay_state = 2'b01,
					transit_state = 2'b10,
					output_state = 2'b11;

reg [1:0] current_state, next_state;

wire time_out, clear_timer;

assign  clear_time = (current_state == delay_state ? 1'b0 : 1'b1);

always @(posedge clk)
	if(reset == 1'b1)
		current_state <= idle_state;
	else 
		current_state <= next_state;
		
always @(current_state)
	case(current_state)
	idle_state:		debounced_output <= 1'b0; //timer cleared
	delay_state: 	debounced_output <= 1'b0; //timer starts
	transit_state: debounced_output <= 1'b0; //timer running
	output_state: 	debounced_output <= 1'b1; //timer finished
	endcase



always@(current_state or input_pulse or time_out)
	case (current_state)
	0:	if (input_pulse == 1'b0) next_state<=idle_state; else next_state<=delay_state;
	1:	if (time_out==1'b0) next_state<=delay_state; else next_state<=transit_state;
	2: if (input_pulse==1'b0) next_state<=idle_state; else next_state<=output_state;
	3:	if (input_pulse==1'b0) next_state<=idle_state; else next_state<=output_state;
	endcase


delay_loop debounce_delay (
    .base_clk(clk), 
    .reset(reset), 
    .time_out(time_out)
    );

	
endmodule
