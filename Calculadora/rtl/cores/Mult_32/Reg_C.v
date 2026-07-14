module Reg_C (rst, clk, load_C, C_temp, C
);

input rst;
input clk;
input load_C;

input [31:0] C_temp;

output reg [31:0] C;

always @(posedge clk) begin
    if (rst)
        C <= 0;

    else if (load_C)
        C <= C_temp;
end

endmodule