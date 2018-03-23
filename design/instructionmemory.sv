`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:20:16 PM
// Design Name: 
// Module Name: instructionmemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.02 - Fix Result Bugs
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module instructionmemory#(
    parameter INS_ADDRESS = 9,
    parameter INS_W = 32
     )(
    input logic [ INS_ADDRESS -1:0] ra , // Read address of the instruction memory , comes from PC
    output logic [ INS_W -1:0] rd // Read Data
    );
    

logic [INS_W-1 :0] Inst_mem [(2**(INS_ADDRESS-2))-1:0];
    
assign Inst_mem[0]   = 32'h00007033;//      and  r0,r0,r0           ALUResult = h0 = r0          
assign Inst_mem[1]   = 32'h00100093;//      addi r1,r0, 1           ALUResult = h1 = r1
assign Inst_mem[2]   = 32'h00200113;//      addi r2,r0, 2           ALUResult = h2 = r2
assign Inst_mem[3]   = 32'h00308193;//      addi r3,r1, 3           ALUResult = h4 = r3
assign Inst_mem[4]   = 32'h00408213;//      addi r4,r1, 4           ALUResult = h5 = r4
assign Inst_mem[5]   = 32'h00510293;//      addi r5,r2, 5           ALUResult = h7 = r5
assign Inst_mem[6]   = 32'h00610313;//      addi r6,r2, 6           ALUResult = h8 = r6
assign Inst_mem[7]   = 32'h00718393;//      addi r7,r3, 7           ALUResult = hB = r7
assign Inst_mem[8]   = 32'h00208433;//      add  r8,r1,r2           ALUResult = h3 = r8
assign Inst_mem[9]   = 32'h404404b3;//      sub  r9,r8,r4           ALUResult = hfffffffe = -2 = r9
assign Inst_mem[10]  = 32'h00317533;//      and r10 = r2 & r3       ALUResult = h0 = r10
assign Inst_mem[11]  = 32'h0041e5b3;//      or  r11 = r3 | r4       ALUResult = h5 = r11       |x|270000ps 

//testing branches
assign Inst_mem[12]  = 32'h02b20263;//      beq r4,r11,36           ALUResult = 00000001       branch taken to inst_mem[21]  
assign Inst_mem[13]  = 32'h00108413;//      addi r8,r1,1            ALUResult = h2 = r8
assign Inst_mem[14]  = 32'h00419a63;//      bne r3,r4,20            ALUReuslt = ffffffff       branch taken to inst_mem[19] 
assign Inst_mem[15]  = 32'h00308413;//      addi  r8,r1,3           ALUReuslt = h4 = r8
assign Inst_mem[16]  = 32'h0014c263;//      blt r9,r1,4             ALUResult = 00000001       branch taken to inst_mem[17]   
assign Inst_mem[17]  = 32'h00408413;//      addi  r8,r1,4           ALUReuslt = h5 = r8
assign Inst_mem[18]  = 32'h00b3da63;//      bgt r7,r11,20           ALUResult = 00000001       branch taken to inst_mem[23]   
assign Inst_mem[19]  = 32'h00208413;//      addi  r8,r1,2           ALUResult = h3 = r8
assign Inst_mem[20]  = 32'hfe5166e3;//      btlu r2, r5, -24        ALUResult = 00000001       branch taken to inst_mem[15]   
assign Inst_mem[21]  = 32'h00008413;//      add  r8,r1,0            ALUResult = 1 = r8
assign Inst_mem[22]  = 32'hfc74fee3;//      bgeu  r9,r7,-36         ALUResult = 00000001       branch taken to inst_mem[13] 
assign Inst_mem[23]  = 32'h0083e6b3;//      or  r13 = r7 | r8       ALUResult = hf = r13

//jal
assign Inst_mem[24]  = 32'h018005ef;//      jal x11, 24(Decimal)    ALResult = h66       jump to inst[30] 
//return
assign Inst_mem[25]  = 32'h02a02823;//      sw  48(r0)<- r10        ALUResult = h30 
assign Inst_mem[26]  = 32'h16802023;//      sw  352(r0)<- r8        ALUResult =h160
assign Inst_mem[27]  = 32'h03002603;//      lw r12 <- 48(r0)        ALUResult = h30

assign Inst_mem[28]  = 32'h00311733;//     sll r14, r2, r3          ALUResult = h20 = r14
//branch
assign Inst_mem[29]  = 32'h00c50a63;//     beq x12, x10, 20         ALUResult = 00000000        branch taken to inst_mem[34] 

assign Inst_mem[30]  = 32'h0072c7b3;//     xor r15, r5, r7          ALUResult = hc = r15
assign Inst_mem[31]  = 32'h00235833;//     srl r16, r6, r2          ALUResult = h2 = r16
assign Inst_mem[32]  = 32'h4034d8b3;//     sra r17, r9, r3          ALUResult = hffffffff = r17

//JALR
assign Inst_mem[33]  = 32'h000586e7;//     jalr x13, 0(x11)           ALUResult = h88              branch taken to inst_mem[25] 

//branch target
assign Inst_mem[34]  = 32'h01614513;//     xori r10, r2, 16h          ALUResult = h14 =     r10
assign Inst_mem[35]  = 32'h02e2e593;//     ori  r11, r5, 2eh          ALUResult = h2f =     r11
assign Inst_mem[36]  = 32'h06f37613;//     andi r12, r6, 6fh          ALUResult = h8 =      r12
assign Inst_mem[37]  = 32'h00349693;//     slli r13, r9, 3h           ALUResult = hfffffff0 = r13
assign Inst_mem[38]  = 32'h00335713;//     srli r14, r6, 3h           ALUResult = h1 =        r14
assign Inst_mem[39]  = 32'h4026d793;//     srai r15, r13, 2h          ALUResult = hfffffffc = r15

assign Inst_mem[40]  = 32'h00a8a833;//     slt   r16, r17,r10          ALUResult = h1 = r16
assign Inst_mem[41]  = 32'h00a8b833;//     sltu  r16, r9,r10           ALUResult = h0 = r16
assign Inst_mem[42]  = 32'h0028a813;//     slti  r16, r9, 2            ALUResult = h1 = r16
assign Inst_mem[43]  = 32'h0028b813;//     sltiu  r16, r9, 2           ALUResult = h0 = r16

assign Inst_mem[44]  = 32'hccccc837;//     lui r16,hccccc             ALUResult = hccccc000
assign Inst_mem[45]  = 32'hccccc817;//     auipc r16, hccccc          ALUResult = hccccc0b6

assign Inst_mem[46]  = 32'h00902a23;//     sw 20(r0)<- r9             ALUResult = h14
assign Inst_mem[47]  = 32'h01402103;//     lw r2<-20(r0)              ALUResult = fffffffe = r2  
assign Inst_mem[48]  = 32'h01400183;//     lb r3<-20(r0)              ALUResult = fffffffe = r3
assign Inst_mem[49]  = 32'h01401203;//     lh r4<-20(r0)              ALUResult = fffffffe = r4
assign Inst_mem[50]  = 32'h01404283;//     lbu r5<-20(r0)             ALUResult = 000000fe = r5
assign Inst_mem[51]  = 32'h01405303;//     lhu r6<-20(r0)             ALUResult = 0000fffe = r6


assign Inst_mem[52]  = 32'h00459693;//     slli r13, r11, 4h          ALUResult = h2f0 = r13
assign Inst_mem[53]  = 32'h02d00423;//     sb r13->40(r0)             ALUResult = h28  
assign Inst_mem[54]  = 32'h02802703;//     lw 40(r0) -> r14           ALUResult = fffffff0 = r14

assign Inst_mem[55]  = 32'h02d01423; //    sh r13 ->40(r0)            ALUResult = h28  
assign Inst_mem[56]  = 32'h02802703;//     lw 40(r0) -> r13           ALUResult = 000002f0  = r13



assign rd =  Inst_mem [ra[INS_ADDRESS-1:2]];  

//      genvar i;
//      generate
//          for (i = 15; i < 127; i++) begin
//              assign Inst_mem[i] = 32'h00007033;
//          end
//      endgenerate

endmodule