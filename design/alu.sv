`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 01/07/2018 10:23:43 PM
// Design Name: 
// Module Name: alu
// Project Name: 112L_Single_Path
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//
// Revision: 0.07 - A better Shift Expression
// Revision: 0.06 - Re-write Output Zero to be the 0 digits of AluResult
// Revision: 0.05 - Add Support for >>>, modify comparation
// Revision: 0.04 - Add More Operations
// Revision: 0.03 - Add support for Jump
// Revision: 0.02 - Add support for Branch, no debug made, see note 2/23 03:31
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:        // OR
                    ALUResult = SrcA | SrcB;
            4'b0010:        // ADD
                    ALUResult = $signed(SrcA) + $signed(SrcB);
            4'b0011:        // XOR
                    ALUResult = SrcA ^ SrcB;
            4'b0100:        // Left Shift
                    ALUResult = SrcA << SrcB[4:0];
            4'b0101:        // Right Shift
                    ALUResult = SrcA >> SrcB[4:0];
            4'b0110:        // Subtract
                    ALUResult = $signed(SrcA) - $signed(SrcB);
            4'b0111:        // Right Shift Arithm
                    ALUResult = $signed(SrcA) >>> SrcB[4:0];

            4'b1000:        // Equal
                    ALUResult = (SrcA == SrcB) ? 1 : 0;
            4'b1001:        // Not Equal
                    ALUResult = (SrcA != SrcB) ? 1 : 0;
            4'b1100:        // Less Than
                    ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0;
            4'b1101:        // Greater/Equal Than
                    ALUResult = ($signed(SrcA) >= $signed(SrcB)) ? 1 : 0;
            4'b1110:        // Unsigned Less Than
                    ALUResult = (SrcA < SrcB) ? 1 : 0;
            4'b1111:        // Unsigned Greater/Equal Than
                    ALUResult = (SrcA >= SrcB) ? 1 : 0;
            4'b1010:        // Always True, for jal
                    ALUResult = 1;
            default:
                    ALUResult = 0;
            endcase
        end
endmodule

