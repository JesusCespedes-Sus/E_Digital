module comp (i,DONE);

input wire [4:0] i;

output DONE;

assign DONE = (i == 5'd0);

endmodule