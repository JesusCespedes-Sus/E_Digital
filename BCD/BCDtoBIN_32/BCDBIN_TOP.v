module BCDBIN_TOP(

    input clk,
    input rst,
    input init,

    input  [31:0] bcdin,

    output [31:0] B,
    output done

);

wire load_B;
wire load_h;
wire load_i;

wire DONE;

wire [5:0] h;
wire [5:0] h_temp;

wire [4:0] i;
wire [4:0] i_temp;

wire [31:0] bcd;

wire [3:0] dig;
wire [31:0] dig_c;

wire [31:0] s;
wire [31:0] B_temp;


Reg_B RB(

    .rst(rst),
    .clk(clk),
    .load_B(load_B),
    .init(init),

    .bcdin(bcdin),

    .B_temp(B_temp),

    .B(B),
    .bcd(bcd)

);

Reg_h RH(

    .rst(rst),
    .clk(clk),
    .load_h(load_h),
    .init(init),

    .h_temp(h_temp),

    .h(h)

);

Reg_i RI(

    .rst(rst),
    .clk(clk),
    .load_i(load_i),
    .init(init),

    .i_temp(i_temp),

    .i(i)

);

decdig DD(

    .bcd(bcd),
    .h(h),

    .dig(dig)

);

decdig_c DDC(

    .dig(dig),

    .dig_c(dig_c)

);

decs DS(

    .B(B),

    .s(s)

);

decB2 DB(

    .s(s),
    .dig_c(dig_c),

    .B_temp(B_temp)

);

cont CONT(

    .h(h),
    .i(i),

    .h_temp(h_temp),
    .i_temp(i_temp)

);

comp CMP(

    .i(i),

    .DONE(DONE)

);


Control_bcdbin CTRL(

    .clk(clk),
    .rst(rst),
    .init(init),

    .DONE(DONE),

    .load_B(load_B),
    .load_h(load_h),
    .load_i(load_i),

    .done(done)

);

endmodule