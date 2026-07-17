module clock_divider(

    input clk,
    input rst,

    output reg tick

);

parameter CLK_FREQ = 26000000;

reg [24:0] counter;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        counter <= 0;
        tick <= 1'b0;
    end

    else
    begin

        if(counter == CLK_FREQ-1)
        begin
            counter <= 0;
            tick <= 1'b1;
        end
        else
        begin
            counter <= counter + 1'b1;
            tick <= 1'b0;
        end

    end

end

endmodule