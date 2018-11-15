`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Adam Satar
//11.5.18
//square wave generator with parameter
//////////////////////////////////////////////////////////////////////////////////
module square_wave_gen #(parameter SYSCLK_MHZ = 7'd1000, TARGET_CLK_MHZ = 5'd250)(
		input clk, reset,
	
		output reg square_wave
    );

reg [15:0] tic_count, half_period;
initial begin 
	half_period <= SYSCLK_MHZ/(TARGET_CLK_MHZ*2);
	//half_period<=500000;
end



always @(posedge clk or posedge reset)
	if(reset == 1'b1) begin tic_count <= 1'b0; square_wave <= 1'b0; end
		else if(tic_count == half_period - 1'b1) 
			begin square_wave <= ~square_wave; tic_count <= 1'b0; end
		else tic_count <= tic_count + 1'b1;

	
endmodule

 
