/*******************************************************************
*
* Module: DFlipFlop.v
* Project: Scy_CPU
* Author: Provided by the instructor
* Description: DFlipFlop
*
* Change history: 23/10/24 – Refromatted
*
**********************************************************************/


module DFlipFlop(
 input clk,
 input rst,
 input D,
 output reg Q
);
    always @ (posedge clk or posedge rst)
	if (rst) 
		begin
			Q <= 1'b0;
		end 
	else 
		begin
			Q <= D;
		end
endmodule
