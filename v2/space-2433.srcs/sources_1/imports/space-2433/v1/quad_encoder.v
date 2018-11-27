`timescale 1ns / 1ps

module quad_encoder(
					input clk,reset,
					rota,rotb,
					
					//output 1 if direction is right/left 
					output reg right_state,
							     left_state
					
    );

reg [2:0] quadAr, quadBr;

always @(posedge reset)
		begin
			quadAr <= 3'd0;
			quadBr <= 3'd0;
			right_state <=  1'b0;
			left_state <=  1'b0;
		end

//update encoder a,b buffers
always @(posedge clk) quadAr <= {quadAr[1:0], rota};
always @(posedge clk) quadBr <= {quadBr[1:0], rotb};
wire [7:0] rgb_data;

always @(*)
	if(quadAr[2] ^ quadAr[1] ^ quadBr[2] ^ quadBr[1])
		begin
				if(quadAr[2] ^ quadBr[1]) //turned right
					begin
						//flag motion right
						right_state <= 1'b1;
						left_state <= 1'b0;
					end
				else //turned left
					begin
						left_state <= 1'b1;
						right_state <= 1'b0;
						//flag motion left
					end
		end
		else begin
		  left_state<= 1'b0;
		  right_state<=1'b0;
		end

endmodule

