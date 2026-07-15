module Shift_Rs (
    Rs,
    Rs_shift
);

input  [31:0] Rs;
output [31:0] Rs_shift;

assign Rs_shift = Rs << 2;

endmodule