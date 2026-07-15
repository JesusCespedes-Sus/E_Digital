module SHT_B (
    B,
    B_sht
);

input [31:0]B;
output [31:0] B_sht;

assign B_sht = B << 1;
    
endmodule