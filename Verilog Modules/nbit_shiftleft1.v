/*******************************************************************
* Module: nbit_shiftleft1.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: N-bit shifter by 1
*
* Change history: 23/10/24 – Formatted
* 
**********************************************************************/


module nbit_shiftleft1 #(parameter N=8)(
   	input [N-1:0]A, 
	output [N-1:0] B
    );
    assign B={A[N-2:0],1'b0};
endmodule
