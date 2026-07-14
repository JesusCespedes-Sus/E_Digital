module Comp_Ai ( A, i, CONTROL
);

input wire [15:0] A;
input wire [3:0] i;

output wire CONTROL;

assign CONTROL = A[i];

endmodule