`timescale 1ns / 1ps

module BCDBIN_TOP_TB;

reg clk;
reg rst;
reg init;

reg [31:0] bcdin;

wire [31:0] B;
wire done;


BCDBIN_TOP uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .bcdin(bcdin),

    .B(B),
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

end;


initial begin

    rst   = 1;
    init  = 0;

    bcdin = 32'h00000025;   


    #40;
    rst = 0;

    @(posedge clk);
    init = 1;

    @(posedge clk);
    init = 0;


    wait(done);



    $display("BCD     = %h", bcdin);
    $display("Binario = %d", B);


    #50;
    $finish;

end;


initial begin

    $dumpfile("BCDBIN_TOP_TB.vcd");
    $dumpvars(0, BCDBIN_TOP_TB);

end

endmodule