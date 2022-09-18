`timescale 1ns / 1ps
module CU(
    input Start,
	input clk,
	input reset,
	input CO,
	input Z,
	output reg[1:0] InsSel,
	output reg[3:0] RegAdd,
	output reg[3:0] OutMuxAdd,
	output reg[2:0] InMuxAdd,
	output reg[7:0] CUconst,
	output reg Busy,
	output reg WE
    );

    (* dont_touch *)
    localparam [3:0]
        idle = 4'd0,
        resetQ = 4'd1,
        getDivident = 4'd2,
        getDivider = 4'd3,
        divideByZero = 4'd4,
        twosComplement_1 = 4'd5,
        twosComplement_2 = 4'd6,
        twosComplement_3 = 4'd7,
        twosComplement_4 = 4'd8,
        getDividentAndSubs = 4'd9,
        controlResult = 4'd10,
        increaseQ_1 = 4'd11,
        increaseQ_2 = 4'd12,
        increaseQ_3 = 4'd13,
        outputQ = 4'd14;

    (* dont_touch *)
    reg [4:0]state_next, state_reg;

    always @(posedge clk, posedge reset) begin
        if (reset==1) //asynchronous reset
            state_reg <= idle; 
        else
            state_reg <= state_next;
    end

    always @(*)
    begin

        case(state_reg)
        
            idle:
            begin
                Busy <= 1'b0; //ready to action
                if(Start)
                state_next <= resetQ;
            end
            
            resetQ:
            begin
                RegAdd <= 4'd14; //reg14 is reversed for Q
                InMuxAdd <= 3'd2; //input: const
                CUconst <= 8'b00000000; //Q=reg14=0
                WE <= 1'b1;
                
                Busy <= 1'b1;
                state_next <= getDivident;
            end
            
            getDivident:
            begin
                RegAdd <= 4'd15; //reg15 is reserved for N ** N=N-D
                InMuxAdd <= 3'd0; //inA
                WE <= 1'b1;
                

                state_next <= getDivider;
            end

            getDivider:
            begin
                RegAdd <= 4'd1;
                InMuxAdd <= 3'd1; //inB
                WE <= 1'b1;
                InsSel <= 2'd3; //circ left
                

                state_next <= divideByZero;
            end
            
            divideByZero:
            begin

                if(Z) begin
                    RegAdd <= 4'd0; //output is zero
                    InMuxAdd <= 3'd2; //input: const
                    CUconst <= 8'b00000000; 
                    WE <= 1'b1;
                    state_next <= idle; 
                end
                else
                    state_next <= twosComplement_1;
            end
            
            twosComplement_1:
            begin
                RegAdd <= 4'd2;
                InMuxAdd <= 3'd2; //input: const
                CUconst <= 8'b11111111; 
                WE <= 1'b1;
                InsSel <= 2'd1; //xor (D, 11111111)
                

                state_next <= twosComplement_2;
            end
            
            twosComplement_2:
            begin
                RegAdd <= 4'd2;
                InMuxAdd <= 3'd3; //in: ALU
                WE <= 1'b1;
                
                

                state_next <= twosComplement_3;
            end
            
            twosComplement_3:
            begin
                RegAdd <= 4'd1;
                InMuxAdd <= 3'd2; //in: const
                WE <= 1'b1;
                CUconst <= 8'b00000001; 
                InsSel <= 2'd2; //add 1+ (D xor 1111_1111)
                

                state_next <= twosComplement_4;
            end
            
            twosComplement_4: //write two's compl. of divider
            begin
                RegAdd <= 4'd2;
                InMuxAdd <= 3'd3; //in: alu
                WE <= 1'b1;
                

                state_next <= getDividentAndSubs;
            end
            
            getDividentAndSubs: //reg15(N) to reg1 
            begin
                RegAdd <= 4'd1;
                InMuxAdd <= 3'd4; //in: internal
                OutMuxAdd <= 4'd15; //out: internal reg
                WE <= 1'b1; 
                InsSel <= 2'd2; //add N-D (N+twoComp(D))
                

                state_next <= controlResult;
            end
            
            controlResult: //control result is found or not
            begin
                // if CO is 0 sum is negative, if CO is 1 sum is non-negative
                if(CO==1) begin //calculation continue    
                    //write result(Q) to reg15       
                    RegAdd <= 4'd15; 
                    InMuxAdd <= 3'd3; //in: alu
                    WE <= 1'b1;
                     

                    state_next <= increaseQ_1;
                end
                else begin //calculation is done
                    //move Q, reg15 to reg0 (out)
                    RegAdd <= 4'd0; 
                    OutMuxAdd <= 4'd15; //out: internal reg
                    InMuxAdd <= 3'd4; //in: internal reg
                    WE <= 1'b1;
                     

                    state_next <= outputQ;
                end
            end
            
            increaseQ_1: //reg14 to reg1
            begin
                RegAdd <= 4'd1;
                OutMuxAdd <= 4'd14; //out: internal reg
                InMuxAdd <= 3'd4; //in: internal reg
                WE <= 1'b1; 
                

                state_next <= increaseQ_2;
            end
            
            increaseQ_2: //8'd1 to reg2 and sum with reg1
            begin
                RegAdd <= 4'd2;
                InMuxAdd <= 3'd2; //in: const
                WE <= 1'b1;
                CUconst <= 8'b00000001; 
                InsSel <= 2'd2; //add Q+1
                

                state_next <= increaseQ_3;
            end
            
            increaseQ_3: //write increased Q to reg14
            begin
                RegAdd <= 4'd14;
                InMuxAdd <= 3'd3; //in: alu
                WE <= 1'b1; 
                

                state_next <= getDivider; //return back to getDivider
            end
            
            outputQ: //write output Q (reg14 to reg0)
            begin
                RegAdd <= 4'd0; 
                OutMuxAdd <= 4'd14; //out: internal reg
                InMuxAdd <= 3'd4; //in: internal reg
                WE <= 1'b1; 
                
                Busy <= 1'b0; //now busy is low
                state_next <= idle; //return back to getDivider
            end
            

            default:
                state_next <= idle;
        endcase
    end

endmodule
