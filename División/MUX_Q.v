module MUX_Q (Q_shift, CONTROL, Q_temp
);

input  [31:0] Q_shift;
input         CONTROL;

output [31:0] Q_temp;

assign Q_temp = {Q_shift[31:1], ~CONTROL};

endmodule