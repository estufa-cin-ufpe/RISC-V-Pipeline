`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: Datamemory
// Project Name: 112L_Single_Path
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.03 - Sign Extension Fixed
// Revision: 0.03 - Minor Bug Fixed
// Revision: 0.02 - Add support for sb,sh,lb,lh
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module datamemory #(
    parameter DM_ADDRESS = 9,
    parameter DATA_W = 32
) (
    input logic clk,
    input logic MemRead,  // comes from control unit
    input logic MemWrite,  // Comes from control unit
    input logic [DM_ADDRESS - 1:0] a,  // Read / Write address - 9 LSB bits of the ALU output
    input logic [DATA_W - 1:0] wd,  // Write Data
    input logic [2:0] Funct3,  // bits 12 to 14 of the instruction
    output logic [DATA_W - 1:0] rd  // Read Data
);

  logic [31:0] raddress;
  logic [31:0] waddress;
  logic [31:0] Datain;
  logic [31:0] Dataout;
  logic [ 3:0] Wr;

  Memoria32Data mem32 (
      .raddress(raddress),
      .waddress(waddress),
      .Clk(~clk),
      .Datain(Datain),
      .Dataout(Dataout),
      .Wr(Wr)
  );

  always_ff @(*) begin
    raddress = {{22{1'b0}}, a};
    waddress = {{22{1'b0}}, {a[8:2], {2{1'b0}}}};
    Datain = wd;
    Wr = 4'b0000;

    if (MemRead) begin
      case (Funct3)
        3'b000:  //LB
        rd <= {Dataout[7] ? 24'hFFFFFF : 24'b0, Dataout[7:0]};
        3'b001:  //LH
        rd <= {Dataout[15] ? 16'hFFFF : 16'b0, Dataout[15:0]};
        3'b010:  //LW
        rd <= Dataout;
        3'b100:  //LBU
        rd <= {24'b0, Dataout[7:0]};
        3'b101:  //LHU
        rd <= {16'b0, Dataout[15:0]};
        default: rd <= Dataout;
      endcase
    end else if (MemWrite) begin
      case (Funct3)
        3'b000: begin  //SB
          Wr <= (a[1:0]==2'b00) ? 4'b0001 : ((a[1:0]==2'b01) ? 4'b0010 : ((a[1:0]==2'b10) ? 4'b0100 : 4'b1000));
          Datain <= (a[1:0]==2'b00) ? {{24{1'b0}}, wd[7:0]} : ((a[1:0]==2'b01) ? {{16{1'b0}}, {wd[7:0], {8{1'b0}}}} : ((a[1:0]==2'b10) ? {{8{1'b0}}, {wd[7:0], {16{1'b0}}}} : {wd[7:0], {24{1'b0}}}));
        end
        3'b001: begin  //SH
          Wr <= (a[1:0] == 2'b00 || a[1:0] == 2'b01) ? 4'b0011 : 4'b1100;
          Datain <= (a[1:0]==2'b00) || (a[1:0]==2'b01) ? {{16{1'b0}}, wd[15:0]} : {wd[15:0], {16{1'b0}}};
        end
        default: begin  //SW
          Wr <= 4'b1111;
          Datain <= wd;
        end
      endcase
    end
  end

endmodule
