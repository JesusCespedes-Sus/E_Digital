module RS_conc (
    A,
    Rs_shift,
    Rs_conc
);

input  [31:0] A;
input  [31:0] Rs_shift;

output [31:0] Rs_conc;

assign Rs_conc = {Rs_shift[31:2],A[31:30]};

endmodule