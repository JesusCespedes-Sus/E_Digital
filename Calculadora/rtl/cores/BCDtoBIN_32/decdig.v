module decdig (bcd, h, dig);
    input [31:0] bcd;
    input [5:0] h;
    output [3:0] dig;
assign dig = bcd[h +: 4];
endmodule