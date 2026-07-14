module decB2 (s, dig_c, B_temp);
input [31:0] s;
input [31:0] dig_c;
output [31:0] B_temp;
assign B_temp=s+dig_c;
endmodule


