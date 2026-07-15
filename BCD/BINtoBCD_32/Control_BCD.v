module Control_BCD (

    clk,
    rst,
    init,

    DONE,

    load_BCD,
    load_B,
    load_i,

    done

);

input clk;
input rst;
input init;

input DONE;

output reg load_BCD;
output reg load_B;
output reg load_i;

output reg done;


parameter S_INIT    = 3'd0;
parameter S_LOAD    = 3'd1;
parameter S_PROCESS = 3'd2;
parameter S_CHK_i   = 3'd3;
parameter S_DONE    = 3'd4;


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

            next_state = S_CHK_i;

        end


        S_CHK_i: begin

            if(DONE)
                next_state = S_DONE;

            else
                next_state = S_PROCESS;

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

    load_BCD = 1'b0;
    load_B   = 1'b0;
    load_i   = 1'b0;

    done     = 1'b0;


    case(state)

        S_INIT: begin
        end


        S_LOAD: begin
            // init se conecta directamente
            // a Reg_BCD, Reg_B y Reg_i
        end


        S_PROCESS: begin

            load_BCD = 1'b1;
            load_B   = 1'b1;
            load_i   = 1'b1;

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