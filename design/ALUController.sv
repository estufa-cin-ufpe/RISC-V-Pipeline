`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: ALUController
// Project Name: 112L_Single_Path
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//
// Revision: 0.04 - Re-Write, see note "ALU-Operation"
// Revision: 0.03 - Add Support for JAL and JALR 
// Revision: 0.02 - Add Support for B type inst, no debug made, see note
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUController(
    
    //Inputs
    input logic [1:0] ALUOp,  // 2-bit opcode field from the Controller--00: LW/SW/AUIPC; 01:Branch; 10: Rtype/Itype; 11:JAL/LUI
    input logic [6:0] Funct7, // bits 25 to 31 of the instruction
    input logic [2:0] Funct3, // bits 12 to 14 of the instruction
    
    //Output
    output logic [3:0] Operation //operation selection for ALU
);
 
 assign Operation[0] =  ((ALUOp==2'b10) && (Funct3==3'b110)) || // R\I-or
                        ((ALUOp==2'b10) && (Funct3==3'b100)) || // R\I-xor
                        ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0000000)) || // R\I->>
                        ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0100000)) || // R\I->>>
                        ((ALUOp==2'b01) && (Funct3==3'b001)) || // BNE
                        ((ALUOp==2'b01) && (Funct3==3'B101)) || // BGE
                        ((ALUOp==2'b01) && (Funct3==3'b111));   // BGEU

 assign Operation[1] =  (ALUOp==2'b00) ||   // SW\SW\AUIPC\JALR-add
                        ((ALUOp==2'b10) && (Funct3==3'b000)) || // R\I-add
                        ((ALUOp==2'b10) && (Funct3==3'b100)) || // R\I-xor
                        ((ALUOp==2'b10) && (Funct7==7'b0100000) && (Funct3==3'b000)) ||  // R-sub
                        ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0100000)) || // R\I->>>
                        (ALUOp==2'b11) ||   // JAL\LUI: return1
                        ((ALUOp==2'b10) && (Funct3==3'b011)) || // SLTIU, SLTU: <u
                        ((ALUOp==2'b01) && (Funct3==3'b110)) || // BLTU
                        ((ALUOp==2'b01) && (Funct3==3'b111));   // BGEU

 assign Operation[2] =  ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0000000)) || // R\I->>
                        ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0100000)) || // R\I->>>
                        ((ALUOp==2'b10) && (Funct3==3'b001)) || // R\I-<<
                        ((ALUOp==2'b10) && (Funct7==7'b0100000) && (Funct3==3'b000)) ||  // R-sub
                        ((ALUOp==2'b10) && (Funct3==3'b010)) || // R\I-<
                        ((ALUOp==2'b10) && (Funct3==3'b011)) || // SLTIU, SLTU: <u
                        ((ALUOp==2'b01) && (Funct3==3'b110)) || // BLTU
                        ((ALUOp==2'b01) && (Funct3==3'b100)) || // BLT
                        ((ALUOp==2'b01) && (Funct3==3'B101)) || // BGE
                        ((ALUOp==2'b01) && (Funct3==3'b111));   // BGEU

 assign Operation[3]=   (ALUOp==2'b01) || // BNE, BEQ, BLT, BGE, BLTU, BGEU
                        (ALUOp==2'b11) ||   // JAL\LUI: return1
                        ((ALUOp==2'b10) && (Funct3==3'b010)) || // R\I-<
                        ((ALUOp==2'b10) && (Funct3==3'b011));   // SLTIU, SLTU: <u
endmodule
