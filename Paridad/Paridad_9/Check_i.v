module Check_i(i, DONE);

input wire [3:0] i;

output DONE;

assign DONE = (i == 4'd7);

endmodule