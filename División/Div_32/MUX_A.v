module MUX_A (A_shift, A_ALU, SEL_A, A_temp
);

input  [32:0] A_shift;
input  [32:0] A_ALU;
input         SEL_A;

output [32:0] A_temp;

assign A_temp = (SEL_A) ? A_ALU : A_shift;

endmodule