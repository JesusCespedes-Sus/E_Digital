module acc(
    input clk, 
    input reset, 
    output led
); 
    
    reg [25:0] count = 0;

    always @(posedge clk) begin
        if (reset) begin      
            count <= 26'b0;
        end
        else begin   
            count <= count + 1;
        end
    end

    assign led = count[25];

endmodule

