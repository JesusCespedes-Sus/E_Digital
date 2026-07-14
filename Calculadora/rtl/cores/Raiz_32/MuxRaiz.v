module MuxRaiz (
    Raiz_shift,
    Raiz_sum,
    Control,
    Raiz_temp
);

input  [31:0] Raiz_shift;
input  [31:0] Raiz_sum;
input         Control;
output [31:0] Raiz_temp;

assign Raiz_temp = (Control) ? Raiz_sum : Raiz_shift;

endmodule