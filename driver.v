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
	 clk, btnR, btnL, btnM, btnT
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
	
   wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [1:0] vgaBlue;
	wire Hsync;
	wire Vsync;
	wire clk;
	wire display_clk;
	wire btnR;
	wire btnL;
	wire btnM;
	wire btnT;
	
	wire [97:0] grid;
	wire player;

   
	

   clock_divider clock_divider_(
	  // output
	  .display_clk (display_clk),
	  .debounce_clk (debounce_clk),
	  // input
	  .clk (clk)
	);
	
	debounce debounce_(
	  .left (left),
	  .right (right),
	  .middle (middle),
	  .rst (rst),
	  //.clk (clk),
	  .debounce_clk (debounce_clk),
	  .btnL (btnL),
	  .btnR (btnR),
	  .btnM (btnM),
	  .btnT (btnT)
	);
	
	select select_(
	  // output
	  .grid (grid),
	  .player (player),
	  // input
	  .left (left),
	  .right (right),
	  .middle (middle),
	  .clk  (clk)
	);

   display display_(
	  // output
	  .vgaRed (vgaRed),
	  .vgaGreen (vgaGreen),
	  .vgaBlue (vgaBlue),
	  .Hsync (Hsync),
	  .Vsync (Vsync),
	  // input
	  .clk (clk),
	  .display_clk (display_clk),
	  .grid (grid)
	);
endmodule
