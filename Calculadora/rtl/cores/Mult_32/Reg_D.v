module Reg_D (rst, clk, load_D, DSHT, B, D
);

input rst;
input clk;
input load_D;
input DSHT;

input [15:0] B;

output reg [15:0] D;

always @(posedge clk) begin
    if (rst)
        D <= 16'b0;

    else if (load_D)
        D <= B;

    else if (DSHT)
        D <= D << 1;
end

endmodule

