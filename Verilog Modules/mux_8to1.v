module mux_8to1 (
    input  in0,
    input  in1,
    input  in2,
    input  in3,
    input  in4,
    input  in5, 
    input  in6,
    input  in7,
    input  [2:0] sel,
    output reg out
);

always @(*) begin
    case (sel)
        3'b000: out = in0;
        3'b001: out = in1;
        3'b010: out = in2;
        3'b011: out = in3;
        3'b100: out = in4;
        3'b101: out = in5;
        3'b110: out = in6;
        3'b111: out = in7;
        default: out = 1'b0;
    endcase
end

endmodule