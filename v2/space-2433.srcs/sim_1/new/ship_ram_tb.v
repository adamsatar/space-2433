`timescale 1ns / 1ps

module ship_ram_tb;;
    

                    reg clk,reset;
                    reg [9:0] x;
                    reg [9:0] y;
                    reg [9:0] ship_x; //from game module where rot/rotb update these
                    reg[9:0] ship_y;

                    wire [7:0] ship_color;

    
    	// Instantiate the Unit Under Test (UUT)
    ship_unit uut (
        .clk(clk), 
        .reset(reset), 
        .x(x), 
        .y(y), 
        .ship_color(ship_color)
    );

 localparam [9:0] ship_y_offset = 50,
	 //active x,y video regions
	  av_x = 640,
	  av_y = 480;
	  localparam [7:0] 
	 //image file dimensions
	 ship_x_pixels =64,
	 ship_y_pixels = 64;
	
//	localparam [15:0]ship_pixels = ship_x_pixels * ship_y_pixels;
//	 //bottom center
	 localparam [9:0] ship_x0 = (av_x/2 - ship_x_pixels/2),
							ship_y0 = av_y - ship_y_offset; 
    initial begin
     		clk = 0;
    reset = 1;
    x = ship_x0;
    y = ship_y0;
    ship_x =ship_x0;
    ship_y = ship_y0;
        // Wait 100 ns for global reset to finish
    
        
        // Add stimulus here

    end
      
            initial fork
        #2 reset = 0;
    join
    
    always #1 clk = ~clk;
    
    always @(posedge clk) begin
    
        if(y == ship_y0 + ship_y_pixels - 1'b1)
            begin
                y <= ship_y0;
            end
    
        else if(x == ship_x0 + ship_x_pixels - 1'b1) 
            begin
                y <= y + 1;
                x <=ship_x0;
            end
        else x <= x + 1;
            
//if(ypos == ship_y0 + ship_y_pixels) $stop;
        
    end
endmodule
    

