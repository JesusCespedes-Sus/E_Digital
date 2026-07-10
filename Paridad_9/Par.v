module Paridad(B, Par);

input wire [3:0] B;

output Par;

assign Par = B[0];

endmodule