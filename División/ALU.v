module ALU (A, M, MODE, A_ALU
);

input  [32:0] A;
input  [32:0] M;
input  [1:0]  MODE;

output reg [32:0] A_ALU;

always @(*) begin

    case (MODE)

        2'b00:
            A_ALU = A - M;

        2'b01:
            A_ALU = A + M;

        2'b10:
            A_ALU = A;

        default:
            A_ALU = 33'b0;

    endcase

end

endmodule