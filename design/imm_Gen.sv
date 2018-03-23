`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 01/07/2018 10:22:44 PM
// Design Name: 
// Module Name: imm_Gen
// Project Name: 112L_Single_Path
// Target Devices: 
// Tool Versions: 
// Description: imm_Gen with shifter if necessary that generate 32 bits output signal
// 
// Dependencies: 
// 
// Revision: 0.09 - Fix SRAI judgment
// Revision: 0.08 - Fix JALR
// Revision: 0.07 - Fix SRAI, special case
// Revision: 0.06 - Fix JAL, wrong copy/paste before
// Revision: 0.05 - Add Support for JALR
// Revision: 0.04 - Add Build-in Shifter for B-type and JAL
// Revision: 0.03 - Add Support for U type
// Revision: 0.02 - Add Support for B/J type, no debug made
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_Gen(
    input logic [31:0] inst_code,
    output logic [31:0] Imm_out);


always_comb
    case(inst_code[6:0])

        7'b0000011: /*I-type load part*/      
            Imm_out = {inst_code[31]? 20'hFFFFF:20'b0 , inst_code[31:20]};
        7'b0010011: /*I-type*/     
            Imm_out = ((inst_code[31:25] == 7'b0100000) && (inst_code[14:12] == 3'b101)) ? {7'b0, inst_code[24:20]} : /*SRAI*/ 
                        {inst_code[31]? 20'hFFFFF:20'b0 , inst_code[31:20]};    /*rest addi part*/ 
        7'b1100111: /*I-type jalr*/      
            Imm_out = {inst_code[31]? 20'hFFFFF:20'b0 , inst_code[31:20]};

        7'b0100011: /*S-type*/     
            Imm_out = {inst_code[31]? 20'hFFFFF:20'b0 , inst_code[31:25], inst_code[11:7]};

        7'b1100011:  /*B-type*/         
            Imm_out = {inst_code[31]? 19'h7FFFF:19'b0 , inst_code[31], inst_code[7], inst_code[30:25], inst_code[11:8], 1'b0};
        7'b1101111:  /*J-type, JAL*/    
            Imm_out = {inst_code[31]? 11'h7FF:11'b0 , inst_code[31], inst_code[19:12], inst_code[20], inst_code[30:21], 1'b0};

        7'b0110111:  /*U-type, LUI*/     
            Imm_out = {inst_code[31:12], 12'b0};
        7'b0010111:  /*U-type, AUIPC*/   
            Imm_out = {inst_code[31:12], 12'b0};
        default:                     
            Imm_out = {32'b0};

    endcase
    
endmodule
