`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:19:34 PM
// Design Name: 
// Module Name: flopr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.04 - fix logic
// Revision: 0.03 - add flush
// Revision: 0.02 - add stall
// Revision: 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopr#
    (parameter WIDTH = 8)
    (input logic clk, reset,
     input logic [WIDTH-1:0] d,
     input logic stall,
     output logic [WIDTH-1:0] q);

    always_ff @(posedge clk, posedge reset)
    begin
        if (reset) q <= 0;
        else if (!stall) q<=d;
    end
        
    
endmodule
