`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 05:22:59 PM
// Design Name: 
// Module Name: mux_8to1_TB
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


module mux_8to1_TB();

    reg  [2:0]in0;
    reg  [2:0]in1;
    reg  [2:0]in2;
    reg  [2:0]in3;
    reg  [2:0]in4;
    reg  [2:0]in5; 
    reg  [2:0]in6;
    reg  [2:0]in7;
    reg  [2:0] sel;
    wire [2:0]out;

    mux_8to1 #3 DUT
     ( in0,
       in1,
       in2,
       in3,
       in4,
       in5,
       in6,
       in7,
       sel,
       out );
       
      initial begin
       in0 = 1'd0;
       in1 = 1'd1;
       in2 = 1'd2;
       in3 = 1'd3;
       in4 = 1'd4;
       in5 = 1'd5;
       in6 = 1'd6;
       in7 = 1'd7;
       
        sel =3'b000;
       #5
       sel =3'b001;
       #5
       sel =3'b010;
       #5
       sel =3'b011;
       #5
       sel =3'b100;
       #5
       sel =3'b101;
       #5
       sel =3'b110;
       #5
       sel =3'b111; 
       
       
       
       end

endmodule
