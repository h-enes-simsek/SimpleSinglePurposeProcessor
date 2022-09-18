`timescale 1ns / 1ps

module half_adder(
    input A,B,
    output C,S
    );

(* dont_touch *) assign C = A & B;
(* dont_touch *) assign S = A ^ B; //XOR
    
endmodule

module full_adder(
    input A,B,CI,
    output CO,S
    );

(* dont_touch *) wire half_adder1_s,half_adder1_c;
(* dont_touch *) wire half_adder2_s,half_adder2_c;
(* dont_touch *) half_adder half_adder1(A,B,half_adder1_c,half_adder1_s);
(* dont_touch *) half_adder half_adder2(CI,half_adder1_s,half_adder2_c,half_adder2_s);
(* dont_touch *) assign CO = half_adder1_c | half_adder2_c;
(* dont_touch *) assign S = half_adder2_s;
endmodule




    
