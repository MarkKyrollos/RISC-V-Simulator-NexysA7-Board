`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 01:13:03 PM
// Design Name: 
// Module Name: DM_TB
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


module DM_TB(
    );
    reg clk, MemRead, MemWrite;
    reg [2:0] F3;
    reg [9:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;
    DataMem DM
( clk,
  MemRead,
  MemWrite,
  F3,
   addr,
  data_in,
  data_out
);
    initial begin
        clk=0;
        forever #10 clk=~clk;
        MemWrite =1'b0;
        MemRead=1'b0;
        F3=3'b000;
        addr=9'b000_000_000;
        data_in=32'b1000_1000_1000_1000_1000_1000_1000_1001;
    end
    initial begin
        MemWrite =1;
        data_in=32'b1000_1000_1000_1000_1000_1000_1000_1000;
        MemRead=1;
        F3=3'b010; //SW
        addr=9'b000_000_000; //0
        #20
        F3=3'b001;
        addr=9'b000_000_100; //SH 4
        #20
        F3=3'b001;
        addr=9'b000_000_110; //SH 6
        #20
        F3=3'b000;
        addr=9'b000_001_000; //SB 8
        #20
        F3=3'b000;
        addr=9'b000_001_001; //SB 9
        #20
        F3=3'b000;
        addr=9'b000_001_010; //SB 10
        #20
        F3=3'b000;
        addr=9'b000_001_011; //SB 11
//        #20
//        MemWrite =0;
//        MemRead=1;
//        F3=3'b000; //LB
//        addr=6'b000_000;
//        #20
//        F3=3'b001; //LH
//        #20
//        F3=3'b010; //LW
//        #20
//        F3=3'b100; //LBU
//        #20
//        F3=3'b101; //LHU
        //data_in=32'b0100_0100_0100_0100_0100_0100_1000_1000;
        
    end
endmodule
