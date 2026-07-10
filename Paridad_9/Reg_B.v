module Reg_B (clk, rst,init, load_B, A, i, B
);
input  clk;
input  rst;
input  init;
input  load_B;
input  [8:0] A;
input  [3:0] i;
output reg [3:0] B;

always @(posedge clk or posedge rst) begin
    if (rst)
        B <= 4'd0;
    else if (init)
        B <= 4'd0;
    else if (load_B)
        B <= B + A[i];
end

endmodule
