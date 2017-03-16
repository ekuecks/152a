`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:08 03/14/2017 
// Design Name: 
// Module Name:    minimax 
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
module minimax(
   // outputs
   opt, move,
	// inputs
	grid, column_counts, player, sw, clk
    );
	 
input grid;
input column_counts;
input player;
input sw;
input clk;

output opt;
output move;

wire [20:0] column_counts;
reg [20:0] column_counts_copy;
wire [83:0] grid;
reg [83:0] grid_copy;
reg [83:0] grid_copy_2;
reg aimoved;
reg opponentmoved;
reg [6:0] ai;
reg [6:0] opponent;
reg [2:0] index;
wire move;
reg move_r;
assign move = move_r;

reg [6:0] count; // 105 cycles
wire [6:0] opt;
reg [48:0] opt_rs;
reg [6:0] opt_r;
assign opt = opt_r;
reg [62:0] optscores;
wire [8:0] score;

score score_(
    //outputs
	 .score (score),
	 //inputs
	 .grid (grid_copy_2), .ai (ai), .opponent (opponent), .clk (clk)
    );
	 
initial
begin
  grid_copy = 0;
  ai = 1;
  opponent = 0;
  grid_copy_2 = 0;
  move_r = 0;
  column_counts_copy = 0;
  count = 0;
  optscores = 0;
  index = 0;
end

always @(posedge clk)
begin
  if (player == 0 || !sw)
  begin
    count = 0;
	 move_r = 0;
	 optscores = 0;
	 opt_r = 1;
	 index = 0;
  end
  else if (count == 105)
  begin
    move_r = 1;
	 count = (count + 1) % 128;
	 if(optscores[62:54] > optscores[53:45])
	 begin
	   if(optscores[62:54] > optscores[44:36])
		begin
		  if(opscores[62:54] > optscores[35:27])
	 end
  end
  else if (count > 105)
  begin
    move_r = 0;
  end
  else if (count % 15 == 0)
  begin
    index = count / 15;
    // make next ai move
	 if(column_counts[(count / 15)*3 + 2-:3] < 6)
	 begin
	   grid_copy = grid;
		grid_copy[13 - (count / 15)*2 + column_counts[(count / 15)*3 + 2-:3] * 14-:2] = 2'b10;
		aimoved = 1;
		ai = (13 - (count / 15)*2 + column_counts[(count / 15)*3 + 2-:3] * 14) % 128;
		column_counts_copy = column_counts;
      column_counts_copy[(count / 15)*3 + 2-:3] = (column_counts_copy[(count / 15)*3 + 2-:3] + 1) % 8;
	 end
	 else
	 begin
	   grid_copy = grid;
		aimoved = 0;
		ai = 1;
	 end
	 count = (count + 1) % 128;
  end
  else if ((count % 15) % 2 == 1)
  begin
    // make next opponent move
	 if(column_counts[(((count % 15) - 1)/2)* 3 +2-:3] < 6)
	 begin
	   grid_copy_2 = grid_copy;
		grid_copy_2[13 - (count % 15)*2 + column_counts[(((count % 15) - 1)/2)* 3 +2-:3] * 14-:2] = 2'b01;
		opponentmoved = 1;
		opponent = (12 - (count % 15)*2 + column_counts[(((count % 15) - 1)/2)* 3 +2-:3] * 14)% 128;
	 end
	 else
	 begin
	   grid_copy_2 = grid_copy;
		opponentmoved = 0;
		opponent = 0;
	 end
	 count = (count + 1) % 128;
  end
  else
  begin
    // get the score
	 if (score <= optscores[(index+1)*9-1-:9] && aimoved && opponentmoved)
	 begin
	   opt_r[(index+1)*7-1-:7] = ai;
		optscores[(index+1)*9-1-:9] = score;
	 end
	 count = (count + 1) % 128;
  end
end
endmodule
