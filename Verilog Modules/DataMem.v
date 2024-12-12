/*******************************************************************
*
* Module: DataMem.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: Data Memory
*
* Change history: 23/10/24 – Refromatted 
* 27/10/24 Dataout --> Reg, Reading and storing now in always blocks, takes F3 as input
*
**********************************************************************/

`include "defines.v"
module DataMem
(input clk,
 input MemRead,
 input MemWrite,
 input [2:0]F3,
 input [9:0] addr,
 input [31:0] data_in,
 output reg [31:0] data_out
);
reg [31:0] mem [0:2047];
//sync write
wire[1:0] add_mod4;
wire[31:0] mem_addr;
assign mem_addr=mem[addr[9:2]];
assign add_mod4={addr[1:0]};
always@(posedge clk)
begin //SW vs LW
    if(MemWrite)
        case (F3)
            `F3_SLT: 
            begin
                mem[addr[9:2]]=data_in; 
                $display("SWWWWWWW");
             end
            //SW $pr
            `F3_SLL: begin
                if((add_mod4)==2'b00)
                    mem[addr[9:2]]={{mem[addr[9:2]][31:16]},data_in[15:0]}; 
                else if((add_mod4)==2'd10)
                    mem[addr[9:2]]={data_in[15:0],{mem[addr[9:2]][15:0]}};
                    end
            `F3_ADD: //mem[addr]={{24{1'b0}},data_in[7:0]}; //SB
            begin
                if((add_mod4)==2'b00)
                    mem[addr[9:2]]={{mem[addr[9:2]][31:16]},data_in[7:0]};
                else if((add_mod4)==2'b01)
                    mem[addr[9:2]]={{mem[addr[9:2]][31:16]},data_in[7:0],{mem[addr[9:2]][7:0]}};
                else if((add_mod4)==2'b10)
                    mem[addr[9:2]]={{mem[addr[9:2]][31:24]},data_in[7:0],{mem[addr[9:2]][15:0]}};
                else if((add_mod4)==2'b11)
                    mem[addr[9:2]]={data_in[7:0],{mem[addr[9:2]][23:0]}};
                    end
        endcase
end
always@(*)
    begin
        if(MemRead)
            case (F3)
                `F3_ADD: //data_out={{24{mem[addr][7]}},mem[addr][7:0]}; //LB
                    begin
                    if((add_mod4)==2'b00)
                        data_out={{24{mem[addr[9:2]][7]}},mem[addr[9:2]][7:0]}; 
                    else if((add_mod4)==2'b01)
                        data_out={{24{mem[addr[9:2]][15]}},mem[addr[9:2]][15:8]}; 
                    else if((add_mod4)==2'b10)
                        data_out={{24{mem[addr[9:2]][23]}},mem[addr[9:2]][23:16]}; 
                    else if((add_mod4)==2'b11)
                        data_out={{24{mem[addr[9:2]][31]}},mem[addr[9:2]][31:24]}; 
                        end
                `F3_SLL: //data_out={{16{mem[addr][15]}},mem[addr][15:0]}; //LH
                begin
                    if((add_mod4)==2'b00)
                        data_out={{16{mem[addr[9:2]][15]}},mem[addr[9:2]][15:0]};
                    else if((add_mod4)==2'b10)
                        data_out={{16{mem[addr[9:2]][31]}},mem[addr[9:2]][31:16]};
                        end
                `F3_SLT: data_out=mem[addr[9:2]]; //LW
                `F3_XOR: //data_out={{24{1'b0}},mem[addr][7:0]}; //LBU
                begin
                    if((add_mod4)==2'b00)
                        data_out={{24{1'b0}},mem[addr[9:2]][7:0]}; 
                    else if((add_mod4)==2'b01)
                        data_out={{24{1'b0}},mem[addr[9:2]][15:8]}; 
                    else if((add_mod4)==2'b10)
                        data_out={{24{1'b0}},mem[addr[9:2]][23:16]}; 
                    else if((add_mod4)==2'b11)
                        data_out={{24{1'b0}},mem[addr[9:2]][31:24]}; 
                    end
                `F3_SRL: //data_out={{16{1'b0}},mem[addr][15:0]}; //LHU
                begin
                     if((add_mod4)==2'b00)
                        data_out={{16{1'b0}},mem[addr[9:2]][15:0]}; 
                    else if((add_mod4)==2'b10)
                        data_out={{16{1'b0}},mem[addr[9:2]][31:16]}; 
                        end
            endcase
    end
//assign data_out =MemRead?mem[addr]:data_out;
endmodule 
