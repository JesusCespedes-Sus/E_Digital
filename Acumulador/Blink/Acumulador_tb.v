`timescale 1ns / 1ps

module acc_TB;

   reg clk;
   reg reset; 
   wire led;

   acc uut( 
       .clk(clk), 
       .reset(reset), 
       .led(led) 
   );

   // 50 MHz → 20 ns periodo
   parameter PERIOD = 20;

   // Clock
   initial begin
     clk = 0;
     forever #(PERIOD/2) clk = ~clk;
   end

   initial begin 
        reset = 1;
        #50;
        reset = 0;

        // Simular un tiempo largo (pero ojo: esto sigue siendo pesado)
        #200000000; // 0.2 segundos simulados
        $finish;        
   end

   initial begin
     $dumpfile("acc_TB.vcd");
     $dumpvars(0, acc_TB); 
   end

endmodule

