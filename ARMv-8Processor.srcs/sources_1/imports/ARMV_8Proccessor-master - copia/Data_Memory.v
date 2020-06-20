`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:10 05/05/2020 
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory(
    input i_clk,
    input [63:0] i_add,
    input [63:0] i_dataWr,
    input [7:0]  i_sw,
    input i_memRd, // Señal de control
    input i_memWr, // Señal de control
    output reg [63:0] o_dataRd,
    output reg [7:0] o_leds = 0
    );

    localparam MEM_SIZE = 100;
    localparam inicial = "data_mem.txt";

    reg  [7:0] r_insMem [MEM_SIZE-1:0];

    initial begin
		$readmemb  (inicial, r_insMem);
	end
    

    always @(posedge i_clk) begin
        if(i_memWr  && i_add[17:16] == 0)begin // Memoria
            r_insMem [i_add+7] <= i_dataWr[63:56];
            r_insMem [i_add+6] <= i_dataWr[55:48];
            r_insMem [i_add+5] <= i_dataWr[47:40];
            r_insMem [i_add+4] <= i_dataWr[39:32];
            r_insMem [i_add+3] <= i_dataWr[31:24];
            r_insMem [i_add+2] <= i_dataWr[23:16];
            r_insMem [i_add+1] <= i_dataWr[15:8];
            r_insMem [i_add]   <= i_dataWr[7:0];
        end
        else if(i_memWr  && i_add[17:16] == 1)begin // Leds
            o_leds <= i_dataWr[7:0];
        end
                
    end
             

    //  Area de Lectura
    always @(*) begin
        if (i_memRd && i_add[17:16] == 0) begin // Memoria
            o_dataRd <= {r_insMem[i_add+7],r_insMem[i_add+6],r_insMem[i_add+5],r_insMem[i_add+4],r_insMem[i_add+3],r_insMem[i_add+2],r_insMem[i_add+1],r_insMem[i_add]};
        end 
        else if(i_memRd && i_add[17:16] == 1)begin // Leds
            o_dataRd <= {{56{o_leds[7]}},o_leds};
        end
        else if(i_memRd && i_add[17:16] == 2)begin  // Switch
            o_dataRd <= {{56{i_sw[7]}},i_sw};
        end
    end

endmodule
