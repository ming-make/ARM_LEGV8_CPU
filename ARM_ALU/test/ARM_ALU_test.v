`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/05 04:07:13
// Design Name: 
// Module Name: ARM_ALU_test
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


module ARM_ALU_test(

    );
    reg [10:0] op;
    reg [63:0] in0,in1;
    wire [63:0] out;
    wire carryout,overflow,zero;
    ARM_ALU alu(op,in0,in1,out,zero,carryout,overflow);
    initial
    begin
    //add
         op=11'b00000100000;        
         in0=64'h00000000f2340000;
         in1=64'h0000000080000000;
    #20  in0=64'h000000007fffffff;
         in1=64'h0000000070000001;
    #20  in0=64'h000000007fffffff;
         in1=64'h00000000f0000001;
    #20  in0=64'h00000000ffffffff;
         in1=64'h0000000000000001;
    //addu          
    #20  op=11'b00000100001;   
         in0=64'h00000000f2340000;
         in1=64'h0000000080000000;
    #20  in0=64'h000000007fffffff;
         in1=64'h0000000070000001;
    #20  in0=64'h00000000ffffffff;
         in1=64'h0000000000000001;
    end
endmodule
