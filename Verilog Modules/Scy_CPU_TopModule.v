`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 09:59:15 AM
// Design Name: 
// Module Name: Scy_CPU_TopModule
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


module Scy_CPU_TopModule(input clk, input rst,input [1:0]ledSel, input [3:0]ssdSel,input ssdclk, output  [15:0]Led_out, output  [3:0] Anode,
output  [6:0] SGGLedout
    );
     wire [12:0]SSG_out;
     SCy_CPU SCCPU(clk, rst,ledSel, ssdSel, Led_out,SSG_out);
     Four_Digit_Seven_Segment_Driver_Optimized SSG(ssdclk,SSG_out,Anode,SGGLedout);
endmodule
