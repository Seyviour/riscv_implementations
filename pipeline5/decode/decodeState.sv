module decodeState #(
    parameter 
    word_width = 32
    

) (
    input logic clk, 
    input logic [word_width-1: 0] instrF,
    input logic [word_width-1: 0] PCF,
    input logic  [word_width-1: 0] PCPlus4F,

    output logic [word_width-1: 0] instrD, PCD, PCPlus4D
);

 

always_ff @(posedge clk)
    begin
        instrD <= instrF;
        PCD <= PCF; 
        PCPlus4D <= PCPlus4F; 
    end

endmodule