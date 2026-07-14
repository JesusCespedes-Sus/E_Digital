module Raizfin (
    Raiz_shift,
    Raiz_sum
);

input  [31:0] Raiz_shift;
output [31:0] Raiz_sum;

assign Raiz_sum = Raiz_shift + 1;

endmodule