`timescale 1ns / 1ps

module Mul_Top_TB;

reg clk;
reg rst;
reg init;

reg [15:0] Ain;
reg [15:0] B;

wire [31:0] C;
wire done;


//==================================
// INSTANCIA DEL DUT
//==================================

Mul_Top uut (

    .clk(clk),
    .rst(rst),
    .init(init),

    .Ain(Ain),
    .B(B),

    .C(C),
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

    Ain = 16'd5;
    B   = 16'd3;

    
    //==============================
    // RESET
    //==============================

    #40;
    rst = 0;


    //==============================
    // INICIO DE MULTIPLICACION
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
    $display("A = %d", Ain);
    $display("B = %d", B);
    $display("Resultado = %d", C);
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

    $dumpfile("Mul_Top_TB.vcd");
    $dumpvars(0, Mul_Top_TB);

end

endmodule

