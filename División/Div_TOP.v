module Div_TOP (

    clk,
    rst,
    init,

    Qin,
    Min,

    Q,
    A,

    done
);

input clk;
input rst;
input init;

input wire [31:0] Qin;
input wire [31:0] Min;

output wire [31:0] Q;
output wire [32:0] A;

output wire done;



/*========================
=         WIRES          =
========================*/

wire [32:0] A_temp;
wire [32:0] A_ALU;
wire [32:0] A_shift;

wire [31:0] Q_temp;
wire [31:0] Q_shift;

wire [32:0] M;

wire [5:0] i;
wire [5:0] i_temp;

wire CONTROL;
wire DONE;

wire load_A;
wire load_Q;
wire load_M;
wire load_i;

wire SEL_A;

wire [1:0] MODE;

Reg_A RA (

    .rst(rst),
    .clk(clk),

    .init(init),

    .load_A(load_A),

    .A_temp(A_temp),

    .A(A)

);


Reg_Q RQ (

    .rst(rst),
    .clk(clk),

    .init(init),

    .load_Q(load_Q),

    .Qin(Qin),

    .Q_temp(Q_temp),

    .Q(Q)

);


Reg_M RM (

    .rst(rst),
    .clk(clk),

    .load_M(load_M),

    .Min(Min),

    .M(M)

);


Reg_i RI (

    .rst(rst),
    .clk(clk),

    .init(init),

    .load_i(load_i),

    .i_temp(i_temp),

    .i(i)

);

Shift_AQ SHIFT (

    .A(A),
    .Q(Q),

    .A_shift(A_shift),
    .Q_shift(Q_shift)

);


ALU ALU0 (

    .A(A),
    .M(M),

    .MODE(MODE),

    .A_ALU(A_ALU)

);


MUX_A MUXA (

    .A_shift(A_shift),
    .A_ALU(A_ALU),

    .SEL_A(SEL_A),

    .A_temp(A_temp)

);


MUX_Q MUXQ (

    .Q_shift(Q_shift),

    .CONTROL(CONTROL),

    .Q_temp(Q_temp)

);

Check_A CHKA (

    .A(A),

    .CONTROL(CONTROL)

);


Check_i CHKI (

    .i(i),

    .DONE(DONE)

);


Rest_i RESTI (

    .i(i),

    .i_temp(i_temp)

);


Control_div CTRL (

    .clk(clk),
    .rst(rst),

    .init(init),

    .CONTROL(CONTROL),
    .DONE(DONE),

    .SEL_A(SEL_A),

    .load_A(load_A),
    .load_Q(load_Q),
    .load_M(load_M),
    .load_i(load_i),

    .MODE(MODE),

    .done(done)

);

endmodule