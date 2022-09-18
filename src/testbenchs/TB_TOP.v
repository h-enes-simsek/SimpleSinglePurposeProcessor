`timescale 1ns / 1ps
module TB_TOP();

	reg clk;
	reg reset;
	reg Start;
	reg [7:0] InA;
	reg [7:0] InB;
	
	wire [7:0] Out;
	wire Busy;

	TOP uut (
		.clk(clk), 
		.reset(reset), 
		.Start(Start), 
		.InA(InA), 
		.InB(InB), 
		.Out(Out), 
		.Busy(Busy)
	);
	
	integer CLK_PERIOD = 20;
	always #(CLK_PERIOD/2) clk = ~clk;

	initial begin
        //initial conditions
		clk = 0;
		reset = 0;
		InA = 0;
		InB = 0;
		Start = 0;
		#(CLK_PERIOD/2);
        
        //----------------------------------------------------------------
		//Calculation: 17/8 (ordinary random numbers)
		//Result: Q=2 R=1
		Start = 1;
		InA = 8'd17; 
		InB = 8'd8; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#1000;
		
		//----------------------------------------------------------------
		//Calculation: 12/15 (divident is less than divider)
		//Result: Q=0 R=12
		Start = 1;
		InA = 8'd12; 
		InB = 8'd15; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#320;
		
		//----------------------------------------------------------------
		//Calculation: 0/13 (divident is zero)
		//Result: Q=0 R=0
		Start = 1;
		InA = 8'd0; 
		InB = 8'd13; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#320;
		
		//----------------------------------------------------------------
		//Calculation: 40/0 (divider is zero)
		//Result: Q=0 R=0
		Start = 1;
		InA = 8'd40; 
		InB = 8'd0; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#320;
		
		//----------------------------------------------------------------
		//Calculation: 0/0 (both divider and divident are zero)
		//Result: Q=0 R=0
		Start = 1;
		InA = 8'd0; 
		InB = 8'd0; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#320;
		
		//----------------------------------------------------------------
		//reset experiment
		//firstly ordinary numbers are given
		Start = 1;
		InA = 8'd213; 
		InB = 8'd8; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#400;
		
		reset = 1; //reset signal is high when calculations are running
		InA = 8'd13; 
		InB = 8'd5; 
		#(CLK_PERIOD);
		
		reset = 0;
		#(2*CLK_PERIOD);
		
		//calculator starts again and calculates correctly
		//calculation: 13/5
		//result: Q=2 R=3
		Start = 1;
			
		#(CLK_PERIOD);
		
		Start = 0;
		#800;
		
		//----------------------------------------------------------------
		//Calculation: 255/15 (max numbers Divident=8'1111_1111, Divider=8'0000_1111)
		//Note that divider is actually 4 bit. Zeros are for padding.
		//Result: Q=17 R=0
		Start = 1;
		InA = 8'd255; 
		InB = 8'd15; 	
		#(CLK_PERIOD);
		
		Start = 0;
		#4000;
		
		
		

		
	
		
	end
	
	
      
endmodule


