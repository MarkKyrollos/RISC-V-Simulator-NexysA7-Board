`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 01:56:59 PM
// Design Name: 
// Module Name: CPU_TB
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


module CPU_TB(

    );
    reg[7:0] Instruction;
    wire Branch,MemRead,MemWrite,ALUSrc,RegWrite,Mux_RD1_PC,PC_load;
    wire [1:0]MemtoReg,ALUOp;
    CU DUT(
Instruction,
   Branch,
   MemRead,
MemtoReg,
ALUOp,
MemWrite,
   ALUSrc,
   RegWrite,
   Mux_RD1_PC,
   PC_load
    );
    
    initial begin
        Instruction={1'b0,5'b11_000,2'b11}; //OPCODE_Branch
        #10
        Instruction={1'b0,5'b00_000,2'b11}; //OPCODE_Load
        #10
        Instruction={1'b0,5'b01_000,2'b11}; //OPCODE_Store
        #10
        Instruction={1'b0,5'b11_001,2'b11}; //OPCODE_JALR
        #10
        Instruction={1'b0,5'b11_011,2'b11}; //OPCODE_JAL
        #10
        Instruction={1'b0,5'b00_100,2'b11}; //OPCODE_Arith_I
        #10
        Instruction={1'b0,5'b01_100,2'b11}; //OPCODE_Arith_R
        #10
        Instruction={1'b0,5'b00_101,2'b11}; //OPCODE_AUIPC
        #10
        Instruction={1'b0,5'b01_101,2'b11}; //OPCODE_LUI
        #10
        Instruction={1'b0,5'b11_100,2'b11}; //OPCODE_SYSTEM
        #10
        Instruction={1'b1,5'b11_100,2'b11}; //OPCODE_SYSTEM
        #10
        Instruction={1'b0,5'b00_011,2'b11}; //OPCODE_NOOP
        
    end
endmodule
