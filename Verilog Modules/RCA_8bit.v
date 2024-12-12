`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 07:28:56 AM
// Design Name: 
// Module Name: Full_Adder
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


module RCA_8bit#(parameter n=8)(
input[n-1:0] A, input[n-1:0] B, input Cin, output[n-1:0] sum, output Cout
    );
    wire[n-1:0]Carry; 
    Full_Adder fa(A[0],B[0],Cin,sum[0],Carry[0]);
    generate 
    for(genvar i=1;i<n;i=i+1) begin
       Full_Adder fa(A[i],B[i],Carry[i-1],sum[i],Carry[i]);     
    end
    endgenerate
    assign Cout = Carry[n-1];
endmodule
