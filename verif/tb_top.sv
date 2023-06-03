`timescale 1ns / 1ps

module tb_top;

  //clock and reset signal declaration
  logic tb_clk, reset;
  logic [31:0] tb_WB_Data;

  logic [4:0] reg_num;
  logic [31:0] reg_data;
  logic reg_write_sig;
  logic wr;
  logic rd;
  logic [8:0] addr;
  logic [31:0] wr_data;
  logic [31:0] rd_data;

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .WB_Data(tb_WB_Data),
      .reg_num(reg_num),
      .reg_data(reg_data),
      .reg_write_sig(reg_write_sig),
      .wr(wr),
      .rd(rd),
      .addr(addr),
      .wr_data(wr_data),
      .rd_data(rd_data)
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    #(CLKPERIOD);
    reset = 0;

    #(CLKPERIOD * 50);

    $stop;
  end

  always_comb begin : MEMORY
    if (wr && ~rd)
      $display($time, ": Memory [%d] written with value: [%X] | [%d]\n", addr, wr_data, wr_data);

    else if (rd && ~wr)
      $display($time, ": Memory [%d] read with value: [%X] | [%d]\n", addr, rd_data, rd_data);
  end : MEMORY

  always_comb begin : REGISTER
    if (reg_write_sig)
      $display(
          $time, ": Register [%d] written with value: [%X] | [%d]\n", reg_num, reg_data, reg_data
      );
  end : REGISTER

  //clock generator
  always #(CLKDELAY) tb_clk = ~tb_clk;

endmodule
