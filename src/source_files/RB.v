`timescale 1ns / 1ps
module RB(
    //This design has 16 8-b registers.
    //reserved registers: R0-external out, R1-ALUinput1, R2-ALU-input2
    //R3-R15 registers are general purpose registers
    input clk,
	input reset,
	
	input [7:0]InA, //external input
	input [7:0]InB, //external input
	input [7:0]CUconst, //output of the CU
	input [7:0]ALUout, //output of the ALU
	input [2:0]InMuxAdd, //Mux to select input
	input WE, //Write enable for registers
	input [3:0]RegAdd, //register adress
	input [3:0]OutMuxAdd, //Mux to select output
	
	output [7:0]Out, //external output
	output [7:0]ALUinA, //to input of ALU
	output [7:0]ALUinB //to input of ALU
	);
	
	wire [15:0]Decoder_Out; //will enable selected register with 4-b RegAdd
	wire [7:0]RegOut; //output of selected register (need to build general purpose registers)
	wire [7:0]RegIn; //input of the registers
	wire [7:0]Rout [15:0]; //output of the registers

	(* dont_touch *) //4 to 16 decoder enables selected register
	DECODER_4_16 decoder(.RegAdd(RegAdd),.WE(WE),.Out(Decoder_Out));	

	(* dont_touch *) //8 inputs 8-b mux (input selector)
	MULTP_8 #(.N(8)) mux_input(.I0(InA),.I1(InB),.I2(CUconst),.I3(ALUout),.I4(RegOut),.I5(RegOut) 
										,.I6(RegOut),.I7(RegOut),.S(InMuxAdd),.O(RegIn));
										
	(* dont_touch *) //16 inputs 8-b mux (output selector)	
	//general purpose registers R3-R15 								
	MULTP_16 #(.N(8)) mux_output(.I0(Rout[0]),.I1(Rout[1]),.I2(Rout[2]),.I3(Rout[3]),.I4(Rout[4]),.I5(Rout[5])
								,.I6(Rout[6]),.I7(Rout[7]),.I8(Rout[8]),.I9(Rout[9]),.I10(Rout[10]),.I11(Rout[11])
								,.I12(Rout[12]),.I13(Rout[13]),.I14(Rout[14]),.I15(Rout[15]),.S(OutMuxAdd),.O(RegOut));	
										
	//8-b register blocks
	(* dont_touch *) REGISTER #(.N(8)) reg0(.Rin(RegIn), .Rout(Rout[0]), .clk(clk), .En(Decoder_Out[0]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg1(.Rin(RegIn), .Rout(Rout[1]), .clk(clk), .En(Decoder_Out[1]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg2(.Rin(RegIn), .Rout(Rout[2]), .clk(clk), .En(Decoder_Out[2]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg3(.Rin(RegIn), .Rout(Rout[3]), .clk(clk), .En(Decoder_Out[3]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg4(.Rin(RegIn), .Rout(Rout[4]), .clk(clk), .En(Decoder_Out[4]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg5(.Rin(RegIn), .Rout(Rout[5]), .clk(clk), .En(Decoder_Out[5]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg6(.Rin(RegIn), .Rout(Rout[6]), .clk(clk), .En(Decoder_Out[6]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg7(.Rin(RegIn), .Rout(Rout[7]), .clk(clk), .En(Decoder_Out[7]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg8(.Rin(RegIn), .Rout(Rout[8]), .clk(clk), .En(Decoder_Out[8]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg9(.Rin(RegIn), .Rout(Rout[9]), .clk(clk), .En(Decoder_Out[9]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg10(.Rin(RegIn), .Rout(Rout[10]), .clk(clk), .En(Decoder_Out[10]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg11(.Rin(RegIn), .Rout(Rout[11]), .clk(clk), .En(Decoder_Out[11]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg12(.Rin(RegIn), .Rout(Rout[12]), .clk(clk), .En(Decoder_Out[12]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg13(.Rin(RegIn), .Rout(Rout[13]), .clk(clk), .En(Decoder_Out[13]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg14(.Rin(RegIn), .Rout(Rout[14]), .clk(clk), .En(Decoder_Out[14]), .reset(reset));
	(* dont_touch *) REGISTER #(.N(8)) reg15(.Rin(RegIn), .Rout(Rout[15]), .clk(clk), .En(Decoder_Out[15]), .reset(reset));

	assign Out = Rout[0]; // R0 is reserved for external output
	assign ALUinA = Rout[1]; // R1 is reserved for ALU input
	assign ALUinB = Rout[2]; // R2 is reserved for ALU input

endmodule

