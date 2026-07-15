module decdig_c (dig, dig_c);
input [3:0] dig;
output [31:0] dig_c;
assign dig_c= {28'b0,dig};
endmodule