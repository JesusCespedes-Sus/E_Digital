module Reg_A (init, rst, clk, load_A, A_in, A
);

input rst;
input clk;
input load_A;
input init;

input [8:0] A_in;

output reg [8:0] A;

always @(posedge clk or posedge rst) begin

    if (rst)
        A <= 9'b0;

    else if(init)
        A <= 9'b0;

    else if (load_A)
        A <= A_in;
end

endmodule