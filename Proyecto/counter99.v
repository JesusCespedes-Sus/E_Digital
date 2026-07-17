module counter99(

    input clk,
    input rst,
    input tick,

    output reg [3:0] decenas,
    output reg [3:0] unidades

);

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        decenas <= 4'd0;
        unidades <= 4'd0;
    end

    else if(tick)
    begin

        if(unidades == 4'd9)
        begin

            unidades <= 4'd0;

            if(decenas == 4'd9)
                decenas <= 4'd0;
            else
                decenas <= decenas + 4'd1;

        end

        else
            unidades <= unidades + 4'd1;

    end

end

endmodule