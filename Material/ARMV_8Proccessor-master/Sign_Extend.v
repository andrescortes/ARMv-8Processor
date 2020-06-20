`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:44:24 05/07/2020 
// Design Name: 
// Module Name:    Sign_Extend 
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
module Sign_Extend(
    input signed [25:0] i_inm,
    input [1:0] i_SEU,
    output reg signed [63:0] o_ext
    );

    always @(*) begin
        case (i_SEU)
            0: begin // Tipo I
                o_ext <= {52'b0,i_inm[21:10]};
            end 
            1: begin // Tipo D
                o_ext <= {55'b0,i_inm[20:12]};
            end
            2: begin// Tipo B
                o_ext <= {{{38{i_inm[25]}},i_inm},2'b0};
            end
            3: begin// Tipo CB
                o_ext <= {{{43{i_inm[23]}},i_inm[23:5]},2'b0};
            end
            
        endcase
    end




endmodule
