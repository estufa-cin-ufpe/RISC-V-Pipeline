`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 03/16/2018 10:21:50 PM
// Design Name: 
// Module Name: Branch Unit
// Project Name: 112L_PipeLine
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.05 - Fix Jalr Select Bug
// Revision: 0.04 - Fix Flush logic
// Revision: 0.03 - Fix Width Bug
// Revision: 0.02 - Fix PcSel Bug
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BranchUnit
    #(parameter PC_W = 9)
    (input logic [PC_W-1:0] Cur_PC,
     input logic [31:0] Imm,
     input logic JalrSel,
     input logic Branch,
     input logic [31:0] AluResult,
     output logic [31:0] PC_Imm,
     output logic [31:0] PC_Four,
     output logic [31:0] BrPC,
     output logic PcSel);

    logic Branch_Sel;
    logic [31:0] PC_Full;

    assign PC_Full = {23'b0, Cur_PC};
    assign PC_Imm = PC_Full + Imm;
    assign PC_Four = PC_Full + 32'b100;

    assign Branch_Sel = Branch && AluResult[0]; // 0:Branch is taken; 1:Branch is not taken
    
    assign BrPC = (JalrSel) ? AluResult :     // Jalr -> AluResult
                  (Branch_Sel) ? PC_Imm : 32'b0;  // Branch/Jal -> PC+Imm   // Otherwise, BrPC value is not important
    assign PcSel = JalrSel || Branch_Sel;  // 1:branch (b/jal/jalr) is taken; 0:branch is not taken(choose pc+4)

endmodule
