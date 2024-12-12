/*******************************************************************
*
* Module: mux_2x1.v
* Project: Scy_CPU
* Author: Mohamed Sabry momo12320@aucegypt.edu
* Description: 1 bit 2x1 mux
*
* Change history: 23/10/24 – Reformatted
*
**********************************************************************/


module mux_2x1(
 input D,
 input Q,
 input load,
 output Q_2
    );
    assign Q_2= (load)?D:Q;
endmodule
