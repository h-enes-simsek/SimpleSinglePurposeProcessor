`timescale 1ns / 1ps
//N-bit parametric ripple carry adder
module ADD_8 #(parameter SIZE = 8)
(   input [SIZE-1:0] a, b, 
    output co, 
    output [SIZE-1:0] r);
    
    wire fac[SIZE-1:0];//ith full adder carry bit
    
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin: generated_fa
            //first fa gets CI as input, however in ALU CI=0
            if (i==0) begin: test1
                (* dont_touch *) full_adder fa(a[i],b[i],0,fac[i],r[i]); 
            end else
            //carry of the last fa is the CO
            if (i==SIZE-1) begin: test2
                (* dont_touch *) full_adder fa(a[i],b[i],fac[i-1],co,r[i]); 
            end else
            //fa's in the middle gets prev carry from prev fa,
            //send own carry to next fa
            (* dont_touch *) full_adder fa(a[i],b[i],fac[i-1],fac[i],r[i]);
        end
    endgenerate
endmodule
