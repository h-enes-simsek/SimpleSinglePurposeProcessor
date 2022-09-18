`timescale 1ns / 1ps
module DECODER_4_16(
	input [3:0]RegAdd,
	input WE,
	output reg [15:0]Out
    );

(* dont_touch *) 
always @(*) begin
	if(WE == 0)
		Out = 0; //select nothing
	else begin
		case(RegAdd)
			4'b0000: Out = 16'd1;
			4'b0001: Out = 16'd2;
			4'b0010: Out = 16'd4;
			4'b0011: Out = 16'd8;
			4'b0100: Out = 16'd16;
			4'b0101: Out = 16'd32;
			4'b0110: Out = 16'd64;
			4'b0111: Out = 16'd128;
			4'b1000: Out = 16'd256;
			4'b1001: Out = 16'd512;
			4'b1010: Out = 16'd1024;
			4'b1011: Out = 16'd2048;
			4'b1100: Out = 16'd4096;
			4'b1101: Out = 16'd8192;
			4'b1110: Out = 16'd16384;
			4'b1111: Out = 16'd32768;
		endcase
	end
end

endmodule
