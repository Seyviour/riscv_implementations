module memory #(
    parameter
    word_size = 32, 
    address_width = 32,
    no_words = 64
) (
    input logic clk, we, 
    input logic [address_width-1: 0] addr,
    input logic [word_size-1: 0] wr_data,
    output logic [word_size-1: 0] rd_data

);

    logic [word_size-1: 0] RAM [no_words: 0]; 

    always_ff @(posedge clk)
        if (we)
            RAM[addr[31:2]] <= wr_data; // word aligned
            
    assign rd_data = RAM[addr[31:2]]; //word aligned
            
endmodule