module Control_Paridad (

    clk,
    rst,
    init,
    DONE,
    load_A,
    load_B,
    load_i,
    done
);

input clk;
input rst;
input init;

input DONE;

output reg load_A;
output reg load_B;
output reg load_i;

output reg done;

parameter S_INIT    = 2'd0;
parameter S_LOAD    = 2'd1;
parameter S_PROCESS = 2'd2;
parameter S_DONE    = 2'd3;

reg [1:0] state;
reg [1:0] next_state;

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

            next_state = S_PROCESS;

        end

        S_PROCESS: begin

            if(DONE)
                next_state = S_DONE;
            else
                next_state = S_PROCESS;

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
    load_B = 0;
    load_i = 0;
    done   = 0;

    case(state)

        S_INIT: begin
        end

        S_LOAD: begin

            load_A = 1;

        end

        S_PROCESS: begin

            load_B = 1;
            load_i = 1;

        end

        S_DONE: begin

            done = 1;

        end

        default: begin
        end

    endcase

end

endmodule