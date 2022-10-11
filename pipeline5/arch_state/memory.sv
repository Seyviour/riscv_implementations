module memory #(
    parameter
    data_file = "",
    word_size = 32, 
    address_width = 32,
    no_words = 64
) (
    input logic clk, we, 
    input logic [address_width-1: 0] addr,
    input logic [word_size-1: 0] wr_data,
    output logic [word_size-1: 0] rd_data
);
    logic [word_size-1: 0] RAM [0:no_words-1];
    logic [31:2] this_address;
    initial begin
        // if (data_file != "") begin
            $readmemh(data_file, RAM);
        // end 
    end

    assign this_address = addr[31:2];
    always_comb
        rd_data = RAM[this_address];


    always_ff @(posedge clk)
        if (we)
            RAM[addr[31:2]] <= wr_data; // word aligned
            
    
    
    // integer idx; 
    // initial begin
    //     $dumpfile("cRAM.vcd");
    //     $dumpvars(0, memory);
    //     for (idx = 0; idx < no_words; idx = idx + 1) begin
    //         $dumpvars(0, RAM[idx]);
    //     end
    // end
endmodule