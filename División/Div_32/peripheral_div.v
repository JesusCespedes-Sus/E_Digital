module peripheral_div (

    clk,
    reset,

    d_in,

    cs,
    addr,
    rd,
    wr,

    d_out

);

input clk;
input reset;

input [31:0] d_in;

input cs;
input [4:0] addr;
input rd;
input wr;

output reg [31:0] d_out;


reg [5:0] s;

reg [31:0] Qin = 32'd0;
reg [31:0] Min = 32'd0;

reg init = 1'b0;

wire [31:0] Q;
wire [32:0] A;
wire done;


always @(*) begin

    case(addr)

        5'h00:
            s = (cs && wr) ? 6'b000001 : 6'b000000;   // Qin

        5'h04:
            s = (cs && wr) ? 6'b000010 : 6'b000000;   // Min

        5'h08:
            s = (cs && wr) ? 6'b000100 : 6'b000000;   // init

        5'h0C:
            s = (cs && rd) ? 6'b001000 : 6'b000000;   // done

        5'h10:
            s = (cs && rd) ? 6'b010000 : 6'b000000;   // cociente

        default:
            s = 6'b000000;

    endcase

end



always @(negedge clk) begin

    if(s[0])
        Qin <= d_in;

    if(s[1])
        Min <= d_in;

    init <= s[2];

end



always @(negedge clk) begin

    case(s[5:3])

        3'b001:
            d_out <= {31'd0, done};

        3'b010:
            d_out <= Q;

        default:
            d_out <= 32'd0;

    endcase

end



Div_TOP div32 (

    .clk(clk),
    .rst(reset),
    .init(init),

    .Qin(Qin),
    .Min(Min),

    .Q(Q),
    .A(A),

    .done(done)

);

endmodule