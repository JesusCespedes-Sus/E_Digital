module acc(
    input clk, 
    input add, 
    input reset, 
    output reg [3:0] count 
); 
    
    initial count = 0; 

    always @(posedge clk) begin
        if (reset) begin      
            count <= 4'b0;
        end
        else if (add) begin   
            count <= count + 1;
        end
    end

endmodule

