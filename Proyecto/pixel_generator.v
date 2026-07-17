module pixel_generator(

    input  [7:0] address,

    input  [3:0] decenas,
    input  [3:0] unidades,

    output reg [23:0] rgb

);


reg [3:0] x;
reg [3:0] y;


reg [2:0] x_dec;
reg [2:0] y_dec;

reg [2:0] x_uni;
reg [2:0] y_uni;


wire pixel_dec;
wire pixel_uni;



draw_digit digit_decenas(

    .digit(decenas),
    .x_local(x_dec),
    .y_local(y_dec),
    .pixel_on(pixel_dec)

);


draw_digit digit_unidades(

    .digit(unidades),
    .x_local(x_uni),
    .y_local(y_uni),
    .pixel_on(pixel_uni)

);





always @(*) begin


    y = address[7:4];


    if(y[0])
        x = 15 - address[3:0];
    else
        x = address[3:0];


    x_dec = 0;
    y_dec = 0;

    x_uni = 0;
    y_uni = 0;


    rgb = 24'h000000;

    if(
        (x >= 1) &&
        (x <= 5) &&
        (y >= 4) &&
        (y <= 10)
    )
    begin

        x_dec = x - 1;
        y_dec = y - 4;


        if(pixel_dec)
            rgb = 24'h00FF00;

    end

    else if(
        (x >= 8) &&
        (x <= 12) &&
        (y >= 4) &&
        (y <= 10)
    )
    begin

        x_uni = x - 8;
        y_uni = y - 4;


        if(pixel_uni)
            rgb = 24'h00FF00;

    end



end


endmodule