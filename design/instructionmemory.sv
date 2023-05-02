
`timescale 1ns / 1ps

module instructionmemory#(
    parameter INS_ADDRESS = 9,
    parameter INS_W = 32
     )(
    input logic clk , // Clock
    input logic [ INS_ADDRESS -1:0] ra , // Read address of the instruction memory , comes from PC
    output logic [ INS_W -1:0] rd // Read Data
    );

    logic [INS_W-1 :0] get_dataOut; // Data output from the memory

    Memoria32 meminst 
    (.raddress(32'(ra)),
     .Clk(~clk),         
     .Dataout(get_dataOut),
     .Wr(1'b1)
    );
    
    assign rd = get_dataOut;

endmodule