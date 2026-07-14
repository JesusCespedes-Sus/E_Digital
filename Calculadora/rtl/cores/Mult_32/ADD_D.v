module ADD_D (CONTROL, C_temp, D, C
);

input wire [15:0] D;
input wire [31:0] C;

input wire CONTROL;

output wire [31:0] C_temp;

assign C_temp = CONTROL ? (C + {16'b0, D}) : C;

endmodule