
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module instructionmemory#(
    parameter INS_ADDRESS = 9,
    parameter INS_W = 32
     )(
    input logic clk , // Clock
    input logic [ INS_ADDRESS -1:0] ra , // Read address of the instruction memory , comes from PC
    output logic [ INS_W -1:0] rd // Read Data
    );

    logic [INS_W-1 :0] get_dataOut; // Data output from the memory

    Memoria32 meminst 
    (.raddress(32'(ra)),
     .Clk(clk),         
     .Dataout(get_dataOut),
     .Wr(1'b1)
    );
    
    // rd is given the register number where the data will be written. This number is provided in bits 11 to 7 of get_dataOut
    assign rd = get_dataOut[11:7]; //get_dataOut[ra[INS_ADDRESS-1:2]];

// assign Inst_mem[0 ]=32'b00000000000000000000000000010011;//	addi	$0,$0,0 			#r0 =0		(r0=0)
// assign Inst_mem[1 ]=32'b00000000100000000000000010010011;//	addi	$1,$0,8 			#r1 =r0+8	(r1=8)
// assign Inst_mem[2 ]=32'b00000000010000000000000100010011;//	addi	$2,$0,4 			#r2 =r0+4	(r2=4)
// assign Inst_mem[3 ]=32'b00000000001000001110000110110011;//	or		$3,$1,$2			#r3 =r1|r2	(r3=12) // Forwarding Test
// assign Inst_mem[4 ]=32'b00000000000000010110001000110011;//	or		$4,$2,$0			#r4 =r2|r0	(r4=4)  // Forwarding Test
// assign Inst_mem[5 ]=32'b00000000001000100000001100110011;//	add		$6,$4,$0			#r6 =r4+r2	(r6=8)  // Hazard test

// assign Inst_mem[6 ]=32'b00000000001000000000001000010011;// addi	$4,$0,2 			#r4 =r0+2		(r4=2)
// assign Inst_mem[7 ]=32'b11111111111000000000001010010011;// addi	$5,$0,-2 			#r5 =r0-2		(r5=-2)

// assign Inst_mem[8 ]=32'b00000000010000001001100100110011;// sll 	$18,$1,$4 			#R18=R1<<R4 	(R18 = 8<<2)	R18=0000020
// assign Inst_mem[9 ]=32'b00000000010000101101100110110011;// srl		$19,$5,$4			#R19=R5>>R4		(R19 = -2>>2) 	R19=3FFFFFF // Forwarding Test
// assign Inst_mem[10 ]=32'b01000000010000101101101000110011;// sra		$20,$5,$4			#R20=R5>>>R4	(R20 = -2>>2)	R20=FFFFFFF

// assign Inst_mem[11]=32'b00000000001000001010101010110011;// slt		$21,$1,$2			#if R1<R2, R21=1	(R21=0)
// assign Inst_mem[12]=32'b00000000000100010010101100110011;// slt		$22,$2,$1			#if R2<R1, R22=1	(R22=1)
// assign Inst_mem[13]=32'b00000000000100101011101110110011;// sltu    $23,$5,$1			#if R5<R1, R23=1	(R23=0)
// assign Inst_mem[14]=32'b00000000010100001011110000110011;// sltu    $24,$1,$5			#if R1<R5, R24=1	(R24=1)
// assign Inst_mem[15]=32'b00000000100000001010110010010011;// slti	$25,$1,8			#if R1<8,  R25=1	(R25=0)
// assign Inst_mem[16]=32'b00000001000000001010110100010011;// slti	$26,$1,16			#if R1<16, R26=1	(R26=1)

// assign Inst_mem[17]=32'b11111111110000000000001010010011;// addi	$5,$0,-4 			#r5 =r0-4		(r5=-4)

// assign Inst_mem[18]=32'b11111111111000001011110110010011;// sltiu	$27,$1,-2			#if R1<u(-2),  R27=1	(R27=1)
// assign Inst_mem[19]=32'b11111111111000101011111000010011;// sltiu	$28,$5,-2			#if R5<u(-2),  R28=1	(R28=1)

// assign Inst_mem[20]=32'b00000000000100101001111010010011;// slli	$29,$5,1			#R29=R5<<1 	(R29=FFFFFFF8)
// assign Inst_mem[21]=32'b00000000000100101101111100010011;// srli	$30,$5,1			#R30=R5>>1 	(R30=7FFFFFFE)
// assign Inst_mem[22]=32'b01000000000100101101111110010011;// srai	$31,$5,1			#R31=R5>>1	(R31=FFFFFFFE)	

// assign Inst_mem[23]=32'b00000000101000001100001100010011;// xori	$6,$1,10			#R6=R1 xor A	(R6=00000002)
// assign Inst_mem[24]=32'b00000000001000001110001110010011;// ori		$7,$1,2				#R7=R1 or 2		(R7=0000000A)
// assign Inst_mem[25]=32'b00000000101000001111010000010011;// andi	$8,$1,10			#R8=R1 and A	(R8=00000008)
// assign Inst_mem[26]=32'b00000000001000001100010010110011;// xor		$9,$1,$2			#R9=R1 or R2	(R9=0000000C)

// assign rd =  Inst_mem [ra[INS_ADDRESS-1:2]];  

//      genvar i;
//      generate
//          for (i = 15; i < 127; i++) begin
//              assign Inst_mem[i] = 32'h00007033;
//          end
//      endgenerate

endmodule