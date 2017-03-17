`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:24 02/23/2017 
// Design Name: 
// Module Name:    display 
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
module display(
    // output
    vgaRed, vgaGreen, vgaBlue, Hsync, Vsync,
	 // input
	 clk, display_clk, grid, winner, term
    );
	output vgaRed;
	output vgaGreen;
	output vgaBlue;
	output Hsync;
	output Vsync;
	
	input clk;
	input display_clk;
	input grid;
	input winner;
	input term;
	
   reg [2:0] vgaRed;
	reg [2:0] vgaGreen;
	reg [1:0] vgaBlue;
	reg [9:0] columns = 0;
	reg [9:0] rows = 0;
	reg [6:0] row_cycle = 0;
	reg [2:0] col_count;
	reg [2:0] row_count;
	reg [6:0] col_cycle = 0;
	wire Hsync;
	wire Vsync;
	wire clk;
	wire display_clk;
	wire [97:0] grid;
	wire [1:0] winner;
	wire term;
	
	parameter hpixels = 800;// horizontal pixels per line
   parameter vlines = 521; // vertical lines per frame
   parameter hpulse = 96; 	// hsync pulse length
   parameter vpulse = 2; 	// vsync pulse length
   parameter hbp = 144; 	// end of horizontal back porch
   parameter hfp = 784; 	// beginning of horizontal front porch
   parameter vbp = 31; 		// end of vertical back porch
   parameter vfp = 511; 	// beginning of vertical front porch
	parameter side = 59;
	parameter h = 6;
	parameter top = 9;
	parameter bottom = 9;
	parameter left = 92;
	parameter right = 92;
	parameter selection_space = side + h + h;
   // active horizontal video is therefore: 784 - 144 = 640
   // active vertical video is therefore: 511 - 31 = 480*/
	
	assign Hsync = (columns < hpulse) ? 1'b0 : 1'b1;
	assign Vsync = (rows < vpulse) ? 1'b0 : 1'b1;
	
   always @ (posedge clk)
	begin
	  if(display_clk)
	  begin
       if(columns < hpixels - 1)
	    begin
	      columns <= (columns + 1) % 1024;
	    end
	    else
	    begin
	      columns <= 0;
			col_cycle <= 0;
			col_count <= 0;
		   if (rows < vlines - 1)
		   begin
	        rows <= (rows + 1) % 1024;
		   end
		   else
		   begin
		     rows <= 0;
			  row_cycle <= 0;
			  row_count <= 0;
		   end
			if (rows >= vbp + selection_space + top && rows <= vfp - bottom)
		   begin
		 	  row_cycle <= (row_cycle + 1) % 128;
			  if(row_cycle > side + h - 1)
			  begin
			    row_cycle <= 0;
				 row_count <= (row_count + 1) % 8;
		     end
		   end
	    end
		 if (columns >= hbp + left && columns <= hfp - right)
		 begin
		 	col_cycle <= (col_cycle + 1) % 128;
			if(col_cycle > side + h - 1)
			begin
			  col_cycle <= 0;
			  col_count <= (col_count + 1) % 8;
		   end
		 end
	  end
	end
	
	always @ (*)
	begin
	  if(term)
	  begin
	    if((rows < vbp || rows >= vfp) || (columns < hbp || columns >= hfp))
		 begin
		   vgaRed <= 0;
			vgaGreen <= 0;
			vgaBlue <= 0;
		 end
	    else if(winner[0])
		 begin
	      vgaRed <= 0;
		   vgaGreen <= 3'b111;
		   vgaBlue <= 0;
		 end
		 else if(winner[1])
		 begin
	      vgaRed <= 3'b111;
		   vgaGreen <= 0;
		   vgaBlue <= 0;
		 end
		 else
		 begin
		   vgaRed <= 0;
			vgaGreen <= 0;
			vgaBlue <= 0;
		 end
	  end
	  else
	  begin
	  if(rows >= vbp && rows < vfp)
	  begin
	    if (rows < vbp + h || (rows > vbp + h + side && rows < vbp + h + side + h))
		 begin
		   vgaRed <= 0;
         vgaGreen <= 0;
		   vgaBlue <= 0;
		 end
		 else if (rows >= vbp + h && rows <= vbp + h + side)
		 begin
			if (columns >= hbp + left && columns < hfp - right && col_cycle <= side)
			begin
			  if(grid[97-col_count*2-:2] == 2'b01)
			  begin
			    vgaRed <= 0;
			    vgaGreen <= 3'b111;
			    vgaBlue <= 0;
			  end
			  else if(grid[97-col_count*2-:2] == 2'b10)
			  begin
			    vgaRed <= 3'b111;
			    vgaGreen <= 0;
			    vgaBlue <= 0;
			  end
			  else
			  begin
			    vgaRed <= 0;
			    vgaGreen <= 0;
			    vgaBlue <= 0;
			  end
			end
			else
			begin
			  vgaRed <= 0;
			  vgaGreen <= 0;
			  vgaBlue <= 0;
			end
		 end
		 else if(rows <= vbp + selection_space + top || rows > vfp - bottom)
		 begin
		   vgaRed <= 0;
			vgaGreen <= 0;
			vgaBlue <= 2'b11;
		 end
		 else
		 begin
		   if (columns < hbp || columns >= hfp)
			begin
			  vgaRed <= 0;
			  vgaGreen <= 0;
			  vgaBlue <= 0;
			end
		   else if(row_cycle <= side)
			begin
			  if (columns < hbp + left || columns >= hfp - right)
			  begin
			    vgaRed <= 0;
			    vgaGreen <= 0;
			    vgaBlue <= 2'b11;
			  end
			  else if (col_cycle <= side)
			  begin
			    if(grid[83-row_count*14-col_count*2-:2] == 2'b01)
			    begin
			      vgaRed <= 0;
			      vgaGreen <= 3'b111;
			      vgaBlue <= 0;
			    end
			    else if(grid[83-row_count*14-col_count*2-:2] == 2'b10)
			    begin
			      vgaRed <= 3'b111;
			      vgaGreen <= 0;
			      vgaBlue <= 0;
			    end
			    else
			    begin
			      vgaRed <= 0;
			      vgaGreen <= 0;
			      vgaBlue <= 0;
			    end
			  end
			  else if (columns >= hbp && columns < hfp)
			  begin
			    vgaRed <= 0;
				 vgaGreen <= 0;
				 vgaBlue <= 2'b11;
			  end
			  else
			  begin
			    vgaRed <= 0;
				 vgaGreen <= 0;
				 vgaBlue <= 0;
			  end
			end
			else
			begin
			  vgaRed <= 0;
			  vgaGreen <= 0;
			  vgaBlue <= 2'b11;
			end
		 end
	  end
	  else
	  begin
	    vgaRed <= 0;
		 vgaGreen <= 0;
		 vgaBlue <= 0;
	  end
	  end
   end
endmodule
