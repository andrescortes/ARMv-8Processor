`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:59 05/05/2020 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File(
    input i_clk,
    // Entradas de lectura
    input [4:0] i_rdReg1,
    input [4:0] i_rdReg2,
    // Salidas de lectura
    output [63:0] o_reg0,
    output [63:0] o_reg1,
    // Entradas de escritura
    input [4:0] i_wrReg,// Indice de registro
    input [63:0] i_dataWr,// Dato de escritura
    input i_regWr// Habilitador de escritura (SEÑAL DE CONTROL)
    );
    localparam inicial = "ins_regs.txt";

    // 32 registros
    reg [63:0] r_regs [31:0];

    initial begin
        $readmemh(inicial,r_regs);
    end

    // Area de escritura
    always @ (posedge i_clk)
        if (i_regWr && (i_wrReg != 31))
            r_regs[i_wrReg] <= i_dataWr;
    // Area de lectura
    assign o_reg0 = r_regs[i_rdReg1];
    assign o_reg1 = r_regs[i_rdReg2];
    
endmodule
