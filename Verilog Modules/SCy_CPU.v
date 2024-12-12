`timescale 1ns / 1ps

module SCy_CPU(input clk, input rst,input [1:0]ledSel, input [3:0]ssdSel,input ssdclk, output reg [15:0]Led_out, output reg [12:0]SSG_out);
wire [31:0]C_Inst;
wire [13:0]CU_Concat;
wire [31:0]PC_out;
wire [31:0]PC_input;
wire [31:0]PC_Adder_out;
wire [31:0]PC_Branch_Adder_out;
wire [31:0]DataRead1;
wire [31:0]DataRead2;
wire [31:0]DataWrite;
wire [31:0]Imm_gen_out;
wire [31:0]SLL1_out;
wire [31:0]ALU_SRCMUX_out;
wire [31:0]ALU_out;
wire [31:0]Mem_out;
wire MUX_RD1_PC;
wire [31:0]ALU_2_SRCMUX_out;
always@(*)
begin
    case(ledSel)
        2'b00: begin
            Led_out =C_Inst[15:0];
        end
        2'b01: begin
            Led_out =C_Inst[31:16];
        end
        2'b10: begin
            Led_out ={CU_Concat};
        end
//        2'b11: begin
        
//        end
    endcase 
    case(ssdSel)
        4'b0000: begin
            SSG_out =PC_out[12:0];
        end
        4'b0001: begin
            SSG_out =PC_Adder_out[12:0];
        end
        4'b0010: begin
            SSG_out =PC_Branch_Adder_out[12:0];
        end
        4'b0011: begin
            SSG_out =PC_input[12:0];
        end
        4'b0100: begin
            SSG_out =DataRead1[12:0];
        end
        4'b0101: begin 
            SSG_out =DataRead2[12:0];
        end
        4'b0110: begin
            SSG_out =DataWrite[12:0];
        end
        4'b0111: begin
            SSG_out =Imm_gen_out[12:0];
        end
        4'b1000: begin
            SSG_out =SLL1_out[12:0];
        end
        4'b1001: begin
            SSG_out =ALU_SRCMUX_out[12:0];
        end
        4'b1010: begin
            SSG_out =ALU_out[12:0];
        end
        4'b1011: begin
            SSG_out =Mem_out[12:0];
        end
    endcase 
end


wire PC_load;
assign CU_Concat ={Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,ALUSel,BranchAdder_Sel,MUX_RD1_PC};

//9
//{1'b1}
 Nbit_ShiftRegister #(32)PC(clk, rst,PC_load,PC_input, PC_out); //Added PC_Load
 //wire[5:0] IM_in;
 //32 31-4 --> 4,5,6,7,8,9

 InstMem IM(PC_out[11:2], C_Inst); //Takes 10 bits from PC_out to support the 2047 addresses
 wire PC_ADDER_Cout;
 //2,3,4,5,6,7
 RCA_8bit #(32)PC_ADDER (PC_out,{{32'b000000000000000000000000000100}},{1'b0},PC_Adder_out,PC_ADDER_Cout);
 
 RCA_8bit #(32)PC_BRANCH_ADDER (PC_out,SLL1_out,{1'b0},PC_Branch_Adder_out,PC_ADDER_Cout);

wire BranchAdder_Sel;
assign BranchAdder_Sel=(Br_cond & Branch)?1:0; 


//top right MUX, 4 inputs 1 selector
wire[1:0]PC_Branch_MUX_SEL;
wire 
assign PC_Branch_MUX_SEL={C_Inst[2] ,BranchAdder_Sel};
wire Br_cond;
mux_4to1 #(32) Branch_Adder_Mux( PC_Adder_out , PC_Branch_Adder_out  ,  ALU_out,PC_Adder_out  ,PC_Branch_MUX_SEL  , PC_input);
                                    //00            01                    10        11                 
//nbit_mux_2x1 #(32)Branch_Adder_Mux(PC_Adder_out, PC_Branch_Adder_out, {BranchAdder_Sel}, PC_input);


wire Branch,MemRead,MemWrite,ALUSrc,RegWrite;
wire[1:0] MemtoReg;
wire[1:0]ALUOp;

CU Control_Unit({C_Inst[20],C_Inst[6:0]},Branch,MemRead,MemtoReg,ALUOp, MemWrite,ALUSrc,RegWrite,MUX_RD1_PC,PC_load);


Nbit_Regfile #(32) RGF(C_Inst[19:15],C_Inst[24:20], clk, RegWrite, C_Inst[11:7], DataWrite, DataRead1, DataRead2, rst);

rv32_ImmGen IMG(C_Inst,Imm_gen_out);

nbit_shiftleft1 #(32)SLL(Imm_gen_out, SLL1_out);


wire [3:0] ALUSel;   
ALUCU ALU_Control_Unit(ALUOp, {C_Inst[30],C_Inst[14:12]}, ALUSel);

// 2 MUX's for both Read Data 1 and Read Data 2
nbit_mux_2x1 #(32)ALU_Mux_2(Imm_gen_out,DataRead2, MUX_RD1_PC , ALU_2_SRCMUX_out );

nbit_mux_2x1 #(32)ALU_Mux_1(DataRead1, PC_out, {ALUSrc} , ALU_SRCMUX_out);

wire[4:0] shamt;
assign shamt=C_Inst[24:20] ;
wire cf,zf,vf,sf;
//


prv32_ALU ALU(ALU_SRCMUX_out,ALU_2_SRCMUX_out,shamt, ALU_out, cf,zf,vf,sf,ALUSel,{C_Inst[5]});

//added the 8x1 mux that takes ALU zero flags as inputs
//not sure about the selector of this mux

mux_8to1 branch_MUX(zf, {~zf},  {1'b0}, {1'b0},{(sf!=vf)?1:0}, {(sf==vf)?1:0},{~cf}, {cf}, {C_Inst[14:12]} , Br_cond);

//ALU_out
//DataMem DM(clk,  MemRead,  MemWrite, {C_Inst[14:12]},ALU_out[11:2], DataRead2, Mem_out);
DataMem DM(clk,  MemRead,  MemWrite, {C_Inst[14:12]},ALU_out[9:0], DataRead2, Mem_out);

// data memory MUX
mux_4to1 #(32) DM_MUX(Mem_out,PC_Adder_out, Imm_gen_out , ALU_out, MemtoReg , DataWrite);

//assign DataWrite=(MemtoReg)?Mem_out :ALU_out ;

endmodule
