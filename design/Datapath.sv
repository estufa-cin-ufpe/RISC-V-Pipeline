`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 03/19/2018 10:10:33 PM
// Design Name: 
// Module Name: Datapath
// Project Name: 112L_PipeLine
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//
// Revision: 0.14 - Fix Hazard Detection
// Revision: 0.13 - Fix a Forwarding Unit Bug
// Revision: 0.12 - ReWrite Branch Unit Logic (Give Flush Signal immediately)
// Revision: 0.11 - Fix Flush logic (caused by branch)
// Revision: 0.10 - Add Hazard Detection
// Revision: 0.09 - Fix a bug that cause Controller delay one stage
// Revision: 0.08 - Add Forwarding Unit
// Revision: 0.07 - Fix resmux(input port)
// Revision: 0.06 - Add Initialization
// Revision: 0.06 - Fix Port Name/Size
// Revision: 0.05 - Switch to PipeLine Model, no debug made
// Revision: 0.04 - Reset WB_DATA Signal
// Revision: 0.03 - Re-write PC+Imm
// Revision: 0.02 - modify datamemory
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
import Pipe_Buf_Reg_PKG::*;

module Datapath #(
    parameter PC_W = 9, // Program Counter
    parameter INS_W = 32, // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32, // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4 // ALU Control Code Width
    )(
    input logic clk , reset , // global clock
                              // reset , sets the PC to zero
    RegWrite , MemtoReg ,     // Register file writing enable   // Memory or ALU MUX
    ALUsrc , MemWrite ,       // Register file or Immediate MUX // Memroy Writing Enable
    MemRead ,                 // Memroy Reading Enable
    Branch ,                  // Branch Enable
    JalrSel ,                 // Jalr Mux Select
    input logic [1:0] ALUOp ,
    input logic [1:0] RWSel , // Mux4to1 Select
    input logic [ALU_CC_W -1:0] ALU_CC, // ALU Control Code ( input of the ALU )
    output logic [6:0] opcode,
    output logic [6:0] Funct7,
    output logic [2:0] Funct3,
    output logic [1:0] ALUOp_Current,
    output logic [DATA_W-1:0] WB_Data, //Result After the last MUX
    
    // Para depuração no tesbench:
    output logic [4:0] reg_num, //número do registrador que foi escrito
    output logic [DATA_W-1:0] reg_data,   //valor que foi escrito no registrador
    output logic reg_write_sig, //sinal de escrita no registrador

    output logic wr, // write enable
    output logic reade, // read enable
    output logic [DM_ADDRESS-1:0] addr, // address
    output logic [DATA_W-1:0] wr_data, // write data
    output logic [DATA_W-1:0] rd_data // read data
    );

logic [PC_W-1:0] PC, PCPlus4, Next_PC;
logic [INS_W-1:0] Instr;
logic [DATA_W-1:0] Reg1, Reg2;
logic [DATA_W-1:0] ReadData;
logic [DATA_W-1:0] SrcB, ALUResult;
logic [DATA_W-1:0] ExtImm,BrImm,Old_PC_Four,BrPC;
logic [DATA_W-1:0] WRMuxResult,WrmuxSrc;
logic PcSel;    // mux select / flush signal
logic [1:0] FAmuxSel;
logic [1:0] FBmuxSel;
logic [DATA_W-1:0] FAmux_Result;
logic [DATA_W-1:0] FBmux_Result;
logic Reg_Stall;    //1: PC fetch same, Register not update

if_id_reg A;
id_ex_reg B;
ex_mem_reg C;
mem_wb_reg D;

// next PC
    adder #(9) pcadd(PC, 9'b100, PCPlus4);
    mux2 #(9) pcmux(PCPlus4, BrPC[PC_W-1:0], PcSel, Next_PC);
    flopr #(9) pcreg(clk, reset, Next_PC, Reg_Stall, PC);
    instructionmemory instr_mem (clk, PC, Instr);

// IF_ID_Reg A;
    always @(posedge clk) 
    begin
        if ((reset) || (PcSel))   // initialization or flush
        begin
            A.Curr_Pc <= 0;
            A.Curr_Instr <= 0;
        end
        else if (!Reg_Stall)    // stall
        begin
            A.Curr_Pc <= PC;
            A.Curr_Instr <= Instr;
        end
    end

    //--// The Hazard Detection Unit
    HazardDetection detect(A.Curr_Instr[19:15], A.Curr_Instr[24:20], B.rd, B.MemRead, Reg_Stall);

    // //Register File
    assign opcode = A.Curr_Instr[6:0];

    RegFile rf(clk, reset, D.RegWrite, D.rd, A.Curr_Instr[19:15], A.Curr_Instr[24:20],
            WRMuxResult, Reg1, Reg2);

    assign reg_num = D.rd;
    assign reg_data = WRMuxResult;
    assign reg_write_sig = D.RegWrite;

    // //sign extend
    imm_Gen Ext_Imm (A.Curr_Instr,ExtImm);

// ID_EX_Reg B;
    always @(posedge clk) 
    begin
        if ((reset) || (Reg_Stall) || (PcSel))   // initialization or flush or generate a NOP if hazard
        begin
            B.ALUSrc <= 0;
            B.MemtoReg <= 0;
            B.RegWrite <= 0;
            B.MemRead <= 0;
            B.MemWrite <= 0;
            B.ALUOp <= 0;
            B.Branch <= 0;
            B.JalrSel <= 0;
            B.RWSel <= 0;
            B.Curr_Pc <= 0;
            B.RD_One <= 0;
            B.RD_Two <= 0;
            B.RS_One <= 0;
            B.RS_Two <= 0;
            B.rd <= 0;
            B.ImmG <= 0;
            B.func3 <= 0;
            B.func7 <= 0;
             B.Curr_Instr <= A.Curr_Instr;   //debug tmp
        end
        else
        begin
            B.ALUSrc <= ALUsrc;
            B.MemtoReg <= MemtoReg;
            B.RegWrite <= RegWrite;
            B.MemRead <= MemRead;
            B.MemWrite <= MemWrite;
            B.ALUOp <= ALUOp;
            B.Branch <= Branch;
            B.JalrSel <= JalrSel;
            B.RWSel <= RWSel;
            B.Curr_Pc <= A.Curr_Pc;
            B.RD_One <= Reg1;
            B.RD_Two <= Reg2;
            B.RS_One <= A.Curr_Instr[19:15];
            B.RS_Two <= A.Curr_Instr[24:20];
            B.rd <= A.Curr_Instr[11:7];
            B.ImmG <= ExtImm;
            B.func3 <= A.Curr_Instr[14:12];
            B.func7 <= A.Curr_Instr[31:25];
             B.Curr_Instr <= A.Curr_Instr;   //debug tmp
        end
    end

    //--// The Forwarding Unit
    ForwardingUnit forunit(B.RS_One, B.RS_Two, C.rd, D.rd, C.RegWrite, D.RegWrite, FAmuxSel, FBmuxSel);

    // // //ALU
    assign Funct7 = B.func7;
    assign Funct3 = B.func3;
    assign ALUOp_Current = B.ALUOp;

    mux4 #(32) FAmux(B.RD_One, WRMuxResult, C.Alu_Result, B.RD_One, FAmuxSel, FAmux_Result);
    mux4 #(32) FBmux(B.RD_Two, WRMuxResult, C.Alu_Result, B.RD_Two, FBmuxSel, FBmux_Result);
    mux2 #(32) srcbmux(FBmux_Result, B.ImmG, B.ALUSrc, SrcB);
    alu alu_module(FAmux_Result, SrcB, ALU_CC, ALUResult);
    BranchUnit #(9) brunit(B.Curr_Pc,B.ImmG,B.JalrSel,B.Branch,ALUResult,BrImm,Old_PC_Four,BrPC,PcSel);

// EX_MEM_Reg C;
    always @(posedge clk) 
    begin
        if (reset)   // initialization
        begin
            C.RegWrite <= 0;
            C.MemtoReg <= 0;
            C.MemRead <= 0;
            C.MemWrite <= 0;
            C.RWSel <= 0;
            C.Pc_Imm <= 0;
            C.Pc_Four <= 0;
            C.Imm_Out <= 0;
            C.Alu_Result <= 0;
            C.RD_Two <= 0;
            C.rd <= 0;
            C.func3 <= 0;
            C.func7 <= 0;
        end
        else
        begin
            C.RegWrite <= B.RegWrite;
            C.MemtoReg <= B.MemtoReg;
            C.MemRead <= B.MemRead;
            C.MemWrite <= B.MemWrite;
            C.RWSel <= B.RWSel;
            C.Pc_Imm <= BrImm;
            C.Pc_Four <= Old_PC_Four;
            C.Imm_Out <= B.ImmG;
            C.Alu_Result <= ALUResult;
            C.RD_Two <= FBmux_Result;
            C.rd <= B.rd;
            C.func3 <= B.func3;
            C.func7 <= B.func7;
             C.Curr_Instr <= B.Curr_Instr;   // debug tmp
        end
    end

    // // // // Data memory 
	datamemory data_mem (clk, C.MemRead, C.MemWrite, C.Alu_Result[8:0], C.RD_Two, C.func3, ReadData);

    assign wr = C.MemWrite;
    assign reade = C.MemRead;
    assign addr = C.Alu_Result[8:0];
    assign wr_data = C.RD_Two;
    assign rd_data = ReadData;

// MEM_WB_Reg D;
    always @(posedge clk) 
    begin
        if (reset)   // initialization
        begin
            D.RegWrite <= 0;
            D.MemtoReg <= 0;
            D.RWSel <= 0;
            D.Pc_Imm <= 0;
            D.Pc_Four <= 0;
            D.Imm_Out <= 0;
            D.Alu_Result <= 0;
            D.MemReadData <= 0;
            D.rd <= 0;
        end
        else
        begin
            D.RegWrite <= C.RegWrite;
            D.MemtoReg <= C.MemtoReg;
            D.RWSel <= C.RWSel;
            D.Pc_Imm <=C.Pc_Imm;
            D.Pc_Four <= C.Pc_Four;
            D.Imm_Out <= C.Imm_Out;
            D.Alu_Result <= C.Alu_Result;
            D.MemReadData <= ReadData;
            D.rd <= C.rd;
             D.Curr_Instr <= C.Curr_Instr;   //Debug Tmp
        end
    end

//--// The LAST Block
    mux2 #(32) resmux(D.Alu_Result, D.MemReadData, D.MemtoReg, WrmuxSrc);  
    mux4 #(32) wrsmux(WrmuxSrc, D.Pc_Four, D.Imm_Out, D.Pc_Imm, D.RWSel, WRMuxResult);
    assign WB_Data = WRMuxResult;
    

endmodule