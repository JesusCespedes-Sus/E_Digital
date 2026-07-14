`timescale 1ns/1ps


module peripheral_sqrt_TB;


reg clk;
reg reset;


reg cs;
reg rd;
reg wr;


reg [4:0] addr;

reg [31:0] d_in;


wire [31:0] d_out;



//==================================================
// DUT
//==================================================

peripheral_sqrt uut(

    .clk(clk),
    .reset(reset),

    .d_in(d_in),

    .cs(cs),
    .addr(addr),

    .rd(rd),
    .wr(wr),

    .d_out(d_out)

);



//==================================================
// Clock
//==================================================

parameter PERIOD = 20;


always #(PERIOD/2)
    clk = ~clk;




//==================================================
// Estímulo
//==================================================

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



    //------------------------------------------------
    // Escribir A = 121
    //------------------------------------------------


    @(posedge clk);


    cs = 1;
    wr = 1;

    addr = 5'h04;

    d_in = 32'd121;



    @(posedge clk);


    cs = 0;
    wr = 0;



    //------------------------------------------------
    // Activar inicio
    //------------------------------------------------


    @(posedge clk);


    cs = 1;

    wr = 1;


    addr = 5'h0C;

    d_in = 32'd1;



    @(posedge clk);


    cs = 0;

    wr = 0;



    //------------------------------------------------
    // Esperar resultado
    //------------------------------------------------


    $display("Esperando DONE...");


    wait(uut.raiz0.done == 1'b1);


    $display("DONE recibido");



    //------------------------------------------------
    // Leer resultado
    //------------------------------------------------


    @(posedge clk);


    cs = 1;

    rd = 1;


    addr = 5'h10;



    #2;


    $display("-----------------------------");

    $display("Entrada = %d",121);

    $display("Raiz    = %d",d_out);



    //------------------------------------------------
    // Leer done
    //------------------------------------------------


    addr = 5'h14;


    #2;


    $display("Done    = %d",d_out[0]);


    $display("-----------------------------");



    #50;


    $finish;


end




//==================================================
// VCD
//==================================================

initial begin

    $dumpfile("peripheral_sqrt_TB.vcd");

    $dumpvars(0,peripheral_sqrt_TB);

end



endmodule