module testbench();
logic clk;
logic reset;
logic [31:0] WriteData, DataAdr;
logic MemWrite;
// instantiate device to be tested



 RV32PipelinedTOP dut(clk, reset, WriteData, DataAdr, MemWrite);


// initialize test
initial
    begin
        reset <= 1; # 22; reset <= 0;
    end

initial begin
    $dumpfile("test32.vcd");
    $dumpvars(0, dut);
end
// generate clock to sequence tests
always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

// check results
always @(negedge clk)
    begin
        if(MemWrite) begin
            //$monitor("time=%0t, WriteData=%WriteData, b=%DataAddr", $time, WriteData, DataAdr);
            if(DataAdr === 100 & WriteData === 25) begin
                $display("Simulation succeeded");
                $stop;
            end else if (DataAdr !== 96) begin
                $display("Simulaton failed");
                $stop;
            end
        end
    end

endmodule