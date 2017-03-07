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
	  player,
	  // input
	  left,
	  right,
	  middle,
	  clk
	);
wire clk;
wire left;
wire right;
wire [97:0] grid;
wire player;

//reg [10:0] gone_left_ff;
//reg [10:0] gone_right_ff;
//reg [10:0] dropped_ff;

//wire gone_left;
//wire gone_right;
//wire dropped;

reg gone_left;
reg gone_right;
reg dropped;

//assign gone_left = gone_left_ff[0];
//assign gone_right = gone_right_ff[0];
//assign dropped = dropped_ff[0];

input clk;
input left;
input right;
input middle;


output grid;
output player;

reg [97:0] grid_r = 0;
assign grid = grid_r;

reg player_r;
assign player = player_r;

reg [2:0] selected;
reg [20:0] column_counts;

initial
begin
  grid_r[95:0] = 0;
  grid_r[97:96] = 1;
  player_r = 0;
  selected = 0;
  column_counts = 0;
end

always @ (posedge clk)
begin
  if (grid_r[97:84] == 0)
  begin
    grid_r[97:96] = 2'b01;
	 player_r = 0;
	 selected = 0;
	 column_counts = 0;
  end
  // left
  else if (left)
  begin
    gone_right = 0;
    //gone_right_ff = 0;
    //gone_right_ff = {1'b0, gone_right_ff[10:1]};
	 dropped = 0;
	 //dropped_ff = 0;
	 //dropped_ff = {1'b0, dropped_ff[10:1]};
    if (selected != 0  && ~gone_left)
	 begin
	   grid_r[(97-(selected)*2)-:2] = 0; 
	   selected = (selected - 1) % 8;
		grid_r[(97-(selected)*2)-:2] = player + 1;
	 end
	 gone_left = 1;
	 //gone_left_ff = 11'b11111111111;
  end
  // right
  else if (right)
  begin
    gone_left = 0;
    //gone_left_ff = 0;
    //gone_left_ff = {1'b0, gone_left_ff[10:1]};
	 dropped = 0;
	 //dropped_ff = 0;
	 //dropped_ff = {1'b0, dropped_ff[10:1]};
    if (selected != 6 && ~gone_right)
	 begin
	   grid_r[(97-(selected)*2)-:2] = 0; 
	   selected = (selected + 1) % 8;
		grid_r[(97-(selected)*2)-:2] = player + 1;
	 end
	 gone_right = 1;
	 //gone_right_ff = 11'b11111111111;
  end
  // drop
  else if (middle)
  begin
    gone_left = 0;
    //gone_left_ff = 0;
    //gone_left_ff = {1'b0, gone_left_ff[10:1]};
	 gone_right = 0;
	 //gone_right_ff = 0;
	 //gone_right_ff = {1'b0, gone_right_ff[10:1]};
	 if(~dropped)
	 begin
	   if(column_counts[selected*3 + 2-:3] < 6)
		begin
		  grid_r[13 - selected*2 + column_counts[selected*3 + 2-:3] * 14-:2] = player_r + 1;
		  column_counts[selected*3 + 2-:3] = (column_counts[selected*3 + 2-:3] + 1)%8;
		  player_r = ~player_r;
		  grid_r[(97-selected*2)-:2] = 0;
		  grid_r[97:96] = player_r + 1;
	     selected = 0;
		end
	 end
	 dropped = 1;
	 //dropped_ff = 11'b11111111111;
  end
  else
  begin
    gone_left = 0;
	 gone_right = 0;
	 dropped = 0;
    //gone_left_ff = 0;
    //gone_left_ff = {1'b0, gone_left_ff[10:1]};
	 //gone_right_ff = 0;
	 //gone_right_ff = {1'b0, gone_right_ff[10:1]};
	 //dropped_ff = 0;
	 //dropped_ff = {1'b0, dropped_ff[10:1]};
	 grid_r = grid_r;
  end
end
endmodule
