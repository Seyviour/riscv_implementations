// `include "/home/saviour/study/riscv/pipeline5/fetch/progCounter.sv"
// `include "/home/saviour/study/riscv/pipeline5/arch_state/memory.sv"

module FetchTop #(
    parameter counter_width = 32,
    word_width = 32
) (
    input logic clk, reset, 
    input logic stallF_N, 
    input logic PCSrcE,
    input logic [counter_width-1: 0] PCTargetE,
    output logic [counter_width -1: 0] PCF,
    output logic [counter_width -1: 0] PCPlus4F
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
    .state(PCF),
    .next_state(PCPlus4F)
    );


endmodule