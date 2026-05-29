module Reg_A (init, rst, clk, load_A, A_temp, A
);

input rst;
input clk;
input load_A;
input init;

input [32:0] A_temp;

output reg [32:0] A;

always @(posedge clk or posedge rst) begin

    if (rst)
        A <= 33'b0;

    else if(init)
        A <= 33'b0;

    else if (load_A)
        A <= A_temp;
end

endmodule