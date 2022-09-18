`timescale 1ns / 1ps
module TOP(
    input clk,
	input reset,
	input Start,
	
	input [7:0]InA, //external input
	input [7:0]InB, //external input
	
	output Busy, //busy signal until CU is done
	output [7:0] Out //external output
    );
    
    //wires between CU and Reg Block
    wire [7:0]CUconst;
    wire [2:0]InMuxAdd;
    wire [3:0]OutMuxAdd;
    wire [3:0]RegAdd;
    wire WE;

    //wires between ALU and Reg Block
    wire [7:0]ALUinA;
    wire [7:0]ALUinB;
    wire [7:0]ALUout;
    
    //wires between CU and ALU
    wire CO,Z;
    wire [1:0]InsSel;
    
    (* dont_touch *)
    CU control_unit(.clk(clk),
                    .reset(reset),
                    .Start(Start),
                    .Busy(Busy),
                    .InsSel(InsSel),
                    .CO(CO),
                    .Z(Z),
                    .CUconst(CUconst),
                    .InMuxAdd(InMuxAdd),
                    .OutMuxAdd(OutMuxAdd),
                    .RegAdd(RegAdd),
                    .WE(WE));
    
    (* dont_touch *)
    ALU arithmetic_logic_unit(.InsSel(InsSel),
                              .CO(CO),
                              .Z(Z),
                              .ALUinA(ALUinA),
                              .ALUinB(ALUinB),
                              .ALUout(ALUout)
                              );

    (* dont_touch *)
    RB register_block(.clk(clk),
                      .reset(reset),        
                      .InA(InA),
                      .InB(InB),
                      .CUconst(CUconst),
                      .InMuxAdd(InMuxAdd),
                      .OutMuxAdd(OutMuxAdd),
                      .RegAdd(RegAdd),
                      .WE(WE),
                      .ALUinA(ALUinA),
                      .ALUinB(ALUinB),
                      .ALUout(ALUout),
                      .Out(Out));
    
endmodule
