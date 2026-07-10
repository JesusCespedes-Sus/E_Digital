module peripheral_mult(

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

input [15:0] d_in;

input cs;
input [4:0] addr;
input rd;
input wr;

output reg [31:0] d_out;

reg [4:0] s;

reg [15:0] Ain;
reg [15:0] B;
reg init;

wire [31:0] result;
wire done;

always @(*) begin

    if(cs) begin

        case(addr)

            5'h04: s = 5'b00001;
            5'h08: s = 5'b00010;
            5'h0C: s = 5'b00100;
            5'h10: s = 5'b01000;
            5'h14: s = 5'b10000;

            default: s = 5'b00000;

        endcase

    end

    else

        s = 5'b00000;

end


always @(posedge clk) begin

    if(reset) begin

        Ain  <= 16'd0;
        B    <= 16'd0;
        init <= 1'b0;

    end

    else begin

        init <= 1'b0;

        if(cs && wr) begin

            if(s[0])
                Ain <= d_in;

            if(s[1])
                B <= d_in;

            if(s[2])
                init <= 1'b1;

        end

    end

end


always @(*) begin

    d_out = 32'd0;

    if(cs) begin

        case(s)

            5'b01000:
                d_out = result;

            5'b10000:
                d_out = {31'd0, done};

            default:
                d_out = 32'd0;

        endcase

    end

end


Mul_Top mult1(

    .clk(clk),
    .rst(reset),

    .init(init),

    .Ain(Ain),
    .B(B),

    .C(result),

    .done(done)

);

endmodule