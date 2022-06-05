`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/05 03:28:57
// Design Name: 
// Module Name: ARM_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ARM_ALU (ALUctl, A, B, ALUOut, Zero, Overflow, Carryout);
    input [10:0] ALUctl;
    input [63:0] A, B;
    output reg [63:0] ALUOut;
    output reg Zero, Overflow, Carryout;
    always @ (ALUctl, A, B) 
    begin
        case (ALUctl)
            //add
            11'b00000100000:
                begin
                ALUOut = A + B;
                Overflow = ((A[63] == B[63]) && (~ALUOut[63] == A[63])) ? 1 : 0;
                Zero = (ALUOut == 0) ? 1 : 0;
                Carryout=0;
                end
            //addu
            11'b00000100001:
                begin
                {Carryout, ALUOut} = A + B;
                Zero = (ALUOut == 0) ? 1 : 0;
                Overflow=0;
                end
            //sub
            11'b00000100010:
                begin
                ALUOut = A - B;
                Overflow = ((A[63] == 0 && A[63] == 1 && ALUOut[63] == 1) || (A[63] == 1 && B[63] == 0 && ALUOut[63] == 0)) ? 1 : 0;
                Zero = (A == B) ? 1 : 0;
                Carryout = 0;
                end
            //subu
            11'b00000100011:
                begin
                {Carryout,ALUOut} = A - B;
                Zero = (ALUOut == 0) ? 1 : 0;
                Overflow=0;
                end
            //and
            11'b00000100100:
                begin
                ALUOut = A & B;
                Zero = (ALUOut == 0) ? 1 : 0;
                Carryout = 0;
                Overflow = 0;
                end
            //or
            11'b00000100101:
                begin
                ALUOut = A | B;
                Zero = (ALUOut == 0) ? 1 : 0;
                Carryout = 0;
                Overflow = 0;
                end
            //xor
            11'b00000100110:
                begin
                ALUOut = A ^ B;
                Zero = (ALUOut == 0) ? 1 : 0;
                Carryout = 0;
                Overflow = 0;
                end
            //nor
            11'b00000100111:
                begin
                ALUOut = ~(A | B);
                Zero = (ALUOut == 0) ? 1 : 0;
                Carryout = 0;
                Overflow = 0;
                end
            //slt
            11'b00000101010:
                begin                        
                if(A[63] == 1 && B[63] == 0)
                    ALUOut = 1;
                else if(A[63] == 0 && B[63] == 1)
                    ALUOut = 0;
                else 
                    ALUOut = (A < B)? 1 : 0;
                Overflow = ALUOut; 
                 Zero = (ALUOut == 0) ? 1 : 0;
                  Carryout=0;              
                 end
            //sltu
            11'b00000101011:
                begin
                    ALUOut = (A < B) ? 1 : 0;
                    Carryout = ALUOut;
                    Zero = (ALUOut == 0) ? 1 : 0;
                    Overflow = 0;
                end
            //shl
            11'b00000000100:
                begin
                {Carryout, ALUOut} = A << B;
                Overflow = 0;
                Zero = (ALUOut == 0) ? 1 : 0;
                end
            //shr
            11'b00000000110:
                begin
                ALUOut = A >> B;
                Carryout = A[B - 1];
                Overflow = 0;
                Zero = (ALUOut == 0) ? 1 : 0;
                end
            //sar
            11'b00000000111:
                begin
                ALUOut = ($signed(A)) >>> B;
                Carryout = A[B - 1];
                Overflow = 0;
                Zero = (ALUOut == 0) ? 1 : 0;
                end
        endcase
    end
endmodule
