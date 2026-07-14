module Reg_Rs (
    init,
    rst,
    clk,
    load_Rs,
    Rs_temp,
    Rs
);

input rst;
input clk;
input load_Rs;
input init;

input [31:0] Rs_temp;

output reg [31:0] Rs;

always @(posedge clk or posedge rst) begin

    if (rst)
        Rs <= 32'b0;

    else if (init)
        Rs <= 32'b0;

    else if (load_Rs)
        Rs <= Rs_temp;

end

endmodule