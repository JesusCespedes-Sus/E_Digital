`timescale 1ns / 1ps

module Mul_Top_TB;

reg clk;
reg rst;
reg init;

reg [15:0] Ain;
reg [15:0] B;

wire [31:0] C;
wire done;

Mul_Top uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .Ain(Ain),
    .B(B),

    .C(C),
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

    Ain = 16'd5;
    B   = 16'd3;


    #40;
    rst = 0;


    @(posedge clk);

    init = 1;

    @(posedge clk);

    init = 0;



    wait(done);



    $display("=================================");
    $display("A = %d", Ain);
    $display("B = %d", B);
    $display("Resultado = %d", C);
    $display("=================================");



    #50;
    $finish;

end




initial begin

    $dumpfile("Mul_Top_TB.vcd");
    $dumpvars(0, Mul_Top_TB);

end

endmodule

