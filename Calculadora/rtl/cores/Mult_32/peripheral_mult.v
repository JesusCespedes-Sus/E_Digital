module peripheral_mult(

    input clk,
    input reset,

    input [31:0] d_in,
    input cs,
    input [4:0] addr,
    input rd,
    input wr,

    output reg [31:0] d_out

);

reg [4:0] s;


reg [15:0] Ain;
reg [15:0] Bin;
reg init;

wire [31:0] result_wire;
wire done_wire;

reg [31:0] result_reg;
reg done_reg;


always @(*) begin
    if(cs) begin
        case(addr)
            5'h04: s = 5'b00001; // A
            5'h08: s = 5'b00010; // B
            5'h0C: s = 5'b00100; // init
            5'h10: s = 5'b01000; // resultado
            5'h14: s = 5'b10000; // done
            default: s = 5'b00000;
        endcase
    end
    else begin
        s = 5'b00000;
    end
end


always @(posedge clk) begin

    if(reset) begin

        Ain        <= 16'd0;
        Bin        <= 16'd0;
        init       <= 1'b0;
        result_reg <= 32'd0;
        done_reg   <= 1'b0;

    end
    else begin

        if(cs && wr) begin

            if(s[0])
                Ain <= d_in[15:0];

            if(s[1])
                Bin <= d_in[15:0];

            if(s[2]) begin
                init <= d_in[0];

                if(d_in[0]) begin
                    done_reg   <= 1'b0;
                    result_reg <= 32'd0;
                end
            end

        end

        if(done_wire) begin
            result_reg <= result_wire;
            done_reg   <= 1'b1;
        end

    end

end



always @(posedge clk) begin

    if(reset)
        d_out <= 32'd0;

    else if(cs && rd) begin

        case(addr)

            5'h10:
                d_out <= result_reg;

            5'h14:
                d_out <= {31'd0, done_reg};

            default:
                d_out <= 32'd0;

        endcase

    end

end



Mul_Top mult1(

    .clk(clk),
    .rst(reset),

    .init(init),

    .Ain(Ain),
    .B(Bin),

    .C(result_wire),

    .done(done_wire)

);

endmodule