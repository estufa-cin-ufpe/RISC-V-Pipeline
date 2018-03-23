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
    parameter DM_ADDRESS = 9 ,
    parameter DATA_W = 32
    )(
    input logic clk,
	input logic MemRead , // comes from control unit
    input logic MemWrite , // Comes from control unit
    input logic [ DM_ADDRESS -1:0] a , // Read / Write address - 9 LSB bits of the ALU output
    input logic [ DATA_W -1:0] wd , // Write Data
    input logic [2:0] Funct3, // bits 12 to 14 of the instruction
    output logic [ DATA_W -1:0] rd // Read Data
    );
    
    logic [DATA_W-1:0] mem [(2**DM_ADDRESS)-1:0];
    
    always_comb 
    begin
       if(MemRead)
        begin
            case(Funct3)
            3'b000: //LB
                rd = {mem[a][7]? 24'hFFFFFF:24'b0, mem[a][7:0]};
            3'b001: //LH
                rd = {mem[a][15]? 16'hFFFF:16'b0, mem[a][15:0]};
            3'b010: //LW
                rd = mem[a];
            3'b100: //LBU
                rd = {24'b0, mem[a][7:0]};
            3'b101: //LHU
                rd = {16'b0, mem[a][15:0]};
            default:
                rd = mem[a];
            endcase
        end
	end
    
    always @(posedge clk) 
    begin
       if (MemWrite)
        begin
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
        end
    end
    
endmodule

