module Bin_Reg_B (rst, clk, init, load_B, Bin, B_temp, B
);

input rst;
input clk;
input load_B;
input init;
input [31:0] Bin;
input [31:0] B_temp;

output reg [31:0] B;

always @(posedge clk or posedge rst) begin

    if (rst)
        B <= 32'b0;

    else if (init)

        B <= Bin;

    else if (load_B)
        B <= B_temp;
end

endmodule