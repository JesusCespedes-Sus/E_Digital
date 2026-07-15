module Reg_h (
    rst,
    clk,
    load_h,
    h_temp,
    h,
    init
);

input rst;
input clk;
input load_h;
input init;

input [5:0] h_temp;

output reg [5:0] h;

always @(posedge clk or posedge rst) begin

    if (rst)
        h <= 6'b0;

    else if (init)
        h <= 6'd28;

    else if (load_h)
        h <= h_temp;

end

endmodule