`timescale 1ns / 1ps

module SOC (
    input        clk,
    input        resetn,
    output wire  LEDS,
    input        RXD,
    output       TXD
);

   wire [31:0] mem_addr;
   reg  [31:0] mem_rdata;
   wire mem_rstrb;
   wire [31:0] mem_wdata;
   wire [3:0]  mem_wmask;



   reg [7:0] cs;


   FemtoRV32 CPU(
      .clk(clk),
      .reset(resetn),
      .mem_addr(mem_addr),
      .mem_rdata(mem_rdata),
      .mem_rstrb(mem_rstrb),
      .mem_wdata(mem_wdata),
      .mem_wmask(mem_wmask),
      .mem_rbusy(1'b0),
      .mem_wbusy(1'b0)
   );

   wire [31:0] RAM_rdata;

   wire wr = |mem_wmask;
   wire rd = mem_rstrb;

   bram RAM(
      .clk(clk),
      .mem_addr(mem_addr),
      .mem_rdata(RAM_rdata),
      .mem_rstrb(cs[0] & rd),
      .mem_wdata(mem_wdata),
      .mem_wmask({4{cs[0]}} & mem_wmask)
   );



   wire [31:0] uart_dout;
   wire [31:0] sqrt_dout;
   wire [31:0] mult_dout;
   wire [31:0] div_dout;
   wire [31:0] bin2bcd_dout;
   wire [31:0] bcd2bin_dout;



   peripheral_uart #(
      .clk_freq(25000000),
      .baud(57600)
   ) per_uart(
      .clk(clk),
      .rst(!resetn),
      .d_in(mem_wdata),
      .cs(cs[1]),
      .addr(mem_addr[4:0]),
      .rd(rd),
      .wr(wr),
      .d_out(uart_dout),
      .uart_tx(TXD),
      .uart_rx(RXD),
      .ledout(LEDS)
   );


   peripheral_sqrt sqrt0(
      .clk(clk),
      .reset(!resetn),
      .d_in(mem_wdata),
      .cs(cs[2]),
      .addr(mem_addr[4:0]),
      .rd(rd),
      .wr(wr),
      .d_out(sqrt_dout)
   );


   peripheral_mult mult0(
      .clk(clk),
      .reset(!resetn),
      .d_in(mem_wdata),
      .cs(cs[3]),
      .addr(mem_addr[4:0]),
      .rd(rd),
      .wr(wr),
      .d_out(mult_dout)
   );


   peripheral_div div0(
      .clk(clk),
      .reset(!resetn),
      .d_in(mem_wdata),
      .cs(cs[4]),
      .addr(mem_addr[4:0]),
      .rd(rd),
      .wr(wr),
      .d_out(div_dout)
   );

   peripheral_bin2bcd bin2bcd0(
      .clk(clk),
      .reset(!resetn),
      .d_in(mem_wdata),
      .cs(cs[5]),
      .addr(mem_addr[4:0]),
      .rd(rd),
      .wr(wr),
      .d_out(bin2bcd_dout)
   );


   peripheral_bcd2bin bcd2bin0(
      .clk(clk),
      .reset(!resetn),
      .d_in(mem_wdata),
      .cs(cs[6]),
      .addr(mem_addr[4:0]),
      .rd(rd),
      .wr(wr),
      .d_out(bcd2bin_dout)
   );


always @(*) begin

    case(mem_addr[31:16])

        16'h0000: cs = 8'b00000001; // RAM
        16'h0040: cs = 8'b00000010; // UART
        16'h0041: cs = 8'b00000100; // SQRT
        16'h0042: cs = 8'b00001000; // MULT
        16'h0043: cs = 8'b00010000; // DIV
        16'h0044: cs = 8'b00100000; // BIN2BCD
        16'h0046: cs = 8'b01000000; // BCD2BIN
        16'h0045: cs = 8'b10000000; // libre
        

        default:  cs = 8'b00000001;

    endcase

end


always @(*) begin

    case(cs)

        8'b01000000: mem_rdata = bcd2bin_dout;
        8'b00000001: mem_rdata = RAM_rdata;   
        8'b00000010: mem_rdata = uart_dout;
        8'b00000100: mem_rdata = sqrt_dout;
        8'b00001000: mem_rdata = mult_dout;
        8'b00010000: mem_rdata = div_dout;
        8'b00100000: mem_rdata = bin2bcd_dout;

        default: mem_rdata = RAM_rdata;

    endcase

end

`ifdef BENCH

   always @(posedge clk) begin

      if(cs[1] && wr) begin

         $write("%c", mem_wdata[7:0]);
         $fflush(32'h8000_0001);

      end

   end

`endif

endmodule