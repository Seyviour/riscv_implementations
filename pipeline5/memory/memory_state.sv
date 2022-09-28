module memoryState #(
    parameter
    word_width = 32
) (
    input logic RegWriteE,
    input logic [1:0] ResultSrcE,
    input logic MemWriteE,
    input logic [word_width-1: 0] ALUResultE,
    input logic [word_width-1: 0] WriteDataE,
    input logic [4:0] RdE,
    input logic [word_width-1:0] PCPlus4E,

    output logic RegWriteM,
    output logic [1:0] ResultSrcM,
    output logic MemWriteM,
    output logic [word_width-1: 0] ALUResultM,
    output logic [word_width-1: 0] WriteDataM,
    output logic [4:0] RdM,
    output logic [word_width-1:0] PCPlus4M

);

always_ff @(posedge clk) begin
    RdM <= RdE;
    RegWriteM <= RegWriteE;
    MemWriteM <= MemWriteE; 
    ResultSrcM <= ResultSrcE;
    ALUResultM <= ALUResultE;
    WriteDataM <= WriteDataE;
    PCPlus4M <= PCPlus4E;

end


endmodule