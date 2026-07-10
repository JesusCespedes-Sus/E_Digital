module peripheral_bin2bcd(

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


//-----------------------------------------------------
// Registros y señales internas
//-----------------------------------------------------

reg [4:0] s;

reg [31:0] Bin;
reg init;

wire [39:0] BCD;
wire done;


//-----------------------------------------------------
// Decodificador de direcciones
//-----------------------------------------------------

always @(*) begin

    if(cs) begin

        case(addr)

            5'h04: s = 5'b00001; // Bin
            5'h0C: s = 5'b00100; // init
            5'h10: s = 5'b01000; // resultado BCD
            5'h14: s = 5'b10000; // done

            default: s = 5'b00000;

        endcase

    end

    else
        s = 5'b00000;

end


//-----------------------------------------------------
// Escritura de registros
//-----------------------------------------------------

always @(posedge clk) begin

    if(reset) begin

        Bin  <= 32'd0;
        init <= 1'b0;

    end

    else begin

        // init es un pulso de un ciclo
        init <= 1'b0;

        if(cs && wr) begin

            if(s[0])
                Bin <= d_in;

            if(s[2])
                init <= d_in[0];

        end

    end

end



always @(posedge clk) begin

    if(reset)

        d_out <= 32'd0;

    else if(cs && rd) begin

        case(s)

            // Resultado BCD (32 bits menos significativos)
            5'b01000:
                d_out <= BCD[31:0];

            // Señal de finalización
            5'b10000:
                d_out <= {31'd0, done};

            default:
                d_out <= 32'd0;

        endcase

    end

end



BCD_Top bin2bcd0 (

    .clk(clk),
    .rst(reset),

    .init(init),

    .Bin(Bin),

    .BCD(BCD),

    .done(done)

);

endmodule