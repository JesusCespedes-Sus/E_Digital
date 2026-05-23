module Reg_i (rst, clk, load_i, i_temp, i
);

input rst;
input clk;
input load_i;
input [3:0]i_temp;

output reg[3:0]i;

always @(posedge clk) begin
    if (rst)
        i <= 4'b0000;

    else if (load_i)
        i <= i_temp;
end

endmodule