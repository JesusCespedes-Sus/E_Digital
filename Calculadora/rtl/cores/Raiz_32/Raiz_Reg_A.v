module Raiz_Reg_A (
    rst,
    clk,
    init,
    load_A,
    Ain,
    A_temp,
    A
);

input rst;
input clk;
input load_A;
input init;
input [31:0] Ain;
input [31:0] A_temp;

output reg [31:0] A;

always @(posedge clk or posedge rst) begin
    if (rst)
        A <= 32'b0;
    else if (init)
        A <= Ain;
    else if (load_A)
        A <= A_temp;
end

endmodule