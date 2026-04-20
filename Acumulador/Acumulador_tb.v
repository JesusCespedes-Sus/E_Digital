`timescale 1s / 1ms   // Definimos la unidad en segundos para que sea lento

module acc_TB;

   reg clk;
   reg add;
   reg reset; // Cambiado rst -> reset para coincidir con tu módulo
   wire [3:0] count;

   // Conexión exacta con los puertos de tu módulo 'acc'
   acc uut( 
       .clk(clk), 
       .add(add), 
       .reset(reset), 
       .count(count) 
   );

   // Parámetros para un reloj de 1 segundo (Periodo = 1)
   parameter PERIOD          = 1.0;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0.1;

   // Generador de Reloj (1 segundo por ciclo)
   initial begin
     #OFFSET;
     forever begin
         clk = 1'b0;
         #(PERIOD * (1 - DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD * DUTY_CYCLE);
     end
   end

   // Lógica de estímulos adaptada
   integer i; // Usamos integer para el bucle
   initial begin 
        // Estado inicial
        reset = 0; add = 0;
        clk = 0;

        // Proceso de Reset
        #0.5 reset = 1;     // Activa reset
        @(posedge clk);     // Espera un flanco de subida
        @(negedge clk);     // Espera un flanco de bajada
        reset = 0;          // Desactiva reset
        
        // Empezar a contar
        @(posedge clk);
        add = 1;

        // Contar durante 10 ciclos (10 segundos)
        for(i=0; i<10; i=i+1) begin
            @(posedge clk);
        end

        add = 0;            // Deja de contar
        #2 $finish;         // Espera 2 segundos más y termina
   end

   // Configuración para GTKWave
   initial begin: TEST_CASE
     $dumpfile("acc_TB.vcd");
     $dumpvars(0, acc_TB); // Grabamos todo el contenido del TB
   end

endmodule
