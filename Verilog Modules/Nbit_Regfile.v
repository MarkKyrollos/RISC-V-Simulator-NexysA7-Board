/*******************************************************************
*
* Module: Nbit_Regfile.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: N-bit register file of 32 registers
*
* Change history: 23/10/24 – Reformatted
*
**********************************************************************/


module Nbit_Regfile #(parameter N=32)(
 input [4:0]R_Addr1,
 input [4:0]R_Addr2,
 input clk,
 input RegWrite,
 input [4:0]W_Addr, 
 input [N-1:0]W_Data,
 output [N-1:0]R_Data1,
 output [N-1:0]R_Data2,
 input rst
    );
    reg [N-1:0]RegFile[31:0];
    integer i;
    assign R_Data1 = RegFile[R_Addr1];
    assign R_Data2 = RegFile[R_Addr2];
        
    always@(posedge clk or posedge rst)
    	begin
        	if(rst)
         		begin
            			for(i=0;i<32;i=i+1)
                			begin
                    				RegFile[i]=0;
                			end
         		end
         
         	else
        		if(RegWrite)
            			if(W_Addr !=0)
                			RegFile[W_Addr] <= W_Data; 
        end
              
endmodule
