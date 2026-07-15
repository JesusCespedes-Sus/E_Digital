module Raiz_Check_i (
    i,
    DONE
);

input wire [15:0] i;

output DONE;

assign DONE = (i == 16'd0);

endmodule