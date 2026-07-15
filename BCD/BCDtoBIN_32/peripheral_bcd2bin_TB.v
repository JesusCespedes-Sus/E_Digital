`timescale 1ns/1ps

module peripheral_bcd2bin_TB;

reg clk;
reg reset;

reg cs;
reg rd;
reg wr;

reg [4:0] addr;
reg [31:0] d_in;

wire [31:0] d_out;

peripheral_bcd2bin uut(

    .clk(clk),
    .reset(reset),

    .d_in(d_in),

    .cs(cs),
    .addr(addr),
    .rd(rd),
    .wr(wr),

    .d_out(d_out)

);

parameter PERIOD = 20;

always #(PERIOD/2)
    clk = ~clk;

initial begin

    clk = 0;
    reset = 1;

    cs = 0;
    rd = 0;
    wr = 0;

    addr = 0;
    d_in = 0;

    #(2*PERIOD);

    reset = 0;


    @(posedge clk);

    cs   = 1;
    wr   = 1;
    addr = 5'h04;
    d_in = 32'h00000025;

    @(posedge clk);

    cs = 0;
    wr = 0;

    @(posedge clk);

    cs   = 1;
    wr   = 1;
    addr = 5'h0C;

    @(posedge clk);

    cs = 0;
    wr = 0;

    wait(uut.bcd2bin0.done);

    @(posedge clk);

    cs   = 1;
    rd   = 1;
    addr = 5'h10;

    #1;

    $display("--------------------------------");
    $display("BCD      = %h", 32'h00000025);
    $display("Binario  = %d", d_out);


    addr = 5'h14;

    #1;

    $display("Done     = %d", d_out[0]);
    $display("--------------------------------");

    #50;

    $finish;

end

initial begin

    $dumpfile("peripheral_bcd2bin_TB.vcd");
    $dumpvars(0, peripheral_bcd2bin_TB);
end

endmodule