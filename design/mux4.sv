`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yifan Xu
// 
// Create Date: 02/25/2018 10:21:50 PM
// Design Name: 
// Module Name: mux4
// Project Name: 112L_Single_Path
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4
    #(parameter WIDTH = 32)
    (input logic [WIDTH-1:0] d00, d01, d10, d11,
     input logic [1:0] s,
     output logic [WIDTH-1:0] y);

assign y = (s==2'b11) ? d11 : (s==2'b10) ? d10 : (s==2'b01) ? d01 : d00;

endmodule
