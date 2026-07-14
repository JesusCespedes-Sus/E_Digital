module Araiz_shift (
    Raiz,
    A,
    Raiz_shift,
    A_shift
);

input  [31:0] Raiz;
input  [31:0] A;

output [31:0] A_shift;
output [31:0] Raiz_shift;

assign A_shift    = A << 2;
assign Raiz_shift = Raiz << 1;

endmodule