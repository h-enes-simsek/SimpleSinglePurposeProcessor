`timescale 1ns / 1ps
module ALU(
	input [7:0] ALUinA,
	input [7:0] ALUinB,
	input [1:0] InsSel,
	output [7:0] ALUout,
	output CO,
	output Z
    );
    
	(* dont_touch *) wire [7:0] ANDout, XORout, ADDout, SHIFTout;
	(* dont_touch *) wire carry_out;
	
	(* dont_touch *) //AND module
	AND_8 and8(.a(ALUinA),.b(ALUinB),.r(ANDout));	
	
	(* dont_touch *) //XOR module
	XOR_8 xor8(.a(ALUinA),.b(ALUinB),.r(XORout));   
	
	(* dont_touch *) //8-bit ripple carry adder
	ADD_8 add8(.a(ALUinA),.b(ALUinB),.r(ADDout),.co(carry_out));	
	
	(* dont_touch *) //Circular Left Shift module
	SHIFT_CIRC_LEFT_8 shif8(.a(ALUinA),.r(SHIFTout));	
	
	(* dont_touch *) //Comparator Zero module
	COMP_ZERO_8 comp8(.a(ALUout),.Z(Z)); 
	
	(* dont_touch *) //4 input 8-bit Multiplexer for output of ALU
	MULTP_4 #(8) multp_out(.I0(ANDout),.I1(XORout),.I2(ADDout),.I3(SHIFTout),.S(InsSel),.O(ALUout));	
	
	(* dont_touch *) //4 input 1-bit Multiplexer for CO 
	MULTP_4 #(1) mulpt_co(.I0(1'b0),.I1(1'b0),.I2(carry_out),.I3(SHIFTout[0]),.S(InsSel),.O(CO));	

endmodule
