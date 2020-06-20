`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:50 05/22/2020 
// Design Name: 
// Module Name:    Adder_Pri 
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
module Adder_Pri(
    input [63:0] i_a,
    input signed [63:0] i_b,
    output [63:0] o_res
    );

    assign o_res = i_a + i_b;


endmodule
