module Mul_Top (

    clk,
    rst,
    init,

    Ain,
    B,

    C,
    done
);

input clk;
input rst;
input init;

input wire [15:0] Ain;
input wire [15:0] B;

output wire [31:0] C;
output wire done;

wire [15:0] A;
wire [15:0] D;

wire [31:0] C_temp;

wire [3:0] i;
wire [3:0] i_temp;

wire load_A;
wire load_C;
wire load_D;
wire load_i;

wire DSHT;

wire CONTROL;
wire DONE;

Reg_A RA (

    .rst(rst),
    .clk(clk),
    .load_A(load_A),

    .Ain(Ain),

    .A(A)

);

Reg_D RD (

    .rst(rst),
    .clk(clk),

    .load_D(load_D),
    .DSHT(DSHT),

    .B(B),

    .D(D)

);

Reg_C RC (

    .rst(rst),
    .clk(clk),

    .load_C(load_C),

    .C_temp(C_temp),

    .C(C)

);

Reg_i RI (

    .rst(rst),
    .clk(clk),

    .load_i(load_i),

    .i_temp(i_temp),

    .i(i)

);

Cont_i CI (

    .i_temp(i_temp),
    .i(i)

);

Comp_Ai CA (

    .A(A),
    .i(i),

    .CONTROL(CONTROL)

);

Check_i CHK (

    .i(i),

    .DONE(DONE)

);

ADD_D ADD (

    .CONTROL(CONTROL),

    .C_temp(C_temp),

    .D(D),
    .C(C)

);

Control_mult CTRL (

    .clk(clk),
    .rst(rst),

    .init(init),

    .CONTROL(CONTROL),
    .DONE(DONE),

    .load_A(load_A),
    .load_C(load_C),
    .load_D(load_D),
    .load_i(load_i),

    .DSHT(DSHT),

    .done(done)

);



endmodule