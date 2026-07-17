module draw_digit(

    input  [3:0] digit,
    input  [2:0] x_local,   // 0..4
    input  [2:0] y_local,   // 0..6

    output reg pixel_on

);

reg [4:0] row;

always @(*) begin

    row = 5'b00000;

    case(digit)


    // 0

    4'd0:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b10001;
            2: row = 5'b10001;
            3: row = 5'b10001;
            4: row = 5'b10001;
            5: row = 5'b10001;
            6: row = 5'b11111;
        endcase

    // 1

    4'd1:
        case(y_local)
            0: row = 5'b00100;
            1: row = 5'b01100;
            2: row = 5'b00100;
            3: row = 5'b00100;
            4: row = 5'b00100;
            5: row = 5'b00100;
            6: row = 5'b01110;
        endcase

    // 2

    4'd2:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b00001;
            2: row = 5'b00001;
            3: row = 5'b11111;
            4: row = 5'b10000;
            5: row = 5'b10000;
            6: row = 5'b11111;
        endcase


    // 3

    4'd3:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b00001;
            2: row = 5'b00001;
            3: row = 5'b01111;
            4: row = 5'b00001;
            5: row = 5'b00001;
            6: row = 5'b11111;
        endcase


    // 4

    4'd4:
        case(y_local)
            0: row = 5'b10001;
            1: row = 5'b10001;
            2: row = 5'b10001;
            3: row = 5'b11111;
            4: row = 5'b00001;
            5: row = 5'b00001;
            6: row = 5'b00001;
        endcase

    // 5

    4'd5:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b10000;
            2: row = 5'b10000;
            3: row = 5'b11111;
            4: row = 5'b00001;
            5: row = 5'b00001;
            6: row = 5'b11111;
        endcase

    // 6

    4'd6:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b10000;
            2: row = 5'b10000;
            3: row = 5'b11111;
            4: row = 5'b10001;
            5: row = 5'b10001;
            6: row = 5'b11111;
        endcase


    // 7

    4'd7:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b00001;
            2: row = 5'b00010;
            3: row = 5'b00100;
            4: row = 5'b01000;
            5: row = 5'b01000;
            6: row = 5'b01000;
        endcase


    // 8

    4'd8:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b10001;
            2: row = 5'b10001;
            3: row = 5'b11111;
            4: row = 5'b10001;
            5: row = 5'b10001;
            6: row = 5'b11111;
        endcase


    // 9

    4'd9:
        case(y_local)
            0: row = 5'b11111;
            1: row = 5'b10001;
            2: row = 5'b10001;
            3: row = 5'b11111;
            4: row = 5'b00001;
            5: row = 5'b00001;
            6: row = 5'b11111;
        endcase

    default:
        row = 5'b00000;

    endcase

    if(x_local < 5 && y_local < 7)
        pixel_on = row[4-x_local];
    else
        pixel_on = 1'b0;

end

endmodule