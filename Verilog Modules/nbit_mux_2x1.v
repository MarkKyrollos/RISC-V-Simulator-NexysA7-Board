/*******************************************************************
*
* Module: nbit_mux_2x1.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: 2x1 Mux with variable wire size
*
* Change history: 23/10/24 – Refromatted
*
**********************************************************************/


module nbit_mux_2x1
 #(parameter N=8)(
 input [N-1:0]A,
 input [N-1:0]B,
 input s,
 output [N-1:0]M
    );
    genvar i;
    generate 
    	for(i=0;i<N;i=i+1) 
		begin
         		mux_2x1 mux(.D(A[i]),.Q(B[i]),.load(s),.Q_2(M[i]));
    		end
    endgenerate 
endmodule
