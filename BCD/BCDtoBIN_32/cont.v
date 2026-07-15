module cont(h,i,h_temp,i_temp);
    input  [5:0] h;
    input  [4:0] i;

    output [5:0] h_temp;
    output [4:0] i_temp;
assign h_temp = h - 6'd4;
assign i_temp = i - 5'd1;

endmodule