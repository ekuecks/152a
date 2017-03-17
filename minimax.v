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
reg initial_score;

reg [6:0] count; // 105 cycles
wire [6:0] opt;
reg [6:0] opt_r;
assign opt = opt_r;
reg [8:0] optscore;
wire [8:0] score;
reg [8:0] curscore;

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
  optscore = 0;
end

always @(posedge clk)
begin
  if (player == 0 || !sw)
  begin
    count = 0;
    move_r = 0;
    optscore = 0;
    opt_r = 1;
	 curscore = 0;
  end
  else if (count == 105)
  begin
    if(curscore >= optscore && aimoved)
    begin
      // Same check as below
      // For the last move
      opt_r = ai;
      optscore = curscore;
    end
    move_r = 1;
    count = (count + 1) % 128;
  end
  else if (count > 105)
  begin
    move_r = 0;
  end
  else if (count % 15 == 0)
  begin
    if(count == 0)
    begin
      optscore = 0;
    end
    else if(curscore >= optscore)
    begin
      // if this is not the first time through, then curscore is the min score for the previous move
      // if curscore is larger than the optimal score so far, update the optimal move to be the previous one
      // which is still stored in ai
      // (maximize the minima)
      opt_r = ai;
      optscore = curscore;
    end
	 initial_score = 1;
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
    // make next opponent move every other frame
    if(column_counts[(((count % 15) - 1)/2)* 3 +2-:3] < 6)
    begin
      grid_copy_2 = grid_copy;
      grid_copy_2[14 - (count % 15) + column_counts[(((count % 15) - 1)/2)* 3 +2-:3] * 14-:2] = 2'b01;
      opponentmoved = 1;
      opponent = (13 - (count % 15) + column_counts[(((count % 15) - 1)/2)* 3 +2-:3] * 14)% 128;
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
    // get the score after each opponent move
    if ((score <= curscore || initial_score) && aimoved && opponentmoved)
    begin
      // curscore is the score for the current ai move
      // if this score is lower thn the current score we have, update (minimize this score)
      curscore = score;
		initial_score = 0;
    end
    count = (count + 1) % 128;
  end
end
endmodule
