`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:36 05/05/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input signed [63:0] i_a,
    input signed [63:0] i_b,
    input        [3:0]  i_ALUOp, //(SEÑAL CONTROL)
    input        [5:0]  i_shamt,
    output reg signed  [63:0] o_ALURes = 0,
    output reg          o_Z = 0,
    output reg          o_N = 0
    );

    always @(*)begin
        case (i_ALUOp)
            0: begin   
                o_ALURes <= i_a + i_b;
                o_Z <= (o_ALURes == 0)?1:0;
                o_N <= (o_ALURes < 0)?1:0;
            end
            1: begin   
                o_ALURes <= i_a - i_b;
                o_Z <= (o_ALURes == 0)?1:0;
                o_N <= (o_ALURes < 0)?1:0;
            end
            2: begin 
                o_ALURes <= i_a & i_b;
                o_Z <= (o_ALURes == 0)?1:0;
                o_N <= (o_ALURes < 0)?1:0;
            end
            3: begin 
                o_ALURes <= i_a | i_b;
                o_Z <= (o_ALURes == 0)?1:0;
                o_N <= (o_ALURes < 0)?1:0;
            end
            4: begin 
                o_ALURes <= ~(i_a | i_b);
                o_Z <= (o_ALURes == 0)?1:0;
                o_N <= (o_ALURes < 0)?1:0;
            end
            5: begin 
                o_ALURes <= i_a ^ i_b;
                o_Z <= (o_ALURes == 0)?1:0;
                o_N <= (o_ALURes < 0)?1:0;
            end
            6: begin    
                o_ALURes <= i_a << i_shamt;
                o_Z <= 0;
                o_N <= 0;
            end 
            7: begin    
                o_ALURes <= i_a >> i_shamt;
                o_Z <= 0;
                o_N <= 0;
            end 
            8: begin    
                o_ALURes <= i_b;
                if(i_b == 0)begin
                    o_Z <= 1;
                end
                else begin
                    o_Z <= 0;
                end
            end 
            default: begin
                o_ALURes <= 0;
                o_Z   <= 0;
                o_N   <= 0;
            end
                
				
        endcase
    end


endmodule
