module Control_Raiz (

    clk,
    rst,
    init,

    CONTROL,
    DONE,

    load_A,
    load_Rs,
    load_Raiz,
    load_i,

    done
);

input clk;
input rst;
input init;

input CONTROL;
input DONE;

output reg load_A;
output reg load_Rs;
output reg load_Raiz;
output reg load_i;


output reg done;

parameter S_INIT      = 4'd0;
parameter S_LOAD     = 4'd1;
parameter S_SHIFT_RS  = 4'd2;
parameter S_ASSIGN      = 4'd3;
parameter S_SHIFT_A_R     = 4'd4;
parameter S_CHECK_RS  = 4'd5;
parameter S_CONTROL1  = 4'd6;
parameter S_CONTROL0  = 4'd7;
parameter S_CHK_i     = 4'd8;
parameter S_DONE      = 4'd9;


reg [3:0] state;
reg [3:0] next_state;

reg [3:0] done_count;


always @(posedge clk or posedge rst) begin

    if(rst) begin

        state <= S_INIT;
        done_count <= 4'd0;

    end

    else begin

        state <= next_state;

        if(state == S_DONE)
            done_count <= done_count + 1'b1;

        else
            done_count <= 4'd0;

    end

end


always @(*) begin

    case(state)


        S_INIT: begin

            if(init)
                next_state = S_LOAD;

            else
                next_state = S_INIT;

        end


        S_LOAD: begin

            next_state = S_SHIFT_RS;

        end

        S_SHIFT_RS: begin

            next_state = S_ASSIGN;

        end

        S_ASSIGN: begin

            next_state = S_SHIFT_A_R;

        end

        
        S_SHIFT_A_R: begin

            next_state = S_CHECK_RS;
        end

        S_CHECK_RS: begin
            if(CONTROL)
                next_state = S_CONTROL1;

            else
                next_state = S_CONTROL0;

        end

        S_CONTROL0: begin

            next_state = S_CHK_i;

        end

        S_CONTROL1: begin

            next_state = S_CHK_i;

        end

        S_CHK_i: begin

            if(DONE)
                next_state = S_DONE;

            else
                next_state = S_SHIFT_RS;

        end


        S_DONE: begin

            if(done_count == 4'd15)
                next_state = S_INIT;

            else
                next_state = S_DONE;

        end


        default: begin

            next_state = S_INIT;

        end

    endcase

end


always @(*) begin


    load_A = 1'b0;
    load_Rs = 1'b0;
    load_Raiz = 1'b0;
    load_i = 1'b0;

    done   = 1'b0;


    case(state)


        S_INIT: begin
        end

        S_LOAD: begin
        end

        S_SHIFT_RS: begin
        end

        S_ASSIGN: begin
        end

        S_SHIFT_A_R: begin
        load_A = 1'b1;
        end

        S_CHECK_RS: begin
        end

        S_CONTROL1: begin
            load_Raiz= 1'b1;
            load_Rs = 1'b1;
            load_i = 1'b1;

        end

        S_CONTROL0: begin
            load_Raiz= 1'b1;
            load_Rs = 1'b1;
            load_i = 1'b1;
        end

        S_CHK_i: begin
        end


        S_DONE: begin

            done = 1'b1;

        end

        default: begin
        end

    endcase

end

endmodule