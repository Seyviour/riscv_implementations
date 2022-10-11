module adder #(
    parameter
    word_size = 16
) (
    input logic [word_size-1: 0] A, B,
    output logic [word_size-1: 0] C
);
    always_comb
        C = A + B;
    
endmodule