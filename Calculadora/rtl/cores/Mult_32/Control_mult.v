module Control_mult (

    clk,
    rst,
    init,
    CONTROL,
    DONE,
    load_A,
    load_C,
    load_D,
    load_i,
    DSHT,
    done
);

input clk;
input rst;
input init;

input CONTROL;
input DONE;

output reg load_A;
output reg load_C;
output reg load_D;
output reg load_i;

output reg DSHT;
output reg done;

parameter S_INIT     = 4'd0;
parameter S_LOAD     = 4'd1;
parameter S_SLT_Ai   = 4'd2;
parameter S_COMP_Ai  = 4'd3;
parameter S_Ai0      = 4'd4;
parameter S_Ai1      = 4'd5;
parameter S_CHK_i    = 4'd6;
parameter S_ADDi_DS  = 4'd7;
parameter S_DONE     = 4'd8;

reg [3:0] state;
reg [3:0] next_state;

always @(posedge clk or posedge rst) begin

    if (rst)
        state <= S_INIT;

    else
        state <= next_state;

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

            next_state = S_SLT_Ai;

        end

        S_SLT_Ai: begin

            next_state = S_COMP_Ai;

        end

        S_COMP_Ai: begin

            if(CONTROL)
                next_state = S_Ai1;

            else
                next_state = S_Ai0;

        end

        S_Ai0: begin

            next_state = S_CHK_i;

        end

        S_Ai1: begin

            next_state = S_CHK_i;

        end

        S_CHK_i: begin

            if(DONE)
                next_state = S_DONE;

            else
                next_state = S_ADDi_DS;

        end

        S_ADDi_DS: begin

            next_state = S_SLT_Ai;

        end

        S_DONE: begin

            if(!init)
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

    load_A = 0;
    load_C = 0;
    load_D = 0;
    load_i = 0;
    DSHT = 0;
    done = 0;


    case(state)

        S_INIT: begin
        end

        S_LOAD: begin

            load_A = 1;
            load_D = 1;

        end

        S_SLT_Ai: begin
        end

        S_COMP_Ai: begin
        end

        S_Ai0: begin
        end

        S_Ai1: begin

            load_C = 1;

        end

        S_CHK_i: begin
        end


        S_ADDi_DS: begin

            load_i = 1;
            DSHT   = 1;

        end

        S_DONE: begin

            done = 1;

        end

        default: begin
        end

    endcase

end

endmodule