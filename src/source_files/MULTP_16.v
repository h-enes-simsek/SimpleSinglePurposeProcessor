`timescale 1ns / 1ps
module MULTP_16 #(parameter N=8)(
    //input: 16 N-bit
    //output 1 N-bit
	input [N-1:0]I0,
	input [N-1:0]I1,
	input [N-1:0]I2,
	input [N-1:0]I3,
	input [N-1:0]I4,
	input [N-1:0]I5,
	input [N-1:0]I6,
	input [N-1:0]I7,
	input [N-1:0]I8,
	input [N-1:0]I9,
	input [N-1:0]I10,
	input [N-1:0]I11,
	input [N-1:0]I12,
	input [N-1:0]I13,
	input [N-1:0]I14,
	input [N-1:0]I15,
	input [3:0]S,
	output reg [N-1:0]O
    );

(* dont_touch *)
always @* begin
	case(S)
		4'b0000: O = I0;
		4'b0001: O = I1;
		4'b0010: O = I2;
		4'b0011: O = I3;
		4'b0100: O = I4;
		4'b0101: O = I5;
		4'b0110: O = I6;
		4'b0111: O = I7;
		4'b1000: O = I8;
		4'b1001: O = I9;
		4'b1010: O = I10;
		4'b1011: O = I11;
		4'b1100: O = I12;
		4'b1101: O = I13;
		4'b1110: O = I14;
		4'b1111: O = I15;
	endcase
end

endmodule


