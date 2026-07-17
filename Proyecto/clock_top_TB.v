`timescale 1ns/1ps


module clock_top_TB;


reg clk;
reg reset;

wire dout;

clock_top uut(

    .clk(clk),
    .reset(reset),

    .dout(dout)

);

// periodo:
// T = 1/26MHz = 38.46 ns

always begin

    #19.23 clk = ~clk;

end


initial begin

    clk = 0;

    reset = 1;

    #100;

    reset = 0;


    #2000000000;


    $finish;

end


initial begin

    $dumpfile("clock_top.vcd");

    $dumpvars(0,clock_top_TB);

end



endmodule