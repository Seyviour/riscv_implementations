module RV32PipelinedTOP #(
    parameter word_width = 32
) (
    input logic clk,
    output logic [word_width-1:0] ResultW,
    output logic [4:0] RdW,
);



//FetchTOP;

FetchTop #(.word_width(word_width)) thisFetchStage
    (
        .clk(clk),
        .stallF_N(StallF),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .instrF(instrF),
        .PCF(PCF),
        .PCPlus4F(PCPlus4F)
    );

decodeTOP #(.word_width (word_width)) thisDecodeStage 
    (
      .clk (clk ),
      .instrF (instrF ),
      .PCF (PCF ),
      .PCPlus4F (PCPlus4F ),
      .rd_A1_RF (rd_A1_RF ),
      .rd_A2_RF (rd_A2_RF ),
      .ImmExtD (ImmExtD ),
      .Rs1D (Rs1D ),
      .Rs2D (Rs2D ),
      .RdD (RdD ),
      .RegWriteD (RegWriteD ),
      .ResultSrcD (ResultSrcD ),
      .MemWriteD (MemWriteD ),
      .StallD(StallD),
      .FlushD(FlushD),
      .JumpD (JumpD ),
      .BranchD (BranchD ),
      .ALUControlD (ALUControlD ),
      .ALUSrcD (ALUSrcD ),
      .PCPlus4D  ( PCPlus4D),
      .PCD(PCD)
    );
  
  

ExecuteTop #(.word_width (word_width)) thisExecuteStage
    (
      .clk (clk ),
      .FlushE (FlushE ),
      .RegWriteD (RegWriteD ),
      .ResultSrcD (ResultSrcD ),
      .MemWriteD (MemWriteD ),
      .JumpD (JumpD ),
      .BranchD (BranchD ),
      .ALUControlD (ALUControlD ),
      .ALUSrcD (ALUSrcD ),
      .RD1 (RD1 ),
      .RD2 (RD2 ),
      .ImmExtD (ImmExtD ),
      .Rs1D (Rs1D ),
      .Rs2D (Rs2D ),
      .RdD (RdD ),
      .PCD (PCD ),
      .PCPlus4D (PCPlus4D ),
      .ALUResultM (ALUResultM ),
      .forwardAE (forwardAE ),
      .forwardBE (forwardBE ),
      .ResultW (ResultW ),
      .RegWriteE (RegWriteE ),
      .ResultSrcE (ResultSrcE ),
      .MemWriteE (MemWriteE ),
      .Rs1E (Rs1E ),
      .Rs2E (Rs2E ),
      .RdE (RdE ),
      .PCSrcE(PCSrcE),
      .PCTargetE (PCTargetE ),
      .PCPlus4E (PCPlus4E ),
      .ALUResultE (ALUResultE ),
      .WriteDataE (WriteDataE)
    );

memoryTOP #(.word_width (word_width)) thisMemoryStage 
    (
      .clk(clk),
      .RegWriteE (RegWriteE ),
      .ResultSrcE (ResultSrcE ),
      .MemWriteE (MemWriteE ),
      .ALUResultE (ALUResultE ),
      .WriteDataE (WriteDataE ),
      .RdE (RdE ),
      .PCPlus4E (PCPlus4E ),
      .RegWriteM (RegWriteM ),
      .ResultSrcM (ResultSrcM ),
      .MemWriteM (MemWriteM ),
      .ALUResultM (ALUResultM ),
      .WriteDataM (WriteDataM ),
      .RdM (RdM ),
      .PCPlus4M  ( PCPlus4M)
    );

writebackTOP #(.word_width (word_width)) thisWritebackStage 
    (
      .RegWriteM (RegWriteM),
      .ResultSrcM (ResultSrcM),
      .ALUResultM (ALUResultM),
      .ReadDataM (ReadDataM),
      .PCPlus4M (PCPlus4M),
      .RdM (RdM),
      .ResultW (ResultW),
      .RegWriteW (RegWriteW),
      .RdW  (RdW)
    );

hazardTOP #(.word_width (word_width)) thisHazardUnit 
    (
      .RegWriteW (RegWriteW ),
      .RegWriteM (RegWriteM ),
      .Rs1E (Rs1E ),
      .Rs2E (Rs2E ),
      .RdE (RdE ),
      .Rs1D (Rs1D ),
      .Rs2D (Rs2D ),
      .RdW (RdW ),
      .RdM (RdM ),
      .ResultSrcE (ResultSrcE ),
      .PCSrcE (PCSrcE ),
      .forwardAE (forwardAE ),
      .forwardBE (forwardBE ),
      .StallD (StallD ),
      .FlushD (FlushD ),
      .FlushE (FlushE ),
      .StallF  ( StallF)
    );
  
     
  
  
  

endmodule