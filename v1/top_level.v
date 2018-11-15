`timescale 1ns / 1ps
//Adam Satar
//11.4.18
//space-2433 top level 
//started as pong for ece 433 at Rose-Hulman, but
//turned into a space-invaders-like game
module top_level(

	input clk, reset, rota, rotb,game_action_button,
							 p1_rota,p1_rotb,shoot_button,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [1:0] b,
    
	
	 
	 output h_sync, v_sync,
	
	 output speaker

    );


wire [9:0] x;
wire [9:0] y;
//wire [2:0]red,green;
//wire [1:0]blue;
wire [7:0] digit0_color,digit1_color;
wire[6:0] score;
reg [3:0] lives;

wire one_second_oneshot;
wire title_screen_on;

wire [7:0] title_color,
			  menu_color,
			  highscore_color,
			  p1_ship_color,
			  ship_color, monster_color,lives_color,laser_color,target_color;			  
wire [7:0] ship_line_number, ship_pixel_number;
wire [9:0] ship_x, ship_y;	

wire [7:0] p1_ship_line_number, p1_ship_pixel_number;		  
wire [9:0] p1_ship_x, p1_ship_y;			



//control the "scene" by changing what's currently displayed
reg [1:0] current_screen,next_screen;
localparam title_screen = 2'd0, 
					  play_screen = 2'd1,
					  game_over_screen = 2'd2,
					  high_score_screen = 2'd3;
					  

debouncer game_action_debouncer (
    .clk(clk), 
    .reset(reset), 
    .input_pulse(game_action_button), 
    .debounced_output(game_action_debounced)
    );

//current_state_logic
always @(posedge clk or posedge reset)
	begin
		if(reset == 1'b1)
			begin
				current_screen <= title_screen; 
				lives <= 4'd4;

			end
		else
			begin
				current_screen <= next_screen;
			end
	end


//next_state logic
always @(*)
	begin
			case(current_screen)
				title_screen: next_screen <=(game_action_debounced ==1'b1) ? play_screen : title_screen;
				play_screen: next_screen <=(lives < 1'b0) ? game_over_screen : play_screen;
				game_over_screen: next_screen<=(game_action_debounced == 1'b1) ? title_screen : game_over_screen;
				//high_score_screen: 
				default: next_screen <= title_screen;
			endcase
	end

//output logic
always @(*)
begin
	
	case(current_screen)
		title_screen: begin 
								r 	 <=  title_color[7:5] | menu_color[7:5];
								g <= title_color[4:2] | menu_color[4:2];
								b  <= title_color[1:0] | menu_color[1:0];
						  end
		
		play_screen:		begin 
								
								r 	 <=  digit0_color[7:5] | digit1_color[7:5] | ship_color[7:5] | lives_color[7:5]
													| p1_ship_color[7:5] | target_color[7:5];
													
								g <= 	digit0_color[4:2] | digit1_color[4:2] | ship_color[4:2] | lives_color[4:2]
													| p1_ship_color[4:2] | laser_color[4:2] | target_color[4:2];
								
								b  <= digit0_color[1:0] | digit1_color[1:0] | ship_color[1:0] | lives_color [1:0]
													| p1_ship_color[1:0] | target_color[1:0];
								end
		
		game_over_screen:begin 
								r 	 <=  title_color[7:5] | menu_color[7:5];
								g <= title_color[4:2] | menu_color[4:2];
								b  <= title_color[1:0] | menu_color[1:0];
								end
						
		high_score_screen:begin 
								r 	 <=  highscore_color[7:5]; 
								g <= highscore_color[4:2];
								b  <= highscore_color[1:0];
								end
		//default: //all 2 bit states defined
	
	endcase
	

end





	 
	 vga_ctrl vga_display_unit (
    .clk(clk), 
    .reset(reset), 
    .h_sync(h_sync), 
    .v_sync(v_sync), 
    .x(x), 
    .y(y)
    );



wire [3:0] game_event;


// Instantiate the module
game_module2018fall gameUnit (
    .x(x), 
    .y(y), 
    .rota(rota), 
    .rotb(rotb), 
	    .p1_rota(p1_rota), 
    .p1_rotb(p1_rotb), 

	 
//    .red(red), 
//    .green(green), 
//    .blue(blue), 
    .reset(reset), 
    .clk(clk), 

	 .score(score), 
//	 .inc_score_signal(inc_score_signal),
//    .game_event(game_event),
//	 .title_screen_on(title_screen_on), 
//    .one_second_oneshot(one_second_oneshot), 
    .ship_x(ship_x), 
    .ship_y(ship_y)
//    .ship_line_number(ship_line_number), 
//    .ship_pixel_number(ship_pixel_number),
//	 
//	 .p1_ship_x(p1_ship_x), 
//    .p1_ship_y(p1_ship_y), 
//    .p1_ship_line_number(p1_ship_line_number), 
//    .p1_ship_pixel_number(p1_ship_pixel_number)
    );



ship_unit ship (
    .clk(clk), 
	 .reset(reset), 
    .x(x), 
    .y(y), 
    .ship_x(ship_x), 
    .ship_y(ship_y), 
    .ship_color(ship_color)

    );

title_screen game_title (
    .clk(clk), 
    .reset(reset), 
    .x(x), 
    .y(y), 
    .title_color(title_color)
    );

	 endmodule
	 
