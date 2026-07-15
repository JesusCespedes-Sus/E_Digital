module Raiz_Rest_i (i_temp, i
);

input wire [15:0] i;

output wire [15:0] i_temp;

assign i_temp = i - 16'd1;

endmodule