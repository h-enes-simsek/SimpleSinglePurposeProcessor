`timescale 1ns / 1ps
module SHIFT_CIRC_LEFT_8(
	input [7:0] a,
	output [7:0] r
    );

(* dont_touch *) assign r = {a[6:0],a[7]};

endmodule
