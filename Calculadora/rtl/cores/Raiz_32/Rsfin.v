module Rsfin (
    Rs_conc,
    Temp,
    Rs_rest
);

input  [31:0] Rs_conc;
input  [31:0] Temp;

output [31:0] Rs_rest;

assign Rs_rest = Rs_conc - Temp;

endmodule