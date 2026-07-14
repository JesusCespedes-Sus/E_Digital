module Reg_Raiz (
    init,
    rst,
    clk,
    load_Raiz,
    Raiz_temp,
    Raiz
);

input rst;
input clk;
input load_Raiz;
input init;

input [31:0] Raiz_temp;

output reg [31:0] Raiz;

always @(posedge clk or posedge rst) begin

    if (rst)
        Raiz <= 32'b0;

    else if (init)
        Raiz <= 32'b0;

    else if (load_Raiz)
        Raiz <= Raiz_temp;

end

endmodule