module Reg_M (rst, clk, load_M, Min, M
);

input rst;
input clk;
input load_M;

input [31:0] Min;

output reg [32:0] M;

always @(posedge clk or posedge rst) begin

    if (rst)
        M <= 33'b0;

    else if (load_M)
        M <= {1'b0, Min};

end

endmodule