`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:49 03/14/2017 
// Design Name: 
// Module Name:    score 
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
module score(
    //outputs
	 score,
	 //inputs
	 grid, ai, opponent, clk
    );
output score;

input grid;
input ai;
input opponent;
input clk;

wire [8:0] score;
reg [8:0] score_r;
assign score = score_r;
wire [83:0] grid;
wire [6:0] ai;
wire [6:0] opponent;
wire clk;


wire [2:0] aithrees;
//reg [2:0] aitwos;
wire aifour;

reg aivert;
wire aihoriz;
reg [3:0] aihoriz_r;
assign aihoriz = |aihoriz_r;
wire aidiagup;
reg [3:0] aidiagup_r;
assign aidiagup = |aidiagup_r;
wire aidiagdown;
reg [3:0] aidiagdown_r;
assign aidiagdown = |aidiagdown_r;
assign aifour = aivert | aihoriz | aidiagup | aidiagdown;

reg aivert3;
reg [2:0] aihoriz3_r;
reg [2:0] aidiagup3_r;
reg [2:0] aidiagdown3_r;

assign aithrees = aihoriz3_r[2] + aihoriz3_r[1] + aihoriz3_r[0] + aidiagup3_r[2] + aidiagup3_r[1] + aidiagup3_r[0] + aidiagdown3_r[2] + aidiagdown3_r[1] + aidiagdown3_r[0] + aivert3;

wire [2:0] opponentthrees;
//reg [2:0] opponenttwos;
wire opponentfour;

reg opponentvert;
wire opponenthoriz;
reg [3:0] opponenthoriz_r;
assign opponenthoriz = |opponenthoriz_r;
wire opponentdiagup;
reg [3:0] opponentdiagup_r;
assign opponentdiagup = |opponentdiagup_r;
wire opponentdiagdown;
reg [3:0] opponentdiagdown_r;
assign opponentdiagdown = |opponentdiagdown_r;
assign opponentfour = opponentvert | opponenthoriz | opponentdiagup | opponentdiagdown;

reg opponentvert3;
reg [2:0] opponenthoriz3_r;
reg [2:0] opponentdiagup3_r;
reg [2:0] opponentdiagdown3_r;

assign opponentthrees = opponenthoriz3_r[2] + opponenthoriz3_r[1] + opponenthoriz3_r[0] + opponentdiagup3_r[2] + opponentdiagup3_r[1] + opponentdiagup3_r[0] + opponentdiagdown3_r[2] + opponentdiagdown3_r[1] + opponentdiagdown3_r[0] + opponentvert3;

always @ (posedge clk)
  begin
    // aivertical
    if(ai > 41)
	 begin
	   aivert = grid[ai + 1  - 1] & grid[ai + 1  - 15] & grid[ai + 1  - 29] & grid[ai + 1  - 43];
	 end
	 else
	 begin
	   aivert = 0;
	 end
	 
	 // horizontal
	 if(ai == 83 || ai == 69 || ai == 55 || ai == 41 || ai == 27 || ai == 13)
	 begin
	   aihoriz_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  - 7];
	   aihoriz_r[3:1] = 0;
	 end
	 else if(ai == 81 || ai == 67 || ai == 53 || ai == 39 || ai == 25 || ai == 11)
	 begin
		aihoriz_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  - 7];
	   aihoriz_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  + 1];
      aihoriz_r[3:2] = 0;
    end
	 else if(ai == 79 || ai == 65 || ai == 51 || ai == 37 || ai == 23 || ai == 9)
	 begin
		aihoriz_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  - 7];
	   aihoriz_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  + 1];
      aihoriz_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
		aihoriz_r[3] = 0;
    end
	 else if(ai == 77 || ai == 63 || ai == 49 || ai == 35 || ai == 21 || ai == 7)
	 begin
		aihoriz_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  - 7];
	   aihoriz_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  + 1];
      aihoriz_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
		aihoriz_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 5] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else if(ai == 75 || ai == 61 || ai == 47 || ai == 33 || ai == 19 || ai == 5)
    begin
		aihoriz_r[0] = 0;
	   aihoriz_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5] & grid[ai + 1  + 1];
      aihoriz_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
		aihoriz_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 5] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else if(ai == 73 || ai == 59 || ai == 45 || ai == 31 || ai == 17 || ai == 3)
	 begin
		aihoriz_r[1:0] = 0;     
	   aihoriz_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
		aihoriz_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 5] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else if(ai == 71 || ai == 57 || ai == 43 || ai == 29 || ai == 15 || ai == 1)
	 begin  
		aihoriz_r[2:0] = 0;
		aihoriz_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 5] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else
	 begin
	   aihoriz_r = 0;
	 end

    // diagonal up (left to right)
	 // last
	 if(ai == 77 || ai == 75|| ai == 73 || ai == 71 || ai == 57 || ai == 43)
	 begin
	   aidiagup_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  - 37];
	   aidiagup_r[3:1] = 0;
	 end
	 // last or third
	 else if(ai == 63 || ai == 61 || ai == 59 || ai == 45)
	 begin
	   aidiagup_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  - 37];
	   aidiagup_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  + 11];
      aidiagup_r[3:2] = 0;
    end
	 // last or third or second
	 else if(ai == 49 || ai == 47)
	 begin
	   aidiagup_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  - 37];
	   aidiagup_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  + 11];
      aidiagup_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
      aidiagup_r[3] = 0;
	 end
	 // first
	 else if(ai == 13 || ai == 11 || ai == 9 || ai == 7 || ai == 27 || ai == 41)
	 begin
		aidiagup_r[0] = 0;
	   aidiagup_r[1] = 0;
      aidiagup_r[2] = 0;
      aidiagup_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 35] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
	 end
	 // first or second
	 else if(ai == 25 || ai == 23 || ai == 21 || ai == 39)
	 begin
	   aidiagup_r[0] = 0;
	   aidiagup_r[1] = 0;
      aidiagup_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
      aidiagup_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 35] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
	 end
	 // first or second or third
	 else if(ai == 37 || ai == 35)
	 begin
	   aidiagup_r[0] = 0;
	   aidiagup_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  + 11];
      aidiagup_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
      aidiagup_r[3] = grid[ai + 1  - 1] & grid[ai + 1  + 35] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
	 end
	 // second or third
	 else if(ai == 51 || ai == 33)
	 begin
	   aidiagup_r[0] = 0;
	   aidiagup_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  + 11];
      aidiagup_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
      aidiagup_r[3] = 0;
	 end
	 // second
	 else if(ai == 19 || ai == 53)
	 begin
	   aidiagup_r[0] = 0;
	   aidiagup_r[1] = 0;
      aidiagup_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
      aidiagup_r[3] = 0;
	 end
	 // third
	 else if(ai == 65 || ai == 31)
	 begin
	   aidiagup_r[0] = 0;
	   aidiagup_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25] & grid[ai + 1  + 11];
      aidiagup_r[2] = 0;
      aidiagup_r[3] = 0;    
	 end
	 else
	 begin
	   aidiagup_r = 0;
	 end

	 // diagonal down (left to right)
	 // last
	 if(ai == 7 || ai == 5 || ai == 3 || ai == 1 || ai == 15 || ai == 29)
	 begin
	   aidiagdown_r[0] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  + 47];
	   aidiagdown_r[3:1] = 0;
	 end
	 // last or third
	 else if(ai == 21 || ai == 19 || ai == 17 || ai == 31)
	 begin
      aidiagdown_r[0] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  + 47];
	   aidiagdown_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  - 17];
      aidiagdown_r[3:2] = 0;
    end
	 // last or third or second
	 else if(ai == 35 || ai == 33)
	 begin
	   aidiagdown_r[0] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  + 47];
	   aidiagdown_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  - 17];
      aidiagdown_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	   aidiagdown_r[3] = 0;
	 end
	 // first
	 else if(ai == 83 || ai == 81 || ai == 79 || ai == 77 || ai == 69 || ai == 55)
	 begin
		aidiagdown_r[0] = 0;
	   aidiagdown_r[1] = 0;
      aidiagdown_r[2] = 0;
      aidiagdown_r[3] = grid[ai + 1  - 1] & grid[ai + 1  - 49] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
    end
	 // first or second
	 else if(ai == 67 || ai == 65 || ai == 63 || ai == 53)
	 begin
	   aidiagdown_r[0] = 0;
	   aidiagdown_r[1] = 0;
      aidiagdown_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	   aidiagdown_r[3] = grid[ai + 1  - 1] & grid[ai + 1  - 49] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	 end
	 // first or second or third
	 else if(ai == 51 || ai == 49)
	 begin
	   aidiagdown_r[0] = 0;
      aidiagdown_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  - 17];
      aidiagdown_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
      aidiagdown_r[3] = grid[ai + 1  - 1] & grid[ai + 1  - 49] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	 end
	 // second or third
	 else if(ai == 37 || ai == 47)
	 begin
	   aidiagdown_r[0] = 0;
      aidiagdown_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  - 17];
      aidiagdown_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
      aidiagdown_r[3] = 0;
	 end
	 // second
	 else if(ai == 61 || ai == 39)
	 begin
	   aidiagdown_r[0] = 0;
	   aidiagdown_r[1] = 0;
      aidiagdown_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
      aidiagdown_r[3] = 0;
	 end
	 // third
	 else if(ai == 23 || ai == 45)
	 begin
	   aidiagdown_r[0] = 0;
      aidiagdown_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31] & grid[ai + 1  - 17];
      aidiagdown_r[2] = 0;
      aidiagdown_r[3] = 0;    
	 end
	 else
	 begin
	   aidiagdown_r = 0;
	 end
	 
    // aivert3ical
    if(ai > 27)
	 begin
	   aivert3 = grid[ai + 1  - 1] & grid[ai + 1  - 15] & grid[ai + 1  - 29];
	 end
	 else
	 begin
	   aivert3 = 0;
	 end
	 
	 // horiz3ontal
	 if(ai == 83 || ai == 69 || ai == 55 || ai == 41 || ai == 27 || ai == 13)
	 begin
	   aihoriz3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5];
	   aihoriz3_r[2:1] = 0;
	 end
	 else if(ai == 81 || ai == 67 || ai == 53 || ai == 39 || ai == 25 || ai == 11)
	 begin
		aihoriz3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5];
	   aihoriz3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 1];
      aihoriz3_r[2] = 0;
    end
	 else if(ai == 79 || ai == 65 || ai == 51 || ai == 37 || ai == 23 || ai == 9 || ai == 77 || ai == 63 || ai == 49 || ai == 35 || ai == 21 || ai == 7 || ai == 75 || ai == 61 || ai == 47 || ai == 33 || ai == 19 || ai == 5)
	 begin
		aihoriz3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  - 5];
	   aihoriz3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 1];
      aihoriz3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else if(ai == 73 || ai == 59 || ai == 45 || ai == 31 || ai == 17 || ai == 3)
	 begin
		aihoriz3_r[0] = 0;     
	   aihoriz3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 3] & grid[ai + 1  + 1];
      aihoriz3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else if(ai == 71 || ai == 57 || ai == 43 || ai == 29 || ai == 15 || ai == 1)
	 begin  
		aihoriz3_r[1:0] = 0;
		aihoriz3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 3] & grid[ai + 1  + 1];
    end
	 else
	 begin
	   aihoriz3_r = 0;
	 end

    // diagonal up (left to right)
	 // last
	 if(ai == 79 || ai == 77 || ai == 75|| ai == 73 || ai == 71 || ai == 57 || ai == 43 || ai == 29)
	 begin
	   aidiagup3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25];
	   aidiagup3_r[2:1] = 0;
	 end
	 // last or second
	 else if(ai == 65 || ai == 63 || ai == 61 || ai == 59 || ai == 45 || ai == 31)
	 begin
	   aidiagup3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25];
	   aidiagup3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 11];
      aidiagup3_r[2] = 0;
    end
	 // last or second or first
	 else if(ai == 51 || ai == 49 || ai == 47 || ai == 37 || ai == 35 || ai == 33)
	 begin
	   aidiagup3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  - 25];
	   aidiagup3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 11];
      aidiagup3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
	 end
	 // first
	 else if(ai == 13 || ai == 11 || ai == 9 || ai == 7 || ai == 5 || ai == 27 || ai == 41 || ai == 55)
	 begin
		aidiagup3_r[0] = 0;
	   aidiagup3_r[1] = 0;
      aidiagup3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
	 end
	 // first or second
	 else if(ai == 25 || ai == 23 || ai == 21 || ai == 19 || ai == 39 ||ai == 53)
	 begin
	   aidiagup3_r[0] = 0;
	   aidiagup3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 11];
      aidiagup3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  + 23] & grid[ai + 1  + 11];
	 end
	 // second
	 else if(ai == 17 || ai == 67)
	 begin
	   aidiagup3_r[0] = 0;
	   aidiagup3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  - 13] & grid[ai + 1  + 11];
      aidiagup3_r[2] = 0;
	 end
	 else
	 begin
	   aidiagup3_r = 0;
	 end

    // diagonal down (left to right)
	 // last
	 if(ai == 9 || ai == 7 || ai == 5|| ai == 3 || ai == 1 || ai == 15 || ai == 29 || ai == 43)
	 begin
	 	aidiagdown3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31];
	   aidiagdown3_r[2:1] = 0;
	 end
	 // last or second
	 else if(ai == 23 || ai == 21 || ai == 19 || ai == 17 || ai == 31 || ai == 45)
	 begin
	 	aidiagdown3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31];
	   aidiagdown3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 17];
      aidiagdown3_r[2] = 0;
    end
	 // last or second or first
	 else if(ai == 51 || ai == 49 || ai == 47 || ai == 37 || ai == 35 || ai == 33)
	 begin
	 	aidiagdown3_r[0] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  + 31];
	   aidiagdown3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 17];
      aidiagdown3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	 end
	 // first
	 else if(ai == 83 || ai == 81 || ai == 79 || ai == 77 || ai == 75 || ai == 69 || ai == 55 || ai == 41)
	 begin
		aidiagdown3_r[0] = 0;
	   aidiagdown3_r[1] = 0;
      aidiagdown3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	 end
	 // first or second
	 else if(ai == 67 || ai == 65 || ai == 63 || ai == 61 || ai == 53 ||ai == 39)
	 begin
	   aidiagdown3_r[0] = 0;
	   aidiagdown3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 17];
      aidiagdown3_r[2] = grid[ai + 1  - 1] & grid[ai + 1  - 33] & grid[ai + 1  - 17];
	 end
	 // second
	 else if(ai == 59 || ai == 25)
	 begin
	   aidiagdown3_r[0] = 0;
	   aidiagdown3_r[1] = grid[ai + 1  - 1] & grid[ai + 1  + 15] & grid[ai + 1  - 17];
      aidiagdown3_r[2] = 0;
	 end
	 else
	 begin
	   aidiagdown3_r = 0;
	 end
	 
	 
	 
	 
	 
	 
	 
	     // opponentvertical
    if(opponent + 1 > 41)
	 begin
	   opponentvert = grid[opponent + 1 - 1] & grid[opponent + 1 - 15] & grid[opponent + 1 - 29] & grid[opponent + 1 - 43];
	 end
	 else
	 begin
	   opponentvert = 0;
	 end
	 
	 // horizontal
	 if(opponent + 1 == 83 || opponent + 1 == 69 || opponent + 1 == 55 || opponent + 1 == 41 || opponent + 1 == 27 || opponent + 1 == 13)
	 begin
	   opponenthoriz_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 - 7];
	   opponenthoriz_r[3:1] = 0;
	 end
	 else if(opponent + 1 == 81 || opponent + 1 == 67 || opponent + 1 == 53 || opponent + 1 == 39 || opponent + 1 == 25 || opponent + 1 == 11)
	 begin
		opponenthoriz_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 - 7];
	   opponenthoriz_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 + 1];
      opponenthoriz_r[3:2] = 0;
    end
	 else if(opponent + 1 == 79 || opponent + 1 == 65 || opponent + 1 == 51 || opponent + 1 == 37 || opponent + 1 == 23 || opponent + 1 == 9)
	 begin
		opponenthoriz_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 - 7];
	   opponenthoriz_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 + 1];
      opponenthoriz_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
		opponenthoriz_r[3] = 0;
    end
	 else if(opponent + 1 == 77 || opponent + 1 == 63 || opponent + 1 == 49 || opponent + 1 == 35 || opponent + 1 == 21 || opponent + 1 == 7)
	 begin
		opponenthoriz_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 - 7];
	   opponenthoriz_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 + 1];
      opponenthoriz_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
		opponenthoriz_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 5] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else if(opponent + 1 == 75 || opponent + 1 == 61 || opponent + 1 == 47 || opponent + 1 == 33 || opponent + 1 == 19 || opponent + 1 == 5)
    begin
		opponenthoriz_r[0] = 0;
	   opponenthoriz_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5] & grid[opponent + 1 + 1];
      opponenthoriz_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
		opponenthoriz_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 5] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else if(opponent + 1 == 73 || opponent + 1 == 59 || opponent + 1 == 45 || opponent + 1 == 31 || opponent + 1 == 17 || opponent + 1 == 3)
	 begin
		opponenthoriz_r[1:0] = 0;     
	   opponenthoriz_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
		opponenthoriz_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 5] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else if(opponent + 1 == 71 || opponent + 1 == 57 || opponent + 1 == 43 || opponent + 1 == 29 || opponent + 1 == 15 || opponent + 1 == 1)
	 begin  
		opponenthoriz_r[2:0] = 0;
		opponenthoriz_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 5] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else
	 begin
	   opponenthoriz_r = 0;
	 end

    // diagonal up (left to right)
	 // last
	 if(opponent + 1 == 77 || opponent + 1 == 75|| opponent + 1 == 73 || opponent + 1 == 71 || opponent + 1 == 57 || opponent + 1 == 43)
	 begin
	   opponentdiagup_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 - 37];
	   opponentdiagup_r[3:1] = 0;
	 end
	 // last or third
	 else if(opponent + 1 == 63 || opponent + 1 == 61 || opponent + 1 == 59 || opponent + 1 == 45)
	 begin
	   opponentdiagup_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 - 37];
	   opponentdiagup_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 + 11];
      opponentdiagup_r[3:2] = 0;
    end
	 // last or third or second
	 else if(opponent + 1 == 49 || opponent + 1 == 47)
	 begin
	   opponentdiagup_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 - 37];
	   opponentdiagup_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 + 11];
      opponentdiagup_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
      opponentdiagup_r[3] = 0;
	 end
	 // first
	 else if(opponent + 1 == 13 || opponent + 1 == 11 || opponent + 1 == 9 || opponent + 1 == 7 || opponent + 1 == 27 || opponent + 1 == 41)
	 begin
		opponentdiagup_r[0] = 0;
	   opponentdiagup_r[1] = 0;
      opponentdiagup_r[2] = 0;
      opponentdiagup_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 35] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
	 end
	 // first or second
	 else if(opponent + 1 == 25 || opponent + 1 == 23 || opponent + 1 == 21 || opponent + 1 == 39)
	 begin
	   opponentdiagup_r[0] = 0;
	   opponentdiagup_r[1] = 0;
      opponentdiagup_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
      opponentdiagup_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 35] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
	 end
	 // first or second or third
	 else if(opponent + 1 == 37 || opponent + 1 == 35)
	 begin
	   opponentdiagup_r[0] = 0;
	   opponentdiagup_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 + 11];
      opponentdiagup_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
      opponentdiagup_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 + 35] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
	 end
	 // second or third
	 else if(opponent + 1 == 51 || opponent + 1 == 33)
	 begin
	   opponentdiagup_r[0] = 0;
	   opponentdiagup_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 + 11];
      opponentdiagup_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
      opponentdiagup_r[3] = 0;
	 end
	 // second
	 else if(opponent + 1 == 19 || opponent + 1 == 53)
	 begin
	   opponentdiagup_r[0] = 0;
	   opponentdiagup_r[1] = 0;
      opponentdiagup_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
      opponentdiagup_r[3] = 0;
	 end
	 // third
	 else if(opponent + 1 == 65 || opponent + 1 == 31)
	 begin
	   opponentdiagup_r[0] = 0;
	   opponentdiagup_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25] & grid[opponent + 1 + 11];
      opponentdiagup_r[2] = 0;
      opponentdiagup_r[3] = 0;    
	 end
	 else
	 begin
	   opponentdiagup_r = 0;
	 end

	 // diagonal down (left to right)
	 // last
	 if(opponent + 1 == 7 || opponent + 1 == 5 || opponent + 1 == 3 || opponent + 1 == 1 || opponent + 1 == 15 || opponent + 1 == 29)
	 begin
	   opponentdiagdown_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 + 47];
	   opponentdiagdown_r[3:1] = 0;
	 end
	 // last or third
	 else if(opponent + 1 == 21 || opponent + 1 == 19 || opponent + 1 == 17 || opponent + 1 == 31)
	 begin
      opponentdiagdown_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 + 47];
	   opponentdiagdown_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 - 17];
      opponentdiagdown_r[3:2] = 0;
    end
	 // last or third or second
	 else if(opponent + 1 == 35 || opponent + 1 == 33)
	 begin
	   opponentdiagdown_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 + 47];
	   opponentdiagdown_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 - 17];
      opponentdiagdown_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	   opponentdiagdown_r[3] = 0;
	 end
	 // first
	 else if(opponent + 1 == 83 || opponent + 1 == 81 || opponent + 1 == 79 || opponent + 1 == 77 || opponent + 1 == 69 || opponent + 1 == 55)
	 begin
		opponentdiagdown_r[0] = 0;
	   opponentdiagdown_r[1] = 0;
      opponentdiagdown_r[2] = 0;
      opponentdiagdown_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 - 49] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
    end
	 // first or second
	 else if(opponent + 1 == 67 || opponent + 1 == 65 || opponent + 1 == 63 || opponent + 1 == 53)
	 begin
	   opponentdiagdown_r[0] = 0;
	   opponentdiagdown_r[1] = 0;
      opponentdiagdown_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	   opponentdiagdown_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 - 49] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	 end
	 // first or second or third
	 else if(opponent + 1 == 51 || opponent + 1 == 49)
	 begin
	   opponentdiagdown_r[0] = 0;
      opponentdiagdown_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 - 17];
      opponentdiagdown_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
      opponentdiagdown_r[3] = grid[opponent + 1 - 1] & grid[opponent + 1 - 49] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	 end
	 // second or third
	 else if(opponent + 1 == 37 || opponent + 1 == 47)
	 begin
	   opponentdiagdown_r[0] = 0;
      opponentdiagdown_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 - 17];
      opponentdiagdown_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
      opponentdiagdown_r[3] = 0;
	 end
	 // second
	 else if(opponent + 1 == 61 || opponent + 1 == 39)
	 begin
	   opponentdiagdown_r[0] = 0;
	   opponentdiagdown_r[1] = 0;
      opponentdiagdown_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
      opponentdiagdown_r[3] = 0;
	 end
	 // third
	 else if(opponent + 1 == 23 || opponent + 1 == 45)
	 begin
	   opponentdiagdown_r[0] = 0;
      opponentdiagdown_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31] & grid[opponent + 1 - 17];
      opponentdiagdown_r[2] = 0;
      opponentdiagdown_r[3] = 0;    
	 end
	 else
	 begin
	   opponentdiagdown_r = 0;
	 end
	 
    // opponentvert3ical
    if(opponent + 1 > 27)
	 begin
	   opponentvert3 = grid[opponent + 1 - 1] & grid[opponent + 1 - 15] & grid[opponent + 1 - 29];
	 end
	 else
	 begin
	   opponentvert3 = 0;
	 end
	 
	 // horiz3ontal
	 if(opponent + 1 == 83 || opponent + 1 == 69 || opponent + 1 == 55 || opponent + 1 == 41 || opponent + 1 == 27 || opponent + 1 == 13)
	 begin
	   opponenthoriz3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5];
	   opponenthoriz3_r[2:1] = 0;
	 end
	 else if(opponent + 1 == 81 || opponent + 1 == 67 || opponent + 1 == 53 || opponent + 1 == 39 || opponent + 1 == 25 || opponent + 1 == 11)
	 begin
		opponenthoriz3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5];
	   opponenthoriz3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 1];
      opponenthoriz3_r[2] = 0;
    end
	 else if(opponent + 1 == 79 || opponent + 1 == 65 || opponent + 1 == 51 || opponent + 1 == 37 || opponent + 1 == 23 || opponent + 1 == 9 || opponent + 1 == 77 || opponent + 1 == 63 || opponent + 1 == 49 || opponent + 1 == 35 || opponent + 1 == 21 || opponent + 1 == 7 || opponent + 1 == 75 || opponent + 1 == 61 || opponent + 1 == 47 || opponent + 1 == 33 || opponent + 1 == 19 || opponent + 1 == 5)
	 begin
		opponenthoriz3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 - 5];
	   opponenthoriz3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 1];
      opponenthoriz3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else if(opponent + 1 == 73 || opponent + 1 == 59 || opponent + 1 == 45 || opponent + 1 == 31 || opponent + 1 == 17 || opponent + 1 == 3)
	 begin
		opponenthoriz3_r[0] = 0;     
	   opponenthoriz3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 3] & grid[opponent + 1 + 1];
      opponenthoriz3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else if(opponent + 1 == 71 || opponent + 1 == 57 || opponent + 1 == 43 || opponent + 1 == 29 || opponent + 1 == 15 || opponent + 1 == 1)
	 begin  
		opponenthoriz3_r[1:0] = 0;
		opponenthoriz3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 3] & grid[opponent + 1 + 1];
    end
	 else
	 begin
	   opponenthoriz3_r = 0;
	 end

    // diagonal up (left to right)
	 // last
	 if(opponent + 1 == 79 || opponent + 1 == 77 || opponent + 1 == 75|| opponent + 1 == 73 || opponent + 1 == 71 || opponent + 1 == 57 || opponent + 1 == 43 || opponent + 1 == 29)
	 begin
	   opponentdiagup3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25];
	   opponentdiagup3_r[2:1] = 0;
	 end
	 // last or second
	 else if(opponent + 1 == 65 || opponent + 1 == 63 || opponent + 1 == 61 || opponent + 1 == 59 || opponent + 1 == 45 || opponent + 1 == 31)
	 begin
	   opponentdiagup3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25];
	   opponentdiagup3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 11];
      opponentdiagup3_r[2] = 0;
    end
	 // last or second or first
	 else if(opponent + 1 == 51 || opponent + 1 == 49 || opponent + 1 == 47 || opponent + 1 == 37 || opponent + 1 == 35 || opponent + 1 == 33)
	 begin
	   opponentdiagup3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 - 25];
	   opponentdiagup3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 11];
      opponentdiagup3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
	 end
	 // first
	 else if(opponent + 1 == 13 || opponent + 1 == 11 || opponent + 1 == 9 || opponent + 1 == 7 || opponent + 1 == 5 || opponent + 1 == 27 || opponent + 1 == 41 || opponent + 1 == 55)
	 begin
		opponentdiagup3_r[0] = 0;
	   opponentdiagup3_r[1] = 0;
      opponentdiagup3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
	 end
	 // first or second
	 else if(opponent + 1 == 25 || opponent + 1 == 23 || opponent + 1 == 21 || opponent + 1 == 19 || opponent + 1 == 39 ||opponent + 1 == 53)
	 begin
	   opponentdiagup3_r[0] = 0;
	   opponentdiagup3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 11];
      opponentdiagup3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 + 23] & grid[opponent + 1 + 11];
	 end
	 // second
	 else if(opponent + 1 == 17 || opponent + 1 == 67)
	 begin
	   opponentdiagup3_r[0] = 0;
	   opponentdiagup3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 - 13] & grid[opponent + 1 + 11];
      opponentdiagup3_r[2] = 0;
	 end
	 else
	 begin
	   opponentdiagup3_r = 0;
	 end

    // diagonal down (left to right)
	 // last
	 if(opponent + 1 == 9 || opponent + 1 == 7 || opponent + 1 == 5|| opponent + 1 == 3 || opponent + 1 == 1 || opponent + 1 == 15 || opponent + 1 == 29 || opponent + 1 == 43)
	 begin
	 	opponentdiagdown3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31];
	   opponentdiagdown3_r[2:1] = 0;
	 end
	 // last or second
	 else if(opponent + 1 == 23 || opponent + 1 == 21 || opponent + 1 == 19 || opponent + 1 == 17 || opponent + 1 == 31 || opponent + 1 == 45)
	 begin
	 	opponentdiagdown3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31];
	   opponentdiagdown3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 17];
      opponentdiagdown3_r[2] = 0;
    end
	 // last or second or first
	 else if(opponent + 1 == 51 || opponent + 1 == 49 || opponent + 1 == 47 || opponent + 1 == 37 || opponent + 1 == 35 || opponent + 1 == 33)
	 begin
	 	opponentdiagdown3_r[0] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 + 31];
	   opponentdiagdown3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 17];
      opponentdiagdown3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	 end
	 // first
	 else if(opponent + 1 == 83 || opponent + 1 == 81 || opponent + 1 == 79 || opponent + 1 == 77 || opponent + 1 == 75 || opponent + 1 == 69 || opponent + 1 == 55 || opponent + 1 == 41)
	 begin
		opponentdiagdown3_r[0] = 0;
	   opponentdiagdown3_r[1] = 0;
      opponentdiagdown3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	 end
	 // first or second
	 else if(opponent + 1 == 67 || opponent + 1 == 65 || opponent + 1 == 63 || opponent + 1 == 61 || opponent + 1 == 53 ||opponent + 1 == 39)
	 begin
	   opponentdiagdown3_r[0] = 0;
	   opponentdiagdown3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 17];
      opponentdiagdown3_r[2] = grid[opponent + 1 - 1] & grid[opponent + 1 - 33] & grid[opponent + 1 - 17];
	 end
	 // second
	 else if(opponent + 1 == 59 || opponent + 1 == 25)
	 begin
	   opponentdiagdown3_r[0] = 0;
	   opponentdiagdown3_r[1] = grid[opponent + 1 - 1] & grid[opponent + 1 + 15] & grid[opponent + 1 - 17];
      opponentdiagdown3_r[2] = 0;
	 end
	 else
	 begin
	   opponentdiagdown3_r = 0;
	 end
	 
	 if(aifour)
	 begin
	   score_r = 511;
	 end
	 else if (opponentfour)
	 begin
	   score_r = 0;
	 end
	 else
	 begin
	   if (ai % 14 > 7)
		begin
		  score_r = (200 + 10 * aithrees - 10 * opponentthrees + 14 - (ai % 14))% 512;
		end
		else
	   begin
		  score_r = (200 + 10 * aithrees - 10 * opponentthrees + ai % 14) % 512;
		end   
	 end
  end
endmodule