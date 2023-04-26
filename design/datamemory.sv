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

module datamemory#(
    parameter DM_ADDRESS = 9,
    parameter DATA_W = 32
)(
    input logic clk,
    input logic MemRead, // comes from control unit
    input logic MemWrite, // Comes from control unit
    input logic [DM_ADDRESS - 1:0] a, // Read / Write address - 9 LSB bits of the ALU output
    input logic [DATA_W - 1:0] wd, // Write Data
    input logic [2:0] Funct3, // bits 12 to 14 of the instruction
    output logic [DATA_W - 1:0] rd // Read Data
);

    logic [31:0] raddress;
    logic [31:0] waddress;
    logic [31:0] Datain;
    logic [31:0] Dataout;
    logic Wr;
    logic notclk;
    integer fd;

    initial begin
        assign raddress = {{22{1'b0}}, a};
        assign waddress = {{22{1'b0}}, a};
        assign Datain = wd;
        assign Wr = MemWrite;
        assign notclk = ~clk;
    end

    Memoria32Data mem32(
        .raddress(raddress),
        .waddress(waddress),
        .Clk(notclk),
        .Datain(Datain),
        .Dataout(Dataout),
        .Wr(Wr)
    );

    always_comb begin
        if (MemRead) begin
            case (Funct3)
                3'b000: //LB
                    rd <= {Dataout[7] ? 24'hFFFFFF : 24'b0, Dataout[7:0]};
                3'b001: //LH
                    rd <= {Dataout[15] ? 16'hFFFF : 16'b0, Dataout[15:0]};
                3'b010: //LW
                    rd <= Dataout;
                3'b100: //LBU
                    rd <= {24'b0, Dataout[7:0]};
                3'b101: //LHU
                    rd <= {16'b0, Dataout[15:0]};
                default:
                    rd <= Dataout;
            endcase
            
            fd = $fopen("resultData.txt", "a");
            $fwrite(fd, "Read value: [%X] | [%b]\n", rd, rd);
            $fclose(fd);
        end

        else if (MemWrite) begin
            case(Funct3)
                3'b000: //SB
                    mem[a][7:0] =  wd[7:0];
                3'b001: //SH
                    mem[a][15:0] = wd[15:0];
                3'b010: //SW
                    mem[a] = wd;
                default:
                    mem[a] = wd;
            endcase
            fd = $fopen("resultData.txt", "a");
            $fwrite(fd, "Write value: [%X] | [%b] on address [%X]\n", wd, wd, waddress);
            $fclose(fd);
        end
    end
endmodule
