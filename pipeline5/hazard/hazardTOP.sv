//HARRIS AND HARRIS 
module hazardTOP #(
    parameter
    word_width = 32
) (
    input logic RegWriteW, 
    input logic RegWriteM,
    input logic [4:0] Rs1E, Rs2E, RdE,
    input logic [4:0] Rs1D, Rs2D, 
    input logic [4:0] RdW,
    input logic [4:0] RdM,
    input logic [1:0] ResultSrcE,
    input logic PCSrcE,

    output logic [1:0] forwardAE,
    output logic [1:0] forwardBE,
    output logic StallD,
    output logic FlushD,
    output logic FlushE,
    output logic StallF

);
logic lwStall;

always_comb
    if (RegWriteM & (Rs1E == RdM) & (Rs1E!=0))
        forwardAE = 2'b10;
    else if (RegWriteW & (Rs1E == RdW) & (Rs1E != 0))
        forwardAE = 2'b01;
    else
        forwardAE = 2'b00;

always_comb
    if (RegWriteM & (Rs2E == RdM) & (Rs2E!=0))
        forwardBE = 2'b10;
    else if (RegWriteW & (Rs2E == RdW) & (Rs2E != 0))
        forwardBE = 2'b01;
    else
        forwardBE = 2'b00;

logic ResultSrcE_0;
assign ResultSrcE_0 = ResultSrcE[0];
always_comb begin
    // stall when result source is memory and source register (execute) is the destination register (decode)
    // only need to check for execute because in any other case, the result can be forwarded or is available in the RegisterFile

    lwStall = ResultSrcE_0 & ((Rs1D == RdE) | (Rs2D == RdE));
    StallF = lwStall;
    StallD = lwStall;
end

always_comb begin
    FlushD = PCSrcE;
    FlushE = lwStall | PCSrcE;
end
    
    
endmodule