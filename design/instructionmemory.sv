
`timescale 1ns / 1ps

module instructionmemory #(
    parameter INS_ADDRESS = 9,
    parameter INS_W = 32
) (
    input logic clk,  // Clock
    input logic [INS_ADDRESS -1:0] ra,  // Read address of the instruction memory , comes from PC
    output logic [INS_W -1:0] rd  // Read Data
);

  logic [INS_W-1 : 0] get_dataOut;  // Data output from the memory

  Memoria32 meminst (
      .raddress(32'(ra)),
      .waddress(32'b0),  // unused
      .Clk(~clk),
      .Datain(32'b0),  // unused
      .Dataout(get_dataOut),
      .Wr(1'b0)  // unused
  );

  assign rd = get_dataOut;

endmodule
