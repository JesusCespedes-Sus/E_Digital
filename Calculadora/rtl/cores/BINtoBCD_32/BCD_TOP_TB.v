`timescale 1ns / 1ps

module BCD_TOP_TB;

reg clk;
reg rst;
reg init;

reg [31:0] Bin;

wire [39:0] BCD;

wire done;

BCD_Top uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .Bin(Bin),

    .BCD(BCD),

    .done(done)

);


parameter PERIOD = 20;
parameter real DUTY_CYCLE = 0.5;


initial begin

    clk = 0;

    forever begin

        #(PERIOD*(1.0-DUTY_CYCLE))
        clk = ~clk;

        #(PERIOD*DUTY_CYCLE)
        clk = ~clk;

    end

end

initial begin

    rst  = 1;
    init = 0;

    Bin = 32'd1023;


    #40;
    rst = 0;

    @(posedge clk);

    init = 1;

    @(posedge clk);

    init = 0;

    wait(done);

    $display("Binario = %d", Bin);

    $display("BCD[39:36] = %d", BCD[39:36]);
    $display("BCD[35:32] = %d", BCD[35:32]);
    $display("BCD[31:28] = %d", BCD[31:28]);
    $display("BCD[27:24] = %d", BCD[27:24]);
    $display("BCD[23:20] = %d", BCD[23:20]);
    $display("BCD[19:16] = %d", BCD[19:16]);
    $display("BCD[15:12] = %d", BCD[15:12]);
    $display("BCD[11:8]  = %d", BCD[11:8]);
    $display("BCD[7:4]   = %d", BCD[7:4]);
    $display("BCD[3:0]   = %d", BCD[3:0]);

    #50;
    $finish;

end

initial begin

    $dumpfile("BCD_TOP_TB.vcd");
    $dumpvars(0, BCD_TOP_TB);

end

endmodule