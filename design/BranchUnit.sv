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
    logic [1:0] New_PC_Sel;

    assign PC_Full = {23'b0, Cur_PC};
    assign PC_Imm = PC_Full + Imm;
    assign PC_Four = PC_Full + 32'b100;

    assign Branch_Sel = Branch && AluResult[0]; // 0:Branch is taken; 1:Branch is not taken
    assign New_PC_Sel[0] = JalrSel;
    assign New_PC_Sel[1] = Branch_Sel;
    
    assign BrPC = (New_PC_Sel==2'b11) ? AluResult :     // 11:Jalr is taken
                  (New_PC_Sel==2'b10) ? PC_Imm : 32'b0;  // 10:Branch/Jal is tanekn
    assign PcSel = (New_PC_Sel==2'b11) || (New_PC_Sel==2'b10);  // 1:branch is taken; 0:branch is not taken(choose pc+4)

endmodule
