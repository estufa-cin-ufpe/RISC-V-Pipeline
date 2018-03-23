package  Pipe_Buf_Reg_PKG;
    // Reg A
    typedef struct packed{
        logic [8:0]     Curr_Pc;
        logic [31:0]    Curr_Instr;
    } if_id_reg;
    
    // Reg B
    typedef struct packed{
        logic ALUSrc;
        logic MemtoReg;
        logic RegWrite;
        logic MemRead;
        logic MemWrite;
        logic [1:0]     ALUOp;
        logic Branch;
        logic JalrSel;
        logic [1:0]     RWSel;
        logic [8:0]     Curr_Pc;
        logic [31:0]    RD_One;
        logic [31:0]    RD_Two;
        logic [4:0]     RS_One;
        logic [4:0]     RS_Two;
        logic [4:0]     rd;
        logic [31:0]    ImmG;
        logic [2:0]     func3;
        logic [6:0]     func7;
        logic [31:0]    Curr_Instr;
    } id_ex_reg;

    // Reg C
    typedef struct packed{
        logic RegWrite;
        logic MemtoReg;
        logic MemRead;
        logic MemWrite;
        logic [1:0]     RWSel;
        logic [31:0]    Pc_Imm;
        logic [31:0]    Pc_Four;
        logic [31:0]    Imm_Out;
        logic [31:0]    Alu_Result;
        logic [31:0]    RD_Two;
        logic [4:0]     rd;
        logic [2:0]     func3;
        logic [6:0]     func7;
        logic [31:0]    Curr_Instr;
    } ex_mem_reg;
    
    // Reg D
    typedef struct packed{
        logic RegWrite;
        logic MemtoReg;
        logic [1:0]     RWSel;
        logic [31:0]    Pc_Imm;
        logic [31:0]    Pc_Four;
        logic [31:0]    Imm_Out;
        logic [31:0]    Alu_Result;
        logic [31:0]    MemReadData;
        logic [4:0]     rd;
        logic [31:0]    Curr_Instr;
    } mem_wb_reg;
endpackage