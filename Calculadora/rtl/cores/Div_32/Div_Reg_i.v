module Div_Reg_i (rst, clk, load_i, i_temp, i, init
);

input rst;
input clk;
input load_i;
input init;

input [5:0] i_temp;

output reg [5:0] i;

always @(posedge clk or posedge rst) begin

    if (rst)
        i <= 6'b0;

    else if (init)

        i <= 6'd32;

    else if (load_i)
        i <= i_temp;

end

endmodule