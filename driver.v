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

   reg [1:0]   arst_ff;
   wire        rst;
   wire        arst_i;

   assign arst_i = btnT;
   assign rst = arst_ff[0];
	
	always @ (posedge clk or posedge arst_i)
   begin
	  if (arst_i)
       arst_ff <= 2'b11;
     else
	  begin
	    arst_ff <= {1'b0, arst_ff[1]};
	  end
   end

	
	reg [5:0]   aleft_ff;
   wire        left;
   wire        aleft_i;

   assign aleft_i = btnL;
   assign left = &aleft_ff;
	
	always @ (posedge clk or posedge aleft_i)
   begin
	  if (aleft_i)
	  begin
	    if(~left)
		 begin
         aleft_ff <= (aleft_ff + 1) % 64;
		 end
	  end
     else
	  begin
	    aleft_ff <= 0;
	  end
   end	
	
	reg [5:0]   aright_ff;
   wire        right;
   wire        aright_i;

   assign aright_i = btnR;
   assign right = aright_ff[0];
	
	always @ (posedge clk or posedge aright_i)
   begin
	  if (aright_i)
       aright_ff <= 6'b111111;
     else
	  begin
	    aright_ff <= {1'b0, aright_ff[5:1]};
	  end
   end

	
	reg [5:0]   amiddle_ff;
   wire        middle;
   wire        amiddle_i;

   assign amiddle_i = btnM;
   assign middle = amiddle_ff[0];
	
	always @ (posedge clk or posedge amiddle_i)
   begin
	  if (amiddle_i)
       amiddle_ff <= 6'b111111;
     else
	  begin
	    amiddle_ff <= {1'b0, amiddle_ff[5:1]};
	  end
   end
	

   clock_divider clock_divider_(
	  // output
	  .display_clk (display_clk),
	  // input
	  .clk (clk)
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
