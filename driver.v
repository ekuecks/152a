`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:56 02/23/2017 
// Design Name: 
// Module Name:    driver 
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
module driver(
    // output
    vgaRed, vgaGreen, vgaBlue, Hsync, Vsync,
	 // input
	 clk, btnR, btnL, btnM, btnT, btnD, sw
    );
	output vgaRed;
	output vgaGreen;
	output vgaBlue;
	output Hsync;
	output Vsync;
	
	input clk;
	input btnR;
	input btnL;
	input btnM;
	input btnT;
	input btnD;
	input sw;
	
   wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [1:0] vgaBlue;
	wire Hsync;
	wire Vsync;
	wire clk;
	wire game_clk;
	wire display_clk;
	wire btnR;
	wire btnL;
	wire btnM;
	wire btnT;
	wire btnD;
	
	wire [97:0] grid;
	wire [6:0] location;
	wire [1:0] winner;
	wire term;
	wire sw;
	wire [20:0] column_counts;
	wire [6:0] opt;
	wire move;


   clock_divider clock_divider_(
	  // output
	  .display_clk (display_clk),
	  .debounce_clk (debounce_clk),
	  .game_clk (game_clk),
	  // input
	  .clk (clk)
	);
	
	debounce debounce_(
	  .left (left),
	  .right (right),
	  .middle (middle),
	  .down (down),
	  .rst (rst),
	  //.clk (clk),
	  .debounce_clk (debounce_clk),
	  .btnL (btnL),
	  .btnR (btnR),
	  .btnM (btnM),
	  .btnT (btnT),
	  .btnD (btnD)
	);
	
	select select_(
	  // output
	  .grid (grid),
	  .location (location),
	  // input
	  .term (term),
	  .left (left),
	  .right (right),
	  .middle (middle),
	  .down (down),
	  .clk (game_clk),
	  .sw (sw),
	  .rst  (rst)
	);

   display display_(
	  // output
	  .vgaRed (vgaRed),
	  .vgaGreen (vgaGreen),
	  .vgaBlue (vgaBlue),
	  .Hsync (Hsync),
	  .Vsync (Vsync),
	  // input
	  .clk (game_clk),
	  .display_clk (display_clk),
	  .grid (grid),
	  .winner (winner),
	  .term (term)
	);
	
	terminate terminate_(
	  // output
	  .winner (winner),
	  .term (term),
	  // input
	  .clk (game_clk),
	  .grid (grid),
	  .location (location)
	);

	
endmodule
