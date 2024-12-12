`include "defines.v"
`timescale 1ns / 1ps
/*******************************************************************
*
* Module: CU.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: Control Unit
*
* Change history: 23/10/24 – Made Instruction 7 bits, last bit will be inst[20] and will used to differentiate between Ecall and Ebreak
* - Made Instruction 7 bits, last bit will be inst[20] and will used to differentiate between Ecall and Ebreak
* - Modified the case to follow the guidelines
* - Handled All Insturction Control Signals
* - MemtoReg expanded to 2 bits.
* - Added Mux_RD1_PC to mux between RGF RD1 and PC
* - Added PC_load to stop when encountering ECALL
**********************************************************************/


module CU(
input [7:0]Instruction,
 output reg Branch,
 output reg MemRead,
 output reg [1:0]MemtoReg,
 output reg [1:0]ALUOp,
 output reg MemWrite,
 output reg ALUSrc,
 output reg RegWrite,
 output reg Mux_RD1_PC,
 output reg PC_load
    );
    always@(*)
    begin
     case(Instruction[6:2])
	`OPCODE_Branch:
        begin
            Branch=1'b1;
            MemRead =1'b0;
            MemtoReg =MemtoReg;
            ALUOp =2'b01;
            MemWrite =1'b0;
            ALUSrc =1'b1;
            RegWrite =1'b0;
	       Mux_RD1_PC=1'b0;
	       PC_load=1'b1;
        end
        `OPCODE_Load:
        begin
            Branch=1'b0;
            MemRead =1'b1;
            MemtoReg =2'b00;
            ALUOp =2'b00;
            MemWrite =1'b0;
            ALUSrc =1'b1;
            RegWrite =1'b1;
	        Mux_RD1_PC=1'b1;
	        PC_load=1'b1;
        end
        `OPCODE_Store:
        begin
            Branch=1'b0;
            MemRead =1'b0;
            MemtoReg = MemtoReg;
            ALUOp =2'b00;
            MemWrite =1'b1;
            ALUSrc =1'b1;
            RegWrite =1'b0;
	        Mux_RD1_PC=1'b1;
	        PC_load=1'b1;
        end
	`OPCODE_JALR: //PC=RG+IMM
        begin
            Branch=1'b1;
            MemRead =1'b0;
            MemtoReg =2'b01;
            ALUOp =2'b11;
            MemWrite =1'b0;
            ALUSrc =1'b1;
            RegWrite =1'b1;
	        Mux_RD1_PC=1'b1;
	        PC_load=1'b1;
        end
	`OPCODE_JAL: //PC=PC+IMM
        begin
            Branch=1'b1;
            MemRead =1'b0;
            MemtoReg =2'b01;
            ALUOp =2'b00;
            MemWrite =1'b0;
            ALUSrc =1'b0;
            RegWrite =1'b1;
	        Mux_RD1_PC=1'b1;
            PC_load=1'b1;
        end
        `OPCODE_Arith_R:
        begin
            Branch=1'b0;
            MemRead =1'b0;
            MemtoReg =2'b11;
            ALUOp =2'b10;
            MemWrite =1'b0;
            ALUSrc =1'b1;
            RegWrite =1'b1;
	        Mux_RD1_PC=1'b0;
            PC_load=1'b1;
        end
	`OPCODE_Arith_I:
        begin
            Branch=1'b0;
            MemRead =1'b0;
            MemtoReg =2'b11;
            ALUOp =2'b11;
            MemWrite =1'b0;
            ALUSrc =1'b1;
            RegWrite =1'b1;
	        Mux_RD1_PC=1'b1;
            PC_load=1'b1;
        end
	`OPCODE_AUIPC: //PC + IMM
        begin
            Branch=1'b0;
            MemRead =1'b0;
            MemtoReg =2'b11;
            ALUOp =2'b00;
            MemWrite =1'b0;
            ALUSrc =1'b0;
            RegWrite =1'b1;
	        Mux_RD1_PC=1'b1;
            PC_load=1'b1;
        end
	`OPCODE_LUI: //RD = IMM
        begin
            Branch=1'b0;
            MemRead =1'b0;
            MemtoReg =2'b10;
            ALUOp =2'b00;
            MemWrite =1'b0;
            ALUSrc =ALUSrc;
            RegWrite =1'b1;
	        Mux_RD1_PC=Mux_RD1_PC;
            PC_load=1'b1;
        end
	`OPCODE_SYSTEM: //ECALL AND EBREAK 
        begin
		if(Instruction[7]) //EBREAK
			begin
            			Branch=1'b0;
            			MemRead =1'b0;
            			MemtoReg =MemtoReg;
            			ALUOp =ALUOp;
            			MemWrite =1'b0;
            			ALUSrc =ALUSrc;
            			RegWrite =1'b0;
	    			    Mux_RD1_PC=Mux_RD1_PC;
				        PC_load=1'b1;
			end
		else //ECALL
			begin
				        Branch=1'b0;
            			MemRead =1'b0;
            			MemtoReg =MemtoReg;
            			ALUOp =ALUOp;
            			MemWrite =1'b0;
            			ALUSrc =ALUSrc;
            			RegWrite =1'b0;
	    			    Mux_RD1_PC=Mux_RD1_PC;
				        PC_load=1'b0;
			end
        end
	`OPCODE_NOOP: //PAUSE, FENCE, FENCE.TSO
        begin
            Branch=1'b0;
            MemRead =1'b0;
            MemtoReg =MemtoReg;
            ALUOp =ALUOp;
            MemWrite =1'b0;
            ALUSrc =ALUSrc;
            RegWrite =1'b0;
	        Mux_RD1_PC=Mux_RD1_PC;
	        PC_load=1'b1;
        end
     endcase
    end
endmodule
