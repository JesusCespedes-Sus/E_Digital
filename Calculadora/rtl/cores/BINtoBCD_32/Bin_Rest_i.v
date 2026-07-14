module Bin_Rest_i (i_temp, i
);

input wire [5:0] i;

output wire [5:0] i_temp;

assign i_temp = i - 6'd1;

endmodule