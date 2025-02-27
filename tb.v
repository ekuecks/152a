`timescale 1ns / 1ps

module tb;
   reg       clk;
   reg       btnR;
   reg       btnL;
	reg       btnM;
	reg       btnT;
	wire [2:0] vgaRed;
	wire [2:0] vgaGreen; 
	wire [1:0] vgaBlue; 
	wire Hsync;
	wire Vsync;
	reg sw = 1;

   // End of automatics

   initial
     begin
        //$shm_open  ("dump", , ,1);
        //$shm_probe (tb, "ASTF");

        clk = 0;
        btnR = 0;
        btnL = 0;
		  btnM = 0;
		  btnT = 0;
        #1000;
        
        #1000000;        
        $finish;
     end

   always #20 clk = ~clk;
	
	always
	begin
	  #1000;
	  btnR = 1;
	  #1000;
	  btnR = 0;
     #1000;
	  btnM = 1;
	  #1000;
	  btnM = 0;
/*	  #100;
	  btnR = 0;
	  #100;
	  btnR = 1;
	  #100;
	  btnR = 0;
	  #100;
	  btnR = 1;
	  #100;
	  btnR = 0;
	  #100;
	  btnM = 1;
	  #100;
	  btnM = 0;
	  #100;
	  btnL = 1;
	  #100;
	  btnL = 0;
	  #100;
	  btnL = 1;
	  #100;
	  btnL = 0;
	  #100;
	  btnL = 1;
	  #100;
	  btnL = 0;*/
	end
	  
   
   driver driver0_ (// Outputs
                            vgaRed, vgaGreen, vgaBlue, Hsync, Vsync,
									 clk, btnR, btnL, btnM, btnT, sw
                            /*AUTOINST*/);
endmodule // tb
// Local Variables:
// verilog-library-flags:("-y ../src/")
// End:
