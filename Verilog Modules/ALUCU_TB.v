`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 02:34:54 PM
// Design Name: 
// Module Name: ALUCU_TB
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


module ALUCU_TB(

    );
    
reg [1:0]ALUOp;
reg [3:0]Inst;
wire [3:0]ALUSel;
 ALUCU DUT(
ALUOp, 
Inst, 
ALUSel
    );
    initial begin
        ALUOp=2'b00;
        Inst=4'b0_000;
        #10
        ALUOp=2'b01;
        Inst=4'b0_000;
        #10
        ALUOp=2'b10;
        Inst=4'b1_101;
        #10
        ALUOp=2'b10;
        Inst=4'b1_001;
        //
        #10
        ALUOp=2'b10;
        Inst=4'b0_000;
        #10
        ALUOp=2'b10;
        Inst=4'b0_001;
        #10
        ALUOp=2'b10;
        Inst=4'b0_010;
        #10
        ALUOp=2'b10;
        Inst=4'b0_011;
        #10
        ALUOp=2'b10;
        Inst=4'b0_100;
        #10
        ALUOp=2'b10;
        Inst=4'b0_101;
        #10
        ALUOp=2'b10;
        Inst=4'b0_110;
        #10
        ALUOp=2'b10;
        Inst=4'b0_111;
        //
        #10
        ALUOp=2'b11;
        Inst=4'b1_000;
        #10
        ALUOp=2'b11;
        Inst=4'b1_001;
        #10
        ALUOp=2'b11;
        Inst=4'b1_010;
        #10
        ALUOp=2'b11;
        Inst=4'b1_011;
        #10
        ALUOp=2'b11;
        Inst=4'b1_100;
        #10
        ALUOp=2'b11;
        Inst=4'b1_101;
        #10
        ALUOp=2'b11;
        Inst=4'b1_110;
        #10
        ALUOp=2'b11;
        Inst=4'b1_111;
    end
endmodule
