`timescale 1us/1ns

module Cont_TB_tb;
    reg A5, A4, A3, A2, A1, A0, AnotS, CLK;
    wire LED;

    Cont Cont0 (
        .A5(A5), .A4(A4), .A3(A3), .A2(A2), .A1(A1), .A0(A0),
        .AnotS(AnotS), .CLK(CLK), .LED(LED)
    );

    reg [8:0] patterns[0:11];
    integer i;

    initial begin
        $dumpfile("Cont_TB.vcd");
        $dumpvars(0, Cont_TB_tb);

        CLK = 0;
        
        patterns[0]  = 9'b0_100000_0_x;
        patterns[1]  = 9'b0_100000_1_x;
        patterns[2]  = 9'b0_100000_0_1;
        patterns[3]  = 9'b0_000000_0_x;
        patterns[4]  = 9'b0_000000_1_x;
        patterns[5]  = 9'b0_000000_0_1;
        patterns[6]  = 9'b1_100000_0_x;
        patterns[7]  = 9'b1_100000_1_x;
        patterns[8]  = 9'b1_100000_0_0;
        patterns[9]  = 9'b0_000001_0_x;
        patterns[10] = 9'b0_000001_1_x;
        patterns[11] = 9'b0_000001_0_0;

        for (i = 0; i < 12; i = i + 1) begin
            
            AnotS = patterns[i][8];
            {A5, A4, A3, A2, A1, A0} = patterns[i][7:2];
            
            
            CLK = 0; #5;
            CLK = 1; #5; 
            CLK = 0; #5;

            
            if (patterns[i][0] !== 1'hx) begin
                if (LED !== patterns[i][0]) begin
                    $display("Paso %d: LED esperado %h, obtenido %h", i, patterns[i][0], LED);
                end
            end
        end

        
        $dumpoff;
        $finish;
    end
endmodule