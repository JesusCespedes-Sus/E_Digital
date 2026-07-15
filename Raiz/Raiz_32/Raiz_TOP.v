module Raiz_TOP (

    clk,
    rst,
    init,

    Ain,

    Raiz,
    done

);

input clk;
input rst;
input init;

input [31:0] Ain;

output [31:0] Raiz;
output done;


//==================================================
// Señales de Control
//==================================================

wire load_A;
wire load_Rs;
wire load_Raiz;
wire load_i;

wire DONE;
wire Control;


//==================================================
// Señales internas
//==================================================

wire [31:0] A;

wire [31:0] Rs;
wire [31:0] Rs_shift;
wire [31:0] Rs_conc;
wire [31:0] Rs_rest;
wire [31:0] Rs_temp;

wire [31:0] Raiz_shift;
wire [31:0] Raiz_sum;
wire [31:0] Raiz_temp;

wire [31:0] Temp;

wire [15:0] i;
wire [15:0] i_temp;

wire [31:0] A_shift;


//==================================================
// Registros
//==================================================

Raiz_Reg_A RA (

    .rst(rst),
    .clk(clk),
    .init(init),
    .load_A(load_A),

    .Ain(Ain),
    .A_temp(A_shift),

    .A(A)

);


Reg_Rs RRS (

    .init(init),
    .rst(rst),
    .clk(clk),

    .load_Rs(load_Rs),

    .Rs_temp(Rs_temp),

    .Rs(Rs)

);


Reg_Raiz RR (

    .init(init),
    .rst(rst),
    .clk(clk),

    .load_Raiz(load_Raiz),

    .Raiz_temp(Raiz_temp),

    .Raiz(Raiz)

);


Raiz_Reg_i RI (

    .rst(rst),
    .clk(clk),

    .load_i(load_i),
    .init(init),

    .i_temp(i_temp),

    .i(i)

);


//==================================================
// Shifts
//==================================================

Shift_Rs SHRS (

    .Rs(Rs),
    .Rs_shift(Rs_shift)

);


Araiz_shift SHAR (

    .Raiz(Raiz),
    .A(A),

    .Raiz_shift(Raiz_shift),
    .A_shift(A_shift)

);


//==================================================
// Construcción de Rs_conc
//==================================================

RS_conc RSC (

    .A(A),
    .Rs_shift(Rs_shift),

    .Rs_conc(Rs_conc)

);


//==================================================
// Temp = (Raiz<<1)+1
//==================================================

Tmp TMP (

    .Raiz_shift(Raiz_shift),

    .Temp(Temp)

);


//==================================================
// Comparador
//==================================================

Raiz_Comp CMP (

    .Rs_conc(Rs_conc),
    .Temp(Temp),

    .Control(Control)

);


//==================================================
// Resta
//==================================================

Rsfin RF (

    .Rs_conc(Rs_conc),
    .Temp(Temp),

    .Rs_rest(Rs_rest)

);


//==================================================
// Raiz + 1
//==================================================

Raizfin RFIN (

    .Raiz_shift(Raiz_shift),

    .Raiz_sum(Raiz_sum)

);


//==================================================
// MUX Rs
//==================================================

MuxRs MRS (

    .Rs_conc(Rs_conc),
    .Rs_rest(Rs_rest),

    .Control(Control),

    .Rs_temp(Rs_temp)

);


//==================================================
// MUX Raiz
//==================================================

MuxRaiz MRAIZ (

    .Raiz_shift(Raiz_shift),
    .Raiz_sum(Raiz_sum),

    .Control(Control),

    .Raiz_temp(Raiz_temp)

);


//==================================================
// Contador
//==================================================

Raiz_Rest_i RESTI (

    .i(i),
    .i_temp(i_temp)

);


Raiz_Check_i CHKI (

    .i(i),
    .DONE(DONE)

);


//==================================================
// FSM
//==================================================

Control_Raiz CTRL (

    .clk(clk),
    .rst(rst),
    .init(init),

    .CONTROL(Control),
    .DONE(DONE),

    .load_A(load_A),
    .load_Rs(load_Rs),
    .load_Raiz(load_Raiz),
    .load_i(load_i),

    .done(done)

);

endmodule