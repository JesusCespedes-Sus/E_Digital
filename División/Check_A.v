module Check_A (A, CONTROL
);

input wire [32:0] A;

output CONTROL;

assign CONTROL = A[32];

endmodule