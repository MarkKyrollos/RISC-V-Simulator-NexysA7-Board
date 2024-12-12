`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 04:27:09 PM
// Design Name: 
// Module Name: ScyCPU_TB
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


module ScyCPU_TB(
    
    );
    reg clk,rst,ssdclk;
    reg [1:0]ledSel;
    reg[3:0]ssdSel;
    wire[15:0]Led_out;
     wire[12:0]SSG_out;
     SCy_CPU DUT
     ( clk,
       rst,
       ledSel,
        ssdSel,
        ssdclk,
        Led_out,
         SSG_out);
             initial begin
                clk=0;
                forever #5 clk=~clk;
                 rst =1'b0;
            end
         initial begin
            rst=1'b1;
            ledSel=2'b00;
            ssdSel=3'b000;
            #5
            rst=1'b0;
            ledSel=2'b01;
            ssdSel=3'b001;
            #5
            rst=1'b0;
            
            
            
            
            
            
            
            
            
            
         end

endmodule
