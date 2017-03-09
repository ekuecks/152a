`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:12 02/23/2017 
// Design Name: 
// Module Name:    terminate 
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
module terminate(
    winner,
	 clk, grid, location
    );
  input clk;
  input grid;
  input location;
  output winner;
  
  wire clk;
  wire [97:0] grid;
  wire winner;
  wire [6:0] location;
  reg vert;
  
  wire horiz;
  reg [3:0] horiz_r;
  assign horiz = |horiz_r;
  
  wire diagup;
  reg [3:0] diagup_r;
  assign diagup = |diagup_r;
  
  wire diagdown;
  reg [3:0] diagdown_r;
  assign diagdown = |diagdown_r;
  
  assign winner = vert | horiz | diagup | diagdown;

  always @ (posedge clk)
  begin
    // vertical
    if(location > 41)
	 begin
	   vert = (grid[location] & grid[location - 14] & grid[location - 28] & grid[location - 42]) | (grid[location - 1] & grid[location - 15] & grid[location - 29] & grid[location - 43]);
	 end
	 else
	 begin
	   vert = 0;
	 end
	 
	 // horizontal
	 if(location == 83 || location == 69 || location == 55 || location == 41 || location == 27 || location == 13)
	 begin
	   horiz_r[0] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location - 6]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location - 7]);
	   horiz_r[3:1] = 0;
	 end
	 else if(location == 81 || location == 67 || location == 53 || location == 39 || location == 25 || location == 11)
	 begin
		horiz_r[0] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location - 6]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location - 7]);
	   horiz_r[1] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location + 1]);
      horiz_r[3:2] = 0;
    end
	 else if(location == 79 || location == 65 || location == 51 || location == 37 || location == 23 || location == 9)
	 begin
		horiz_r[0] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location - 6]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location - 7]);
	   horiz_r[1] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location + 1]);
      horiz_r[2] = (grid[location] & grid[location - 2] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location + 3] & grid[location + 1]);
		horiz_r[3] = 0;
    end
	 else if(location == 77 || location == 63 || location == 49 || location == 35 || location == 21 || location == 7)
	 begin
		horiz_r[0] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location - 6]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location - 7]);
	   horiz_r[1] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location + 1]);
      horiz_r[2] = (grid[location] & grid[location - 2] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location + 3] & grid[location + 1]);
		horiz_r[3] = (grid[location] & grid[location + 6] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location + 5] & grid[location + 3] & grid[location + 1]);
    end
	 else if(location == 75 || location == 61 || location == 47 || location == 33 || location == 19 || location == 5)
    begin
		horiz_r[0] = 0;
	   horiz_r[1] = (grid[location] & grid[location - 2] & grid[location - 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location - 5] & grid[location + 1]);
      horiz_r[2] = (grid[location] & grid[location - 2] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location + 3] & grid[location + 1]);
		horiz_r[3] = (grid[location] & grid[location + 6] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location + 5] & grid[location + 3] & grid[location + 1]);
    end
	 else if(location == 73 || location == 59 || location == 45 || location == 31 || location == 17 || location == 3)
	 begin
		horiz_r[1:0] = 0;     
	   horiz_r[2] = (grid[location] & grid[location - 2] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location - 3] & grid[location + 3] & grid[location + 1]);
		horiz_r[3] = (grid[location] & grid[location + 6] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location + 5] & grid[location + 3] & grid[location + 1]);
    end
	 else if(location == 71 || location == 57 || location == 43 || location == 29 || location == 15 || location == 1)
	 begin  
		horiz_r[2:0] = 0;
		horiz_r[3] = (grid[location] & grid[location + 6] & grid[location + 4] & grid[location + 2]) | (grid[location - 1] & grid[location + 5] & grid[location + 3] & grid[location + 1]);
    end

    // diagonal up (left to right)
	 // last
	 if(location == 77 || location == 75|| location == 73 || location == 71 || location == 57 || location == 43)
	 begin
	   diagup_r[0] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location - 36]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location - 37]);
	   diagup_r[3:1] = 0;
	 end
	 // last or third
	 else if(location == 63 || location == 61 || location == 59 || location == 45)
	 begin
	   diagup_r[0] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location - 36]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location - 37]);
	   diagup_r[1] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location + 11]);
      diagup_r[3:2] = 0;
    end
	 // last or third or second
	 else if(location == 49 || location == 47)
	 begin
	   diagup_r[0] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location - 36]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location - 37]);
	   diagup_r[1] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location + 11]);
      diagup_r[2] = (grid[location] & grid[location - 12] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location + 23] & grid[location + 11]);
      diagup_r[3] = 0;
	 end
	 // first
	 else if(location == 13 || location == 11 || location == 9 || location == 7 || location == 27 || location == 41)
	 begin
		diagup_r[0] = 0;
	   diagup_r[1] = 0;
      diagup_r[2] = 0;
      diagup_r[3] = (grid[location] & grid[location +  36] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location + 35] & grid[location + 23] & grid[location + 11]);
	 end
	 // first or second
	 else if(location == 25 || location == 23 || location == 21 || location == 39)
	 begin
	   diagup_r[0] = 0;
	   diagup_r[1] = 0;
      diagup_r[2] = (grid[location] & grid[location - 12] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location + 23] & grid[location + 11]);
      diagup_r[3] = (grid[location] & grid[location +  36] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location + 35] & grid[location + 23] & grid[location + 11]);
	 end
	 // first or second or third
	 else if(location == 37 || location == 35)
	 begin
	   diagup_r[0] = 0;
	   diagup_r[1] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location + 11]);
      diagup_r[2] = (grid[location] & grid[location - 12] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location + 23] & grid[location + 11]);
      diagup_r[3] = (grid[location] & grid[location +  36] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location + 35] & grid[location + 23] & grid[location + 11]);
	 end
	 // second or third
	 else if(location == 51 || location == 33)
	 begin
	   diagup_r[0] = 0;
	   diagup_r[1] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location + 11]);
      diagup_r[2] = (grid[location] & grid[location - 12] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location + 23] & grid[location + 11]);
      diagup_r[3] = 0;
	 end
	 // second
	 else if(location == 19 || location == 53)
	 begin
	   diagup_r[0] = 0;
	   diagup_r[1] = 0;
      diagup_r[2] = (grid[location] & grid[location - 12] & grid[location + 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location + 23] & grid[location + 11]);
      diagup_r[3] = 0;
	 end
	 // third
	 else if(location == 65 || location == 31)
	 begin
	   diagup_r[0] = 0;
	   diagup_r[1] = (grid[location] & grid[location - 12] & grid[location - 24] & grid[location + 12]) | (grid[location - 1] & grid[location - 13] & grid[location - 25] & grid[location + 11]);
      diagup_r[2] = 0;
      diagup_r[3] = 0;    
	 end
	 
	 // diagonal down (left to right)
	 // last
	 if(location == 7 || location == 5 || location == 3 || location == 1 || location == 15 || location == 29)
	 begin
	   diagdown_r[0] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location + 48]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location + 47]);
	   diagdown_r[3:1] = 0;
	 end
	 // last or third
	 else if(location == 21 || location == 19 || location == 17 || location == 31)
	 begin
      diagdown_r[0] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location + 48]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location + 47]);
	   diagdown_r[1] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location - 17]);
      diagdown_r[3:2] = 0;
    end
	 // last or third or second
	 else if(location == 35 || location == 33)
	 begin
	   diagdown_r[0] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location + 48]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location + 47]);
	   diagdown_r[1] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location - 17]);
      diagdown_r[2] = (grid[location] & grid[location + 16] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location - 33] & grid[location - 17]);
	   diagdown_r[3] = 0;
	 end
	 // first
	 else if(location == 83 || location == 81 || location == 79 || location == 77 || location == 69 || location == 55)
	 begin
		diagdown_r[0] = 0;
	   diagdown_r[1] = 0;
      diagdown_r[2] = 0;
      diagdown_r[3] = (grid[location] & grid[location - 48] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location - 49] & grid[location - 33] & grid[location - 17]);
    end
	 // first or second
	 else if(location == 67 || location == 65 || location == 63 || location == 53)
	 begin
	   diagdown_r[0] = 0;
	   diagdown_r[1] = 0;
      diagdown_r[2] = (grid[location] & grid[location + 16] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location - 33] & grid[location - 17]);
	   diagdown_r[3] = (grid[location] & grid[location - 48] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location - 49] & grid[location - 33] & grid[location - 17]);
	 end
	 // first or second or third
	 else if(location == 51 || location == 49)
	 begin
	   diagdown_r[0] = 0;
      diagdown_r[1] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location - 17]);
      diagdown_r[2] = (grid[location] & grid[location + 16] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location - 33] & grid[location - 17]);
      diagdown_r[3] = (grid[location] & grid[location - 48] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location - 49] & grid[location - 33] & grid[location - 17]);
	 end
	 // second or third
	 else if(location == 37 || location == 47)
	 begin
	   diagdown_r[0] = 0;
      diagdown_r[1] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location - 17]);
      diagdown_r[2] = (grid[location] & grid[location + 16] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location - 33] & grid[location - 17]);
      diagdown_r[3] = 0;
	 end
	 // second
	 else if(location == 61 || location == 39)
	 begin
	   diagdown_r[0] = 0;
	   diagdown_r[1] = 0;
      diagdown_r[2] = (grid[location] & grid[location + 16] & grid[location - 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location - 33] & grid[location - 17]);
      diagdown_r[3] = 0;
	 end
	 // third
	 else if(location == 23 || location == 45)
	 begin
	   diagdown_r[0] = 0;
      diagdown_r[1] = (grid[location] & grid[location + 16] & grid[location + 32] & grid[location - 16]) | (grid[location - 1] & grid[location + 15] & grid[location + 31] & grid[location - 17]);
      diagdown_r[2] = 0;
      diagdown_r[3] = 0;    
	 end
  end
endmodule
