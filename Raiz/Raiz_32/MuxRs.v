module MuxRs (
    Rs_conc,
    Rs_rest,
    Control,
    Rs_temp
);

input  [31:0] Rs_conc;
input  [31:0] Rs_rest;
input         Control;

output [31:0] Rs_temp;

assign Rs_temp = (Control) ? Rs_rest : Rs_conc;

endmodule