module ws2812_led_array (

    input    reset,
    input    clk,
    input    init_m,
    input    rst_cmd,

    input [3:0] decenas,
    input [3:0] unidades,

    output   dout,
    output   done

);


parameter SIZE   = 8;
parameter N_LEDS = 2**SIZE;


//------------------------------------------------
// Señales internas
//------------------------------------------------

wire init_led;
wire rst_addr;
wire inc_addr;

wire done_led;
wire z;

wire [SIZE-1:0] address;

wire [23:0] rgb;



//------------------------------------------------
// Generador de imagen
//------------------------------------------------

pixel_generator pixel0(

    .address(address),

    .decenas(decenas),
    .unidades(unidades),

    .rgb(rgb)

);



//------------------------------------------------
// Transmisor de un LED WS2812
//------------------------------------------------

ws2812_led ws2812_0(

    .clk(clk),
    .reset(reset),

    .rgb(rgb),

    .init(init_led),

    .rst_cmd(rst_cmd),

    .dout(dout),

    .done(done_led)

);



//------------------------------------------------
// Contador de LEDs
//------------------------------------------------

count_addr count0(

    .clk(clk),

    .rst(rst_addr),

    .inc(inc_addr),

    .address(address)

);



//------------------------------------------------
// Control matriz
//------------------------------------------------

ctrl_ws_arr ctrl0(

    .clk(clk),

    .reset(reset),

    .init_m(init_m),

    .done_led(done_led),

    .z(z),

    .done(done),

    .init_led(init_led),

    .rst(rst_addr),

    .inc(inc_addr)

);



//------------------------------------------------
// Detectar último LED
//------------------------------------------------

comp_ws_arr comp0(

    .in1(address),

    .in2(N_LEDS-1),

    .z(z)

);


endmodule