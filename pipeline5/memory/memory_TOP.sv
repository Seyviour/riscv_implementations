`include "/home/saviour/study/riscv/pipeline5/memory/memory_state.sv"

module memoryTOP #(
    parameter
    word_width = 32
) (
    input logic clk,
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

memoryState 
#(
  .word_width (
      word_width )
)
thisMemoryState (
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



    
endmodule