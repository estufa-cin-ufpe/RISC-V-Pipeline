`timescale 1ns / 1ps

module tb_top;

  //clock and reset signal declaration
  logic tb_clk, reset;
  logic [31:0] tb_WB_Data;
  logic [ 4:0] reg_num;
  logic [31:0] reg_data;

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .WB_Data(tb_WB_Data),
      .reg_num(reg_num),
      .reg_data(reg_data)
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    #(CLKPERIOD);
    reset = 0;

    $monitor($time, ": Register [%d] written with value: [%X] | [%d]\n", reg_num, reg_data,
             reg_data);

    #(CLKPERIOD * 50);

    $stop;
  end

  //clock generator
  always #(CLKDELAY) tb_clk = ~tb_clk;

endmodule
