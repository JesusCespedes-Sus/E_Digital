module Raiz_Comp (
    Rs_conc,
    Temp,
    Control
);

input  [31:0] Rs_conc;
input  [31:0] Temp;
output Control;

assign Control = (Rs_conc >= Temp);

endmodule