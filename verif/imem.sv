module imem(
    input logic [31:0] a,
    output logic [31:0] rd);


    logic [31:0] RAM[63:0];

    assign RAM[0] = 32'hE04F000F;
    assign RAM[1] = 32'hE2802005;
    assign RAM[2] = 32'hE280300C;
    assign RAM[3] = 32'hE2437009;
    assign RAM[4] = 32'hE1874002;
    assign RAM[5] = 32'hE0035004;
    assign RAM[6] = 32'hE0855004;
    assign RAM[7] = 32'hE0558007;
    assign RAM[8] = 32'h0A00000C;
    assign RAM[9] = 32'hE0538004;
    assign RAM[10] = 32'hAA000000;
    assign RAM[11] = 32'hE2805000;
    assign RAM[12] = 32'hE0578002;
    assign RAM[13] = 32'hB2857001;
    assign RAM[14] = 32'hE0477002;
    assign RAM[15] = 32'hE5837054;
    assign RAM[16] = 32'hE5902060;
    assign RAM[17] = 32'hE08FF000;
    assign RAM[18] = 32'hE280200E;
    assign RAM[19] = 32'hEA000001;
    assign RAM[20] = 32'hE280200D;
    assign RAM[21] = 32'hE280200A;
    assign RAM[22] = 32'hE5802064;
    
    assign rd = RAM[a[31:2]]; // word aligned

endmodule
