/*******************************************************************
* Module: Nbit_ShiftRegister.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: N-Bit Shift Register
*
* Change history: 23/10/24 - Formatted to follow rules and regulations
* 
**********************************************************************/


module Nbit_ShiftRegister #(parameter N=8)(
 input clk,
 input rst,
 input load,
 input [N-1:0]D,
 output  [N-1:0]Q
    );
    wire [N-1:0]Q_2;
    genvar i;
    	generate 
    		for(i=0;i<N;i=i+1)
			begin
        			mux_2x1 mux(.D(D[i]),.Q(Q[i]),.load(load),.Q_2(Q_2[i]));
        			DFlipFlop DFF(.clk(clk),.rst(rst),.D(Q_2[i]),.Q(Q[i]));
    			end
    	endgenerate
endmodule
