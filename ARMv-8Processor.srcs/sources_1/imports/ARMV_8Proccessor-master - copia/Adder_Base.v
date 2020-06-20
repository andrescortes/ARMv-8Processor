`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:36 05/22/2020 
// Design Name: 
// Module Name:    Adder_Base 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Adder_Base(
    input [63:0] i_a,
    output reg [63:0] o_res = 0
    );
    always@(*)begin
        o_res <= i_a + 4;
    end
		


endmodule
