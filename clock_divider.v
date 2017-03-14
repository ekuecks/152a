`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:56 02/28/2017 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
    display_clk, debounce_clk, game_clk,
	 clk
    );
  input clk;
  output display_clk;
  output debounce_clk;
  output game_clk;
  
  wire clk;
  wire display_clk;
  wire debounce_clk;
  wire game_clk;
  assign game_clk = display_clk;
  
  reg [1:0] display_counter;
  wire [2:0] display_counter_inc;
  assign display_counter_inc = display_counter + 1;
  assign display_clk = display_counter_inc[2];
  
  reg [16:0] debounce_counter;
  wire [17:0] debounce_counter_inc;
  assign debounce_counter_inc = debounce_counter + 1;
  assign debounce_clk = debounce_counter_inc[17];
  
  always @(posedge clk)
  begin
    display_counter = (display_counter + 1) % 4;
	 debounce_counter = (debounce_counter + 1) % 131072;
  end
endmodule
