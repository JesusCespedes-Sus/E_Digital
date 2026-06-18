module Conc_BCD (
    BCD_add,
    B,
    BCD_temp
);

input  [39:0] BCD_add;
input  [31:0] B;

output [39:0] BCD_temp;

assign BCD_temp = {BCD_add[38:0], B[31]};

endmodule