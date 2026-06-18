module Add3_BCD (
    input  [39:0] BCD,
    output [39:0] BCD_add
);

assign BCD_add[3:0] =
    (BCD[3:0] >= 4'd5) ?
    BCD[3:0] + 4'd3 :
    BCD[3:0];

assign BCD_add[7:4] =
    (BCD[7:4] >= 4'd5) ?
    BCD[7:4] + 4'd3 :
    BCD[7:4];

assign BCD_add[11:8] =
    (BCD[11:8] >= 4'd5) ?
    BCD[11:8] + 4'd3 :
    BCD[11:8];

assign BCD_add[15:12] =
    (BCD[15:12] >= 4'd5) ?
    BCD[15:12] + 4'd3 :
    BCD[15:12];

assign BCD_add[19:16] =
    (BCD[19:16] >= 4'd5) ?
    BCD[19:16] + 4'd3 :
    BCD[19:16];

assign BCD_add[23:20] =
    (BCD[23:20] >= 4'd5) ?
    BCD[23:20] + 4'd3 :
    BCD[23:20];

assign BCD_add[27:24] =
    (BCD[27:24] >= 4'd5) ?
    BCD[27:24] + 4'd3 :
    BCD[27:24];

assign BCD_add[31:28] =
    (BCD[31:28] >= 4'd5) ?
    BCD[31:28] + 4'd3 :
    BCD[31:28];

assign BCD_add[35:32] =
    (BCD[35:32] >= 4'd5) ?
    BCD[35:32] + 4'd3 :
    BCD[35:32];

assign BCD_add[39:36] =
    (BCD[39:36] >= 4'd5) ?
    BCD[39:36] + 4'd3 :
    BCD[39:36];

endmodule