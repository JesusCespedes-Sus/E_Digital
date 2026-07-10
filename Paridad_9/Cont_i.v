module Cont_i (i_temp, i
);

input wire [3:0] i;

output wire [3:0] i_temp;

assign i_temp = i + 4'd1;

endmodule
