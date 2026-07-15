module Reg_B (
    rst,
    clk,
    load_B,
    B_temp,
    B,
    bcd,
    bcdin,
    init
);

input rst;
input clk;
input load_B;
input init;
input [31:0] bcdin;


input [31:0] B_temp;

output reg [31:0] B;
output reg [31:0] bcd;

always @(posedge clk or posedge rst) begin

    if(rst) begin
        B<=0;
        bcd<=0;
    end

    else if(init) begin
        B <= 32'd0;
        bcd <= bcdin;
    end

    else if (load_B)
        B <= B_temp;

end

endmodule