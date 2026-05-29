module Shift_AQ (A, Q, A_shift, Q_shift );

input [32:0] A;
input [31:0] Q;

output [32:0] A_shift;

output [31:0] Q_shift;

wire [64:0] AQ_shift;


assign AQ_shift = {A,Q} << 1;

assign A_shift = AQ_shift[64:32];

assign Q_shift = AQ_shift[31:0]; 

endmodule