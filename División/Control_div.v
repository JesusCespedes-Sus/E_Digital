module Control_div (

    clk,
    rst,
    init,

    CONTROL,
    DONE,

    SEL_A,

    load_A,
    load_Q,
    load_M,
    load_i,

    MODE,

    done
);

input clk;
input rst;
input init;

input CONTROL;
input DONE;

output reg load_A;
output reg load_Q;
output reg load_M;
output reg load_i;

output reg SEL_A;

output reg [1:0] MODE;

output reg done;

parameter S_INIT      = 4'd0;
parameter S_LOAD      = 4'd1;
parameter S_CONC_SHT  = 4'd2;
parameter S_REST      = 4'd3;
parameter S_CHK_A     = 4'd4;
parameter S_CONTROL0  = 4'd5;
parameter S_CONTROL1  = 4'd6;
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

            next_state = S_CONC_SHT;

        end

        S_CONC_SHT: begin

            next_state = S_REST;

        end

        S_REST: begin

            next_state = S_CHK_A;

        end

        
        S_CHK_A: begin

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
                next_state = S_CONC_SHT;

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
    load_Q = 1'b0;
    load_M = 1'b0;
    load_i = 1'b0;

    SEL_A  = 1'b0;

    MODE   = 2'b10;

    done   = 1'b0;


    case(state)


        S_INIT: begin
        end

        S_LOAD: begin

            load_M = 1'b1;

        end

        S_CONC_SHT: begin

            load_A = 1'b1;

        end

        S_REST: begin

            MODE = 2'b00;
            SEL_A = 1'b1;
            load_A = 1'b1;


        end

        S_CHK_A: begin
        end

        S_CONTROL0: begin

            load_Q = 1'b1;
            load_i = 1'b1;

            MODE = 2'b10;


        end

        S_CONTROL1: begin

            SEL_A = 1'b1;
            MODE = 2'b01;

            load_A = 1'b1;
            load_Q = 1'b1;
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