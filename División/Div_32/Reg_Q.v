module Reg_Q (rst, clk, init, load_Q, Qin, Q_temp, Q
);

input rst;
input clk;
input load_Q;
input init;
input [31:0] Qin;
input [31:0] Q_temp;

output reg [31:0] Q;

always @(posedge clk or posedge rst) begin

    if (rst)
        Q <= 32'b0;

    else if (init)

        Q <= Qin;

    else if (load_Q)
        Q <= Q_temp;
end

endmodule