module Split (
    input logic [31: 0] instr,

    output logic [24: 20] i_24_20,
    output logic [19: 15] i_19_15,
    output logic [6: 0] i_6_0,
    output logic [14: 12] i_14_12,
    output logic i_30,
    output logic [11: 7] i_11_7,
    output logic [31: 7] i_31_7,

);
    


always_comb begin
    i_24_20 = instr[24:20];
    i_19_15 = instr[19:15];
    i_6_0 = instr[6: 0];
    i_14_12 = instr[14: 12];
    i_30 = instr[30];
    i_11_7 = instr[11: 7];
    i_31_7 = instr[31: 7]; 
end
endmodule