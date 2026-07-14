module Control_bcdbin (

    input  clk,
    input  rst,
    input  init,

    input  DONE,

    output reg load_B,
    output reg load_h,
    output reg load_i,

    output reg done

);

parameter S_INIT    = 3'd0;
parameter S_LOAD    = 3'd1;
parameter S_CHK_I   = 3'd2;
parameter S_PROCESS = 3'd3;
parameter S_CHARGE  = 3'd4;
parameter S_DONE    = 3'd5;

reg [2:0] state;
reg [2:0] next_state;
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

    next_state = state;

    case(state)

        S_INIT: begin

            if(init)
                next_state = S_LOAD;
            else
                next_state = S_INIT;

        end

        S_LOAD: begin

            next_state = S_CHK_I;

        end

        S_CHK_I: begin

            if(DONE)
                next_state = S_DONE;
            else
                next_state = S_PROCESS;

        end

        S_PROCESS: begin

            next_state = S_CHARGE;

        end

        S_CHARGE: begin

            next_state = S_CHK_I;

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

    load_B = 1'b0;
    load_h = 1'b0;
    load_i = 1'b0;
    done   = 1'b0;

    case(state)

        S_LOAD: begin

        end

        S_PROCESS: begin

        end

        S_CHARGE: begin

            load_B = 1'b1;
            load_h = 1'b1;
            load_i = 1'b1;

        end

        S_DONE: begin

            done = 1'b1;

        end

        default: begin
        end

    endcase

end

endmodule