`timescale 1ns / 1ps

module Div_TOP_TB;

reg clk;
reg rst;
reg init;

reg [31:0] Qin;
reg [31:0] Min;

wire [31:0] Q;
wire [32:0] A;

wire done;




Div_TOP uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .Qin(Qin),
    .Min(Min),

    .Q(Q),
    .A(A),

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

    // 25 / 3 = 8 residuo 1

    Qin = 32'd25;
    Min = 32'd3;




    #40;
    rst = 0;



    @(posedge clk);

    init = 1;

    @(posedge clk);

    init = 0;



    wait(done);




    $display("=================================");
    $display("Dividendo = %d", Qin);
    $display("Divisor   = %d", Min);
    $display("Cociente  = %d", Q);
    $display("Residuo   = %d", A);
    $display("=================================");



    #50;
    $finish;

end




initial begin

    $dumpfile("Div_TOP_TB.vcd");
    $dumpvars(0, Div_TOP_TB);

end

endmodule