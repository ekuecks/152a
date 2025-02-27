`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:24 03/07/2017 
// Design Name: 
// Module Name:    debounce 
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
module debounce(
    left, right, middle, rst,
	 btnL, btnR, btnM, btnT, debounce_clk
    );
   output left;
	output right;
	output middle;
	output rst;
	
	//input clk;
	input debounce_clk;
	input btnL;
	input btnR;
	input btnM;
	input btnT;
	
	//wire clk;
	wire debounce_clk;
	wire btnL;
	wire btnR;
	wire btnM;
	wire btnT;
	
   reg [1:0]   arst_ff;
   wire        rst;
   wire        arst_i;

   assign arst_i = btnT;
   assign rst = arst_ff[0];
	
	always @ (posedge debounce_clk or posedge arst_i)
   begin
	  if (arst_i)
       arst_ff <= 2'b11;
     else
	  begin
	    arst_ff <= {1'b0, arst_ff[1]};
	  end
   end

	
	reg [10:0]   aleft_ff;
   wire        left;
   wire        aleft_i;

   assign aleft_i = btnL;
   assign left = aleft_ff[0];
	
	always @ (posedge debounce_clk)// or posedge aleft_i)
   begin
	  if (aleft_i)
       aleft_ff <= 11'b11111111111;
     else
	  begin
	    aleft_ff <= {1'b0, aleft_ff[10:1]};
	  end
   end
	
	reg [10:0]   aright_ff;
   wire        right;
   wire        aright_i;

   assign aright_i = btnR;
   assign right = aright_ff[0];
	
	always @ (posedge debounce_clk)// or posedge aright_i)
   begin
	  if (aright_i)
       aright_ff <= 11'b11111111111;
     else
	  begin
	    aright_ff <= {1'b0, aright_ff[10:1]};
	  end
   end

	
	reg [10:0]   amiddle_ff;
   wire        middle;
   wire        amiddle_i;

   assign amiddle_i = btnM;
   assign middle = amiddle_ff[0];
	
	always @ (posedge debounce_clk) // or posedge amiddle_i)
   begin
	  if (amiddle_i)
       amiddle_ff <= 11'b11111111111;
     else
	  begin
	    amiddle_ff <= {1'b0, amiddle_ff[10:1]};
	  end
   end
endmodule
