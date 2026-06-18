module Check_i (i, DONE
);

input wire [5:0] i;

output DONE;

assign DONE = (i == 6'd0);

endmodule