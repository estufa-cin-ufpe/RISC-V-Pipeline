`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 03/20/2018 10:21:50 PM
// Design Name: 
// Module Name: Hazard Detection Unit
// Project Name: 112L_PipeLine
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.02 - 
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HazardDetection
    (input logic [4:0] IF_ID_RS1,
     input logic [4:0] IF_ID_RS2,
     input logic [4:0] ID_EX_rd,
     input logic ID_EX_MemRead,
     output logic stall
    );

    assign stall = (ID_EX_MemRead) ? ((ID_EX_rd == IF_ID_RS1) || (ID_EX_rd == IF_ID_RS2)) : 0;

endmodule
