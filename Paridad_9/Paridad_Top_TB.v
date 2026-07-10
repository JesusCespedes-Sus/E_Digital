`timescale 1ns / 1ps

module Paridad_Top_TB;

reg clk;
reg rst;
reg init;

reg [8:0] Ain;

wire Par;
wire done;

Paridad_Top uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .Ain(Ain),

    .Par(Par),
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

    //==========================
    // CASO 1
    //==========================

    rst  = 1;
    init = 0;

    Ain = 9'b101010101;      // 5 unos -> Par = 0

    #40;
    rst = 0;

    @(posedge clk);
    init = 1;

    @(posedge clk);
    init = 0;

    wait(done);

    $display("=================================");
    $display("CASO 1");
    $display("A        = %b", Ain);
    $display("Paridad  = %b", Par);
    $display("Esperado = 0");
    $display("=================================");

    //==========================
    // CASO 2
    //==========================

    rst = 1;
    init = 0;

    #40;
    rst = 0;

    Ain = 9'b101010100;      // 4 unos -> Par = 1

    @(posedge clk);
    init = 1;

    @(posedge clk);
    init = 0;

    wait(done);

    $display("=================================");
    $display("CASO 2");
    $display("A        = %b", Ain);
    $display("Paridad  = %b", Par);
    $display("Esperado = 1");
    $display("=================================");

    #50;
    $finish;

end

initial begin

    $dumpfile("Paridad_Top_TB.vcd");
    $dumpvars(0, Paridad_Top_TB);

end

endmodule