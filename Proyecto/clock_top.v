module clock_top(

    input  clk,
    input  reset,

    output dout

);


wire tick;

wire [3:0] decenas;
wire [3:0] unidades;

wire done;


//Divisor de frecuencia
//26 MHz -> 1 Hz


clock_divider #(

    .CLK_FREQ(26000000)

)
div0(

    .clk(clk),
    .rst(reset),
    .tick(tick)

);


counter99 count0(

    .clk(clk),
    .rst(reset),
    .tick(tick),

    .decenas(decenas),
    .unidades(unidades)

);


ws2812_led_array led_array0(

    .clk(clk),
    .reset(reset),

    .init_m(1'b1),

    .rst_cmd(1'b0),

    .decenas(decenas),
    .unidades(unidades),

    .dout(dout),

    .done(done)

);


endmodule