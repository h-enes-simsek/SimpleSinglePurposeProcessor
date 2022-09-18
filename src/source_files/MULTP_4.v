`timescale 1ns / 1ps
module MULTP_4 #(parameter N=8)(
    //input: 4 N-bit
    //output 1 N-bit
	input [N-1:0]I0,
	input [N-1:0]I1,
	input [N-1:0]I2,
	input [N-1:0]I3,
	input [1:0]S,
	output reg [N-1:0]O
    );

(* dont_touch *)
always @* begin
	case(S)
		2'b00: O = I0;
		2'b01: O = I1;
		2'b10: O = I2;
		2'b11: O = I3;
	endcase
end

endmodule

