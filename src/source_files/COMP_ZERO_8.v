`timescale 1ns / 1ps
module COMP_ZERO_8(
	input [7:0] a,
	output reg Z
    );

    (* dont_touch *)
    always @* begin
        if(a==0)
            Z=1;
        else
            Z=0;
    end
endmodule
