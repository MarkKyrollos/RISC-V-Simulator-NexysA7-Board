`timescale 1ns / 1ps
`include "defines.v"
/*******************************************************************
*
* Module: ALUCU.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: ALU Control  Unit
*
* Change history: 23/10/24 – Reformatted to follow the guidelines
* - Expanded the R-format Case (Checks F7 and F3 fields) to handle all the new instructions
* - Added a new case for the I-format instructions. (Checks only the F3 field)
*
**********************************************************************/


module ALUCU(
input [1:0]ALUOp, 
input [3:0]Inst, 
output reg[3:0]ALUSel
    );
wire inst_30;
assign inst_30=Inst[3];
wire [2:0]inst_f3;
assign inst_f3=Inst[2:0];
    always@(*)begin
    case(ALUOp)
    `ALU_OP_ADD: ALUSel =`ALU_ADD; //00
    `ALU_OP_SUB: ALUSel =`ALU_SUB; //01
    `ALU_OP_R: //10
    begin
	if(inst_30)
		begin
			if(inst_f3[2])
				ALUSel =`ALU_SRA;
			else
				ALUSel =`ALU_SUB;
		end
	else 
		begin
			case(inst_f3)
				`F3_ADD: ALUSel =`ALU_ADD;
				`F3_SLL: ALUSel =`ALU_SLL;
				`F3_SLT: ALUSel =`ALU_SLT;
				`F3_SLTU: ALUSel =`ALU_SLTU;
				`F3_XOR: ALUSel =`ALU_XOR;
				`F3_SRL: ALUSel =`ALU_SRL;
				`F3_OR: ALUSel =`ALU_OR;
				`F3_AND: ALUSel =`ALU_AND;
			endcase
		end
	end
    `ALU_OP_I: //11
    	begin
		case(inst_f3)
				`F3_ADD: ALUSel =`ALU_ADD;
				`F3_SLL: ALUSel =`ALU_SLL;
				`F3_SLT: ALUSel =`ALU_SLT;
				`F3_SLTU: ALUSel =`ALU_SLTU;
				`F3_XOR: ALUSel =`ALU_XOR;
				`F3_SRL: ALUSel =`ALU_SRL;
				`F3_OR: ALUSel =`ALU_OR;
				`F3_AND: ALUSel =`ALU_AND;
			endcase
    	end
    
    endcase
    end
endmodule
