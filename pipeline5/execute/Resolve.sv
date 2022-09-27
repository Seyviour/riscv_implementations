`include "/home/saviour/study/riscv/pipeline5/generic/mux_3_1.sv"
module Resolve #(
    parameter word_width = 32
) (
    input [word_width-1: 0] RD1E, RD2E,
    input [word_width-1: 0] ImmExtE,
    input [word_width-1: 0] ALUResultM,
    input forwardAE, forwardBE, ALUSrcE,
    input [word_width-1: 0] ResultW,

    output [word_width-1: 0] WriteDataE,
    output [word_width-1: 0] SrcAE, SrcBE
);



mux_3_1 #(.word_width(32)) muxA
    (
        .sel(forwardAE),
        .in00(RD1E),
        .in01(ResultW),
        .in10(ALUResultM),
        .out(SrcAE)
    );


wire [word_width-1: 0] SrcBE_i;
mux_3_1 #(.word_width(32)) muxB
    (
        .sel(forwardBE),
        .in00(RD2E),
        .in01(ResultW),
        .in10(ALUResultM),
        .out(SrcBE_i)
    );

always_comb begin
    SrcBE = (ALUSrcE==0)? SrcBE_i: ImmExtE;
    WriteDataE = SrcBE_i;
end

endmodule