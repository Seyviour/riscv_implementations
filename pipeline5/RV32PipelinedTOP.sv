module RV32PipelinedTOP #(
    parameter
    data_file = "/home/saviour/study/riscv/test/test_instructions.txt",
    word_width = 32
) (
    input logic clk, reset,
    output logic [word_width-1:0] WriteDataM,
    output logic [word_width-1:0] ALUResultM,
    output logic MemWrite
);

localparam r_address_width = 5; 

//FetchTOP;

logic StallF; 
logic [word_width-1: 0] PCPlus4F;
logic [word_width-1: 0] PCTargetE;

FetchTop #(.word_width(word_width)) thisFetchStage
    (
        .clk(clk),
        .reset(reset),
        .stallF_N(StallF),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .PCF(PCF),
        .PCPlus4F(PCPlus4F)
    );

logic [word_width-1: 0] instrF, PCF, ImmExtD, PCPlus4D;
logic [r_address_width-1: 0] Rs1D, Rs2D, RdD;
logic [1:0] ResultSrcD;
logic [2:0] ALUControlD;
logic [word_width-1:0] PCD;

decodeTOP #(.word_width (word_width)) thisDecodeStage 
    (
      .clk (clk ),
      .reset(reset),
      .instrF (instrF ),
      .PCF (PCF ),
      .PCPlus4F (PCPlus4F ),
    //   .rd_A1_RF (rd_A1_RF ),
    //   .rd_A2_RF (rd_A2_RF ),
      .ImmExtD (ImmExtD ),
      .Rs1D (Rs1D ),
      .Rs2D (Rs2D ),
      .RdD (RdD ),
      .RegWriteD (RegWriteD ),
      .ResultSrcD (ResultSrcD ),
      .MemWriteD (MemWriteD ),
      .StallD(StallD),
      .FlushD((FlushD)),
      .JumpD (JumpD ),
      .BranchD (BranchD ),
      .ALUControlD (ALUControlD ),
      .ALUSrcD (ALUSrcD ),
      .PCPlus4D  ( PCPlus4D),
      .PCD(PCD)
    );
  
  
logic MemWriteD;
logic [1:0] forwardAE, forwardBE;
logic [1:0] ResultSrcE; 
logic [word_width-1:0] ResultW;

logic [r_address_width-1:0] RdE, Rs1E, Rs2E; 
logic [word_width-1:0] PCPlus4DE, ALUResultE, WriteDataE; 
ExecuteTop #(.word_width (word_width)) thisExecuteStage
    (
      .clk (clk ),
      .reset(reset),
      .FlushE ((FlushE) ),
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

    
logic [word_width-1:0] PCPlus4E;
logic [1:0] ResultSrcM;
logic [r_address_width-1:0] RdM;
logic [word_width-1:0] PCPlus4M;
logic [word_width-1:0] ReadDataM;


memoryTOP #(.word_width (32)) thisMemoryStage 
    (
      .clk(clk),
      .reset(reset),
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

logic RegWriteW;
logic [r_address_width-1:0] RdW;

writebackTOP #(.word_width (32)) thisWritebackStage 
    (
      .clk(clk),
      .reset(reset),
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

logic [word_width-1: 0] rd_data1, rd_data2, RD1, RD2; 
regFile #(.address_width (5)) thisRegFile 
    (
      .clk (clk ),
      .we3 (RegWriteW),
      .rd_addr1 (Rs1D ),
      .rd_addr2 (Rs2D ),
      .wr_addr3 (RdW ),
      .wr_data3 (ResultW ),
      .rd_data1 (RD1),
      .rd_data2 (RD2)
    );

  memory #(.data_file(data_file)) thisInstructionMemory
  (
      .clk(clk),
      .we(1'b0),
      .addr(PCF),
      .rd_data(instrF),
      .wr_data(0)
  );

  
memory #(.data_file("")) thisDataMemory
    (
        .clk(clk),
        .we(MemWriteM),
        .addr(ALUResultM),
        .wr_data(WriteDataM),
        .rd_data(ReadDataM)
    );


  
     
  
  
  

endmodule