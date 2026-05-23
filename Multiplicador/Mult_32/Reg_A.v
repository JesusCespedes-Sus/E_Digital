module Reg_A (rst, clk, load_A, Ain, A
);

input rst;
input clk;
input load_A;

input [15:0] Ain;

output reg [15:0] A;

always @(posedge clk) begin
    if (rst)
        A <= 16'b0;

    else if (load_A)
        A <= Ain;
end

endmodule