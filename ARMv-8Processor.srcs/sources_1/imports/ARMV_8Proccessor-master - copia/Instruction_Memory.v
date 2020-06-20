`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:33 05/05/2020 
// Design Name: 
// Module Name:    Instruction_Memory 
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
module Instruction_Memory(
    input [63:0] i_add,
    output [31:0] o_ins
    );
    localparam MEM_SIZE = 156;
    localparam inicial = "ins_mem.txt";

    reg  [7:0] r_insMem [MEM_SIZE-1:0];

    initial begin
		$readmemb  (inicial, r_insMem);
	end

    assign o_ins = (i_add<MEM_SIZE)?({r_insMem[i_add],r_insMem[i_add+1],r_insMem[i_add+2],r_insMem[i_add+3]}):0;

endmodule
