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
    display_clk,
	 clk
    );
  input clk;
  output display_clk;
  
  wire clk;
  wire display_clk;
  
  reg [1:0] display_counter;
  wire [2:0] display_counter_inc;
  assign display_counter_inc = display_counter + 1;
  assign display_clk = display_counter_inc[2];
  
  always @(posedge clk)
  begin
    display_counter = (display_counter + 1) % 4;
  end
endmodule
