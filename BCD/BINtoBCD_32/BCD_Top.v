module BCD_Top (

    clk,
    rst,
    init,

    Bin,

    BCD,

    done

);

input clk;
input rst;
input init;

input wire [31:0] Bin;

output wire [39:0] BCD;

output wire done;

wire [39:0] BCD_add;
wire [39:0] BCD_temp;

wire [31:0] B;
wire [31:0] B_temp;

wire [5:0] i;
wire [5:0] i_temp;

wire DONE;

wire load_BCD;
wire load_B;
wire load_i;


Reg_BCD RBCD (

    .rst(rst),
    .clk(clk),

    .init(init),

    .load_BCD(load_BCD),

    .BCD_temp(BCD_temp),

    .BCD(BCD)

);


Bin_Reg_B RB (

    .rst(rst),
    .clk(clk),

    .init(init),

    .load_B(load_B),

    .Bin(Bin),

    .B_temp(B_temp),

    .B(B)

);


Bin_Reg_i RI (

    .rst(rst),
    .clk(clk),

    .init(init),

    .load_i(load_i),

    .i_temp(i_temp),

    .i(i)

);

Add3_BCD ADD3 (

    .BCD(BCD),

    .BCD_add(BCD_add)

);


SHT_B SHB (

    .B(B),

    .B_sht(B_temp)

);


Conc_BCD CONC (

    .BCD_add(BCD_add),

    .B(B),

    .BCD_temp(BCD_temp)

);


Bin_Rest_i RESTI (

    .i(i),

    .i_temp(i_temp)

);


Bin_Check_i CHKI (

    .i(i),

    .DONE(DONE)

);


Control_BCD CTRL (

    .clk(clk),
    .rst(rst),

    .init(init),

    .DONE(DONE),

    .load_BCD(load_BCD),
    .load_B(load_B),
    .load_i(load_i),

    .done(done)

);

endmodule