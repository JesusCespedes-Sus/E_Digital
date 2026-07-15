module peripheral_div(

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


reg [15:0] Qin;
reg [15:0] Min;
reg init;


wire [15:0] Q;
wire [15:0] A;
wire done;


reg [15:0] Q_reg;
reg DONE_reg;

always @(*) begin
    if(cs) begin
        case(addr)

            5'h04: s = 5'b00001; // Qin
            5'h08: s = 5'b00010; // Min
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

        Qin      <= 16'd0;
        Min      <= 16'd0;
        init     <= 1'b0;

        Q_reg    <= 16'd0;
        DONE_reg <= 1'b0;

    end
    else begin

        if(cs && wr) begin

            if(s[0])
                Qin <= d_in;

            if(s[1])
                Min <= d_in;

            if(s[2]) begin

                init <= d_in[0];

                if(d_in[0]) begin
                    DONE_reg <= 1'b0;
                    Q_reg    <= 16'd0;
                end
            end

        end

        if(done) begin
            Q_reg    <= Q;
            DONE_reg <= 1'b1;
        end

    end

end


always @(posedge clk) begin

    if(reset)
        d_out <= 32'd0;

    else if(cs && rd) begin

        case(addr)

            5'h10:
            
                d_out <= Q_reg;

            5'h14:
                d_out <= {31'd0,DONE_reg};

            default:
                d_out <= 32'd0;

        endcase

    end

end


Div_TOP div32(

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