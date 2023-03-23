`timescale 1ns / 1ps

module tb_top;

//clock and reset signal declaration
  logic tb_clk, reset;
  logic [31:0] tb_WB_Data;

//gerador de clock e reset
  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;

  initial begin
     tb_clk = 0;
     reset = 1;
     #(CLKPERIOD);
     reset = 0;
  end

  always #(CLKDELAY) tb_clk = ~tb_clk;
  
  riscv riscV(
      .clk(tb_clk),
      .reset(reset),
      .WB_Data(tb_WB_Data)      
     );

  initial begin
    #(CLKPERIOD * 50);
    $stop;
   end
endmodule
