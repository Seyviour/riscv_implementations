module ALU #(
    parameter
    word_width = 32
) (
    input logic [2:0] ALUControl,
    input logic [word_width-1: 0] SrcA,
    input logic [word_width-1: 0] SrcB,
    output logic [word_width-1: 0] Result, 
    output logic zero
);

    logic signed [word_width-1: 0] SrcA_S, SrcB_s;
    logic unsigned [word_width-1: 0] SrcA_U, SrcB_U;

    always_comb begin
        SrcA_S = SrcA;
        SrcB_s = SrcB; 
        SrcA_U = SrcA;
        SrcB_U = SrcB; 
    end
    

    always_comb
        case(ALUControl)

            3'b000: Result = SrcA_U + SrcB_U;
            3'b001: Result = SrcA_U - SrcB_U;
            3'b010: Result = (SrcA_U > SrcB_U)? 1: 0; 
            3'b110: Result = SrcA_U | SrcB_U;
            3'b111: Result = SrcA_U & SrcB_U;
            default: Result = SrcA; 
    endcase

    assign zero = (Result == 0);
    
endmodule