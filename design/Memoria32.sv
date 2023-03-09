/*-----------------------------------------------------------------------------
-- Title		: Memória da CPU
-- Project		: CPU 
--------------------------------------------------------------------------------
-- File			: memoria64.sv
-- Author		: Lucas Fernando da Silva Cambuim <lfsc@cin.ufpe.br>
-- Organization : Universidade Federal de Pernambuco
-- Created		: 20/09/2018
-- Last update	: 20/09/2018
-- Plataform	: DE2
-- Simulators	: ModelSim
-- Synthesizers	: 
-- Targets		: 
-- Dependency	: 
--------------------------------------------------------------------------------
-- Description	: Entidade responsável pela leitura e escrita em memória (dados de 64 bits).
--------------------------------------------------------------------------------
-- Copyright (c) notice
--		Universidade Federal de Pernambuco (UFPE).
--		CIn - Centro de Informatica.
--		Developed by computer science researchers.
--		This code may be used for educational and non-educational purposes as 
--		long as its copyright notice remains unchanged. 
------------------------------------------------------------------------------*/

module Memoria32 
    (input  wire  [31:0]raddress,
     input  wire  [31:0]waddress,
     input  wire  Clk,         
     input  wire  [31:0]Datain,
     output wire  [31:0]Dataout,
     input  wire  Wr
    );
    
    wire [15:0]readUsefullAddress = raddress[15:0]; 
    
    wire [15:0]addS0 = readUsefullAddress + 0;
    wire [15:0]addS1 = readUsefullAddress + 1;
    wire [15:0]addS2 = readUsefullAddress + 2;
    wire [15:0]addS3 = readUsefullAddress + 3;
    
    
    wire [15:0]writeUsefullAddress = waddress[15:0]; 
    
    wire [15:0]waddS0 = writeUsefullAddress + 0;
    wire [15:0]waddS1 = writeUsefullAddress + 1;
    wire [15:0]waddS2 = writeUsefullAddress + 2;
    wire [15:0]waddS3 = writeUsefullAddress + 3;
        
    wire [7:0]inS0; 
    wire [7:0]inS1;
    wire [7:0]inS2;
    wire [7:0]inS3;
        
    wire [7:0]outS0; 
    wire [7:0]outS1;
    wire [7:0]outS2;
    wire [7:0]outS3;
         	    
    assign Dataout[31:24] = outS3;
    assign Dataout[23:16] = outS2;
    assign Dataout[15:8] = outS1;
    assign Dataout[7:0] = outS0;
    
    assign inS3 = Datain[31:24];
    assign inS2 = Datain[23:16];
    assign inS1 = Datain[15:8];
    assign inS0 = Datain[7:0]; 
    
    //Bancos de memórias (cada banco possui 65536 bytes)
    //0
    ramOnChip32 #(.ramSize(65536), .ramWide(8) ) memBlock0 (.clk(Clk), .data(inS0), .radd(addS0), .wadd(waddS0), .wren(Wr), .q(outS0) );
    //1
    ramOnChip32 #(.ramSize(65536), .ramWide(8) ) memBlock1 (.clk(Clk), .data(inS1), .radd(addS1), .wadd(waddS1), .wren(Wr), .q(outS1) ); 
    //2
    ramOnChip32 #(.ramSize(65536), .ramWide(8) ) memBlock2 (.clk(Clk), .data(inS2), .radd(addS2), .wadd(waddS2), .wren(Wr), .q(outS2) ); 
    //3
    ramOnChip32 #(.ramSize(65536), .ramWide(8) ) memBlock3 (.clk(Clk), .data(inS3), .radd(addS3), .wadd(waddS3), .wren(Wr), .q(outS3) );
        
endmodule
    
    
    
