`timescale 1ns / 1ps
module TB_ALU();

reg [7:0] ALUinA;
reg [7:0] ALUinB;
reg [1:0] InsSel;

wire [7:0] ALUout;
wire CO;
wire Z;

ALU uut(
    .ALUinA(ALUinA), 
    .ALUinB(ALUinB), 
    .InsSel(InsSel), 
    .ALUout(ALUout), 
    .CO(CO), 
    .Z(Z)
);

initial begin
    ALUinA = 0;
    ALUinB = 0;
    //wait 100ns to get correct results 
    //from post imp timing sim and post syn timing sim
    //FPGA will be under global reset
    #100;

    InsSel = 0; //and
    ALUinA = 8'b01100001;
    ALUinB = 8'b10010101;
    #50;
    
    InsSel = 2'b01; //xor
    ALUinA = 8'b00101001;
    ALUinB = 8'b10000001;
    #50;
    
    InsSel = 2'b10; //signed addder
    ALUinA = 8'b01100001; //97
    ALUinB = 8'b01100111; //103
    #50;                  //R=200
    
    InsSel = 2'b11; //circ shift left
    ALUinA = 8'b11001001;
    #50;
    
    $finish();	
end
      
endmodule
