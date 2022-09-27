module mux_3_1 #(
    parameter word_width = 32
) (
    input [1:0] sel, 
    input [word_width-1: 0] in00, in01, in10,
    output [word_width-1: 0] out
);
    
    always_comb
        case (sel)
            2'b00: out = in00;
            2'b01: out = in01;
            2'b10: out = in10;
            2'b11: out = 32'bx; 
            default: out = 32'bx;
        endcase
endmodule