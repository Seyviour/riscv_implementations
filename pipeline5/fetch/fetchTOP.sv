`include "/home/saviour/study/riscv/pipeline5/fetch/progCounter.sv"
`include "/home/saviour/study/riscv/pipeline5/arch_state/memory.sv"

module FetchTop #(
    parameter counter_width = 32,
    word_width = 32
) (
    input logic clk, reset, 
    input logic stallF_N, PCSrcE,
    input logic [counter_width-1: 0] PCTargetE,
    output logic [word_width-1: 0] instr
);

logic stallF; 
logic [counter_width-1: 0] addressF; 
assign stallF = ~stallF_N; 

progCounter #(.reset_state(0), .counter_width(counter_width) ) thisProgCounter(
    .clk(clk),
    .reset(reset),
    .load(PCSrcE),
    .load_val(PCTargetE),
    .enable(stallF),
    .counter_state(addressF)
    );

memory #(.word_width(word_width), .address_width(32), .no_words(64)) ProgramMemory
    (
        .clk(clk),
        .we(0), 
        .addr(addressF),
        .rd_data(instr)
    );





    
endmodule