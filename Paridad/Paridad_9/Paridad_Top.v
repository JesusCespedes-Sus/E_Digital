module Paridad_Top (

    clk,
    rst,
    init,

    Ain,

    Par,
    done

);

input clk;
input rst;
input init;

input wire [8:0] Ain;

output wire Par;
output wire done;

wire [8:0] A;
wire [3:0] B;

wire [3:0] i;
wire [3:0] i_temp;

wire load_A;
wire load_B;
wire load_i;

wire DONE;

Reg_A RA (

    .init(init),
    .rst(rst),
    .clk(clk),

    .load_A(load_A),

    .A_in(Ain),

    .A(A)

);

Reg_B RB (

    .init(init),
    .rst(rst),
    .clk(clk),

    .load_B(load_B),

    .A(A),
    .i(i),

    .B(B)

);

Reg_i RI (

    .rst(rst),
    .clk(clk),

    .load_i(load_i),

    .i_temp(i_temp),

    .i(i)

);

Cont_i CI (

    .i(i),

    .i_temp(i_temp)

);

Check_i CHK (

    .i(i),

    .DONE(DONE)

);

Paridad PAR (

    .B(B),

    .Par(Par)

);

Control_Paridad CTRL (

    .clk(clk),
    .rst(rst),

    .init(init),

    .DONE(DONE),

    .load_A(load_A),
    .load_B(load_B),
    .load_i(load_i),

    .done(done)

);

endmodule