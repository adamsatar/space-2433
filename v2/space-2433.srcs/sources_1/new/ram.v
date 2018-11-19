`timescale 1ns / 1ps
module ram #(parameter DATA_WIDTH = 6'd8, DATA_DEPTH = 16'd4096,  filepath = "", ADDR_BITS = 0)

    (
        input [ADDR_BITS -  1'b1 : 0] addra,
        output reg [7:0] dout
    );
    
    reg [DATA_WIDTH - 1'b1:0] ram [0:DATA_DEPTH - 1'b1];
    
    initial begin
//        $readmemh("/home/adam/ece433_repo/ece433-pong/extras/ship_64x64_hex.data",ram,0,DATA_DEPTH - 1'b1);
             $readmemh(filepath,ram,0,DATA_DEPTH - 1'b1);

    end
    
    always @(*)
    begin
        dout <= ram[addra];
    end

  
endmodule
