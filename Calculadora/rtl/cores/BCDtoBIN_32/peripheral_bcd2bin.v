module peripheral_bcd2bin(

    input clk,
    input reset,

    input [31:0] d_in,
    input cs,
    input [4:0] addr,
    input rd,
    input wr,

    output reg [31:0] d_out

);

reg [3:0] s;

reg [31:0] BCD_reg;
reg init;

wire [31:0] BIN_wire;
wire done_wire;

reg [31:0] BIN_reg;
reg DONE_reg;


always @(*) begin

    if(cs) begin

        case(addr)

            5'h04: s = 4'b0001;   // Entrada BCD
            5'h0C: s = 4'b0010;   // init
            5'h10: s = 4'b0100;   // Resultado
            5'h14: s = 4'b1000;   // DONE

            default: s = 4'b0000;

        endcase

    end
    else begin

        s = 4'b0000;

    end

end


always @(posedge clk) begin

    if(reset) begin

        BCD_reg  <= 32'd0;
        init     <= 1'b0;
        BIN_reg  <= 32'd0;
        DONE_reg <= 1'b0;

    end
    else begin

        if(cs && wr) begin

            if(s[0])
                BCD_reg <= d_in;

            if(s[1]) begin

                init <= d_in[0];

                if(d_in[0]) begin
                    DONE_reg <= 1'b0;
                    BIN_reg  <= 32'd0;
                end

            end

        end

        if(done_wire) begin
            BIN_reg  <= BIN_wire;
            DONE_reg <= 1'b1;
        end

    end

end


always @(posedge clk) begin

    if(reset)

        d_out <= 32'd0;

    else if(cs && rd) begin

        case(addr)

            5'h10: d_out <= BIN_reg;
            5'h14: d_out <= {31'd0,DONE_reg};

            default: d_out <= 32'd0;

        endcase

    end

end


BCDBIN_TOP bcd2bin0(

    .clk(clk),
    .rst(reset),
    .init(init),

    .bcdin(BCD_reg),

    .B(BIN_wire),
    .done(done_wire)

);

endmodule