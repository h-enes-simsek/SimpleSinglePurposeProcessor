`timescale 1ns / 1ps
module REGISTER #(parameter N=8)(
	input clk,
	input reset,
	input En,
	input [N-1:0] Rin,
	output reg [N-1:0] Rout
    );

    (* dont_touch *) reg [N-1:0]reg_next;
    (* dont_touch *) reg [N-1:0]reg_out;
    
    (* dont_touch *) //asynchronous reset
    always @(posedge clk, posedge reset) begin
        if(reset==1)
            reg_out <= 0;
        else
            reg_out <= reg_next;
    end
    
    (* dont_touch *) //enable activates register
    always @(*) begin
        if(En)
            reg_next = Rin;
        else
            reg_next = reg_out;
    end
    
    (* dont_touch *) //if both enable and reset signals are low, output is unchanged
    always @(*) begin
        Rout = reg_out;
    end
    
endmodule

