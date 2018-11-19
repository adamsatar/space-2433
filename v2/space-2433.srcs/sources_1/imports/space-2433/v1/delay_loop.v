`timescale 1ns / 1ps
//delay loop module dependent on SYSCLK or whatever signal drives
//this circuit
module delay_loop #(parameter N_BITS = 6'd32, DELAY_CYCLES = 32'd1)
	(
		input base_clk, reset, 
		output reg time_out
    );

	reg [N_BITS - 1:0] tic_count;
	
	
	always @(posedge base_clk)
		if(reset == 1'b1) tic_count <= 1'b0;
		else if(tic_count == DELAY_CYCLES - 1'b1)
			tic_count <= 1'b0;
		else tic_count <= tic_count + 1'b1;
	
	always @(tic_count)
		if(tic_count == DELAY_CYCLES - 1'b1)
			time_out <= 1'b1;
		else time_out <= 1'b0;


endmodule
