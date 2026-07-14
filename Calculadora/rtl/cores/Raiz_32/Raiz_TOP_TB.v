`timescale 1ns / 1ps

module Raiz_TOP_TB;

reg clk;
reg rst;
reg init;

reg [31:0] Ain;

wire [31:0] Raiz;
wire done;


//==================================
// INSTANCIA DEL DUT
//==================================

Raiz_TOP uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .Ain(Ain),

    .Raiz(Raiz),
    .done(done)

);


//==================================
// PARAMETROS DE RELOJ
//==================================

parameter PERIOD = 20;
parameter real DUTY_CYCLE = 0.5;


//==================================
// GENERACION DEL CLOCK
//==================================

initial begin

    clk = 0;

    forever begin

        #(PERIOD*(1.0-DUTY_CYCLE))
        clk = ~clk;

        #(PERIOD*DUTY_CYCLE)
        clk = ~clk;

    end

end


//==================================
// ESTIMULOS
//==================================

initial begin

    //==============================
    // VALORES INICIALES
    //==============================

    rst  = 1;
    init = 0;

    // sqrt(25) = 5

    Ain = 32'd9989;


    //==============================
    // RESET
    //==============================

    #40;
    rst = 0;


    //==============================
    // INICIO
    //==============================

    @(posedge clk);

    init = 1;

    @(posedge clk);

    init = 0;


    //==============================
    // ESPERAR FINALIZACION
    //==============================

    wait(done);


    //==============================
    // MOSTRAR RESULTADO
    //==============================

    $display("=================================");
    $display("Radicando = %d", Ain);
    $display("Raiz      = %d", Raiz);
    $display("=================================");


    //==============================
    // FINALIZAR SIMULACION
    //==============================

    #50;
    $finish;

end


//==================================
// GENERACION DE VCD
//==================================

initial begin

    $dumpfile("Raiz_TOP_TB.vcd");
    $dumpvars(0, Raiz_TOP_TB);

end

endmodule