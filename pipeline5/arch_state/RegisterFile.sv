
module regFile #(
    parameter
    word_size = 32,
    address_width = $clog2(word_size)
) (
   input logic clk,
   input logic we3,
   input logic [address_width-1: 0] rd_addr1, rd_addr2, wr_addr3,
   input logic [word_size-1: 0] wr_data3,
   output logic [word_size-1: 0] rd_data1, rd_data2
);
    
    logic [31:0] regFileData [31:0]; 

    always_ff @(negedge clk)
        if (we3)
            regFileData[wr_addr3] <= wr_data3;
    
    assign rd_data1 = (rd_addr1 != 0) ? (regFileData[rd_addr1]): 0; 
    assign rd_data2 = (rd_addr2 != 0) ? (regFileData[rd_addr2]): 0; 
endmodule

//HARRIS AND HARRIS