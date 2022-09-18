`timescale 1ns / 1ps
module AND_8(
	input [7:0] a,
	input [7:0] b,
	output [7:0] r);

(* dont_touch *) assign r = a & b;
endmodule
