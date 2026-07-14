module Reg_BCD (
    input rst,
    input clk,
    input load_BCD,
    input init,
    input [39:0] BCD_temp,

    output reg [39:0] BCD
);

always @(posedge clk or posedge rst) begin

    if (rst)
        BCD <= 40'b0;

    else if (init)
        BCD <= 40'b0;

    else if (load_BCD)
        BCD <= BCD_temp;

end

endmodule