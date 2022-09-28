module writeback_state #(
    parameter
    word_width = 32
) (
    input logic RegWriteM ,
    input logic [1:0] ResultSrcM,
    input logic [word_width-1:0] ALUResultM,
    input logic [word_width-1:0] ReadDataM,
    input logic [word_width-1:0] PCPlus4M,
    input logic [4:0] RdM,

    output logic RegWriteW,
    output logic [1:0] ResultSrcW,
    output logic [word_width-1:0] ALUResultW,
    output logic [word_width-1:0] ReadDataW,
    output logic [word_width-1:0] PCPlus4W,
    output logic [4:0] RdW

);

always_ff @(posedge clk) begin
    RegWriteW <= RegWriteM;
    ResultSrcW <= ResultSrcM;
    ALUResultW <= ALUResultM;
    ReadDataW <= ReadDataM;
    RdW <= RdM;
    PCPlus4W <= PCPlus4M;
    
    
end
    
endmodule