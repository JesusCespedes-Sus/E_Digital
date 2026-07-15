module decs (B,s);
input [31:0] B;
output [31:0] s;
assign s=(B<<3)+(B<<1);
endmodule
