module progCounter #(
    parameter
    reset_state = 0, 
    counter_width = 32
) (
    input logic clk, reset, load,
    input logic [counter_width-1: 0] load_val, 
    input logic enable,
    output logic [counter_width-1: 0] counter_state,
    output logic [counter_width-1: 0] next_state
); 

always_ff @(posedge clk)
    if (reset)
        counter_state <= reset_state;
    else begin
        if (load)
            counter_state <= load_val; 
        else if (enable)
            counter_state <= next_state;
    end

always_comb
    next_state = counter_state + 3'b100; 
endmodule