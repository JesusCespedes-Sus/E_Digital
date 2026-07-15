module Tmp (
    Raiz_shift,
    Temp
);

input  [31:0] Raiz_shift;
output [31:0] Temp;

assign Temp = (Raiz_shift << 1) + 32'd1;

endmodule