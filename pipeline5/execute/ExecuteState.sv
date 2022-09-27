module ExecuteState #(
    parameter
    word_width = 32
) (
    input logic clk, FlushE,
    input logic RegWriteD,
    input logic [1:0] ResultSrcD,
    input logic [1:0] MemWriteD, 
    input logic JumpD,
    input logic BranchD, 
    input logic [2:0] ALUControlD,
    input logic ALUSrcD,
    input logic [word_width-1: 0] RD1, RD2, ImmExtD,
    input logic [4: 0] Rs1D, Rs2D, RdD,
    input logic [word_width-1: 0] PCD, PCPlus4D,



    output logic clk, 
    output logic RegWriteE,
    output logic [1:0] ResultSrcE,
    output logic [1:0] MemWriteE, 
    output logic JumpE,
    output logic BranchE, 
    output logic [2:0] ALUControlE,
    output logic ALUSrcE,
    output logic [word_width-1: 0] RD1E, RD2E, ImmExtE,
    output logic [4: 0] Rs1E, Rs2E, RdE,
    output logic [word_width-1: 0] PCE, PCPlus4E,
);

always_ff @(posedge clk) begin
    ResultSrcE <= ResultSrcD; 
    ALUControlE <= ALUControlD;
    ALUSrcE <= ALUSrcD;
    RD1E <= RD1;    
    RD2E <= RD2;
    ImmExtE <= ImmExtD;
    Rs1E <= Rs1D;
    Rs2E <= Rs2D;
    RdE <= RdD;
    PCE <= PCD;
    PCPlus4E <= PCPlus4D; 
end

always_ff @(posedge clk) begin 
    if (FlushE) begin
        RegWriteE <= 0;
        MemWriteE <= 0; 
        JumpE <= 0;
        BranchE <= 0;
    end
    else begin
        RegWriteE <= RegWriteD;
        MemWriteE <= MemWriteD;
        JumpE <= JumpD;
        BranchE <= BranchD;   
    end
end
    
endmodule