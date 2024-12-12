
module mux_4to1 #(parameter n = 32) (
    input  [n-1:0] in0,
    input  [n-1:0] in1,    
    input  [n-1:0] in2,    
    input  [n-1:0] in3,    
    input  [1:0] sel,     
    output reg [n-1:0] out
);

always @(*) begin
case (sel)
2'b00: out = in0;
2'b01: out = in1;
2'b10: out = in2;
2'b11: out = in3;
default: out = {n{1'b0}};

endcase
end

endmodule
