`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:46 02/23/2017 
// Design Name: 
// Module Name:    select 
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
module select(
	  // output
	  grid,
	  location,
	  // input
	  term,
	  left,
	  right,
	  middle,
	  clk,
	  sw,
	  rst
	);
wire clk;
wire rst;
wire left;
wire right;
wire [97:0] grid;
wire player;
wire [6:0] location;
reg [6:0] location_r;
assign location = location_r;
wire term;
wire sw;

reg gone_left;
reg gone_right;
reg dropped;
reg aidropped;

input clk;
input rst;
input left;
input right;
input middle;
input term;
input sw;
wire move;
wire [6:0] ai;

output location;
output grid;

reg [97:0] grid_r = 0;
assign grid = grid_r;

reg player_r;
assign player = player_r;

reg [2:0] selected;
reg [20:0] column_counts;

	
minimax minimax_(
	.opt (ai), .move (move),
	.grid (grid[83:0]), .column_counts (column_counts), .player (player), .sw (sw), .clk (clk)
);

initial
begin
  grid_r[95:0] = 0;
  grid_r[97:96] = 2'b01;
  player_r = 0;
  selected = 0;
  column_counts = 0;
  location_r = 1;
end

always @ (posedge clk)
begin
  if(rst)
  begin
    grid_r[97:96] = 2'b01;
	 grid_r[95:0] = 0;
	 player_r = 0;
	 selected = 0;
	 column_counts = 0;
	 location_r = 1;
  end
  else if (grid_r[97:84] == 0)
  begin
    grid_r[97:96] = 2'b01;
	 player_r = 0;
	 selected = 0;
	 column_counts = 0;
	 location_r = 1;
  end
  // left
  else if (left)
  begin
    gone_right = 0;
	 dropped = 0;
    if (selected != 0  && ~gone_left)
	 begin
	   grid_r[(97-(selected)*2)-:2] = 0; 
	   selected = (selected - 1) % 8;
		grid_r[(97-(selected)*2)-:2] = player + 1;
	 end
	 gone_left = 1;
  end
  // right
  else if (right)
  begin
    gone_left = 0;
	 dropped = 0;
    if (selected != 6 && ~gone_right)
	 begin
	   grid_r[(97-(selected)*2)-:2] = 0; 
	   selected = (selected + 1) % 8;
		grid_r[(97-(selected)*2)-:2] = player + 1;
	 end
	 gone_right = 1;
  end
  // ai drop
  else if (sw && player_r && move && !term)
  begin
    if(~aidropped)
	 begin
	   location_r = ai;
      grid_r[ai-:2] = 2'b10;
	   player_r = 0;
	   column_counts[(6 - ((ai - 1) % 14)/2)*3 + 2-:3] = (column_counts[(6 - ((ai - 1) % 14)/2)*3 + 2-:3] + 1)%8;
      selected = 0;
	   grid_r[95:84] = 0;
	   grid_r[97:96] = 2'b01;
	 end
	 aidropped = 1;
  end
  // drop against ai
  else if (sw && middle && !term)
  begin
    gone_left = 0;
	 gone_right = 0;
	 if(~dropped && ~player_r)
	 begin
	   if(column_counts[selected*3 + 2-:3] < 6)
		begin
		  location_r = (13 - selected*2 + column_counts[selected*3 + 2-:3] * 14) % 128;
		  grid_r[13 - selected*2 + column_counts[selected*3 + 2-:3] * 14-:2] = player_r + 1;
		  column_counts[selected*3 + 2-:3] = (column_counts[selected*3 + 2-:3] + 1)%8;
		  player_r = ~player_r;
		  grid_r[(97-selected*2)-:2] = 0;
		  grid_r[97:96] = player_r + 1;
	     selected = 0;
		  aidropped = 0;
		end
	 end
	 dropped = 1;
  end
  // drop against player
  else if (~sw && middle && !term)
  begin
    gone_left = 0;
	 gone_right = 0;
	 if(~dropped)
	 begin
	   if(column_counts[selected*3 + 2-:3] < 6)
		begin
		  location_r = (13 - selected*2 + column_counts[selected*3 + 2-:3] * 14) % 128;
		  grid_r[13 - selected*2 + column_counts[selected*3 + 2-:3] * 14-:2] = player_r + 1;
		  column_counts[selected*3 + 2-:3] = (column_counts[selected*3 + 2-:3] + 1)%8;
		  player_r = ~player_r;
		  grid_r[(97-selected*2)-:2] = 0;
		  grid_r[97:96] = player_r + 1;
	     selected = 0;
		end
	 end
	 dropped = 1;
  end
  else
  begin
    gone_left = 0;
	 gone_right = 0;
	 dropped = 0;
	 grid_r = grid_r;
  end
end
endmodule
