`timescale 10ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:57 05/07/2020 
// Design Name: 
// Module Name:    Processor 
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

module Processor(
    input t_clk, //Top clk,
    input [7:0] t_sw,
    output [7:0] o_leds
    );

    // PC 
        // wires
            // Entradas
                wire [63:0] w_PCSrc_PC; // Direccion PC (i_counter)
            // Salidas
                wire [63:0] w_PC_IM; // Direccion PC (o_ins)
        
            
    // Sumador Base
        wire [63:0] w_res_sumBase; // Respuesta sumador + 4

    // Sumador Primario
        wire [63:0] w_res_sumPri; // Respuesta sumador principal    

    // Instruction Memory wires
        // Entradas
            // wire [63:0] w_PC_IM; // Direccion IM (i_add)
        // Salidas
            wire [31:0] w_IM_ins; // Instruccion IM (o_ins)

    // Control Unit 
        // Wires 
            // Entradas
                wire [10:0] w_IM_CU; // Opcode CU (i_opCode)
                // wire        w_ALU_CU; // Flag ZERO (i_Z)
            // Salidas
                wire        w_reg2Sel_MUX_RF; // Selector MUX RF (o_reg2Sel)
                wire        w_regWrSrc_MUX_RF;
                wire        w_rfWr_RF; // Escritura RF (o_rfWr)
                wire [1:0]  w_SEU_SEU; // Extension de signo SEU (o_SEU)
                wire        w_ALUSrcB_MUX_ALU; // Selector MUX ALU (o_ALUSrcB)
                wire [3:0]  w_ALUOp_ALU; // Operacion ALU (o_ALUOp)
                wire        w_memWr; // Habilitador escritura DM (o_memWr)
                wire        w_memRd; // Habilitador lectura DM (o_memRd)
                wire [1:0]  w_PCSrc; // Selector MUX Sumadores (o_PCSrc)
                wire [1:0]  w_wrDataSel;// Selector MUX WrDataSel (o_wrDataSel)
        

    // Register File
        // Wires
            // Entradas
                wire [4:0]  w_IM_RF_rdReg1; // Operando Rn (i_rdReg1)
                wire [4:0]  w_IM_RF_rdReg2; // MUX RF Operando Rm|Rt (i_rdReg2)
                wire [63:0] w_MUX_wrDataSel_RF_wrData; // Dato de escritura (i_wrData)
                wire [4:0] w_MUX_regWrSrc;
            // Salidas
                wire [63:0] w_RF_ALU_reg0; // Dato de salida a ALU (o_reg0)
                wire [63:0] w_RF_reg1; // Dato de salida a DM|MUX ALU (o_reg1)
       

    // Sign Extension
        // Wires
            // Entradas
                wire signed [25:0] w_IM_SEU_inm; // Inmediato  sin procesar (i_inm)
            // Salidas 
                wire [63:0] w_SEU_ext; // Inmediato de 64'b MUX ALU| SUM DirBase (o_ext)
        

    // ALU
        // Wires
            // Entradas
                wire [63:0] w_MUX_ALU_ALU_b; // MUX ALU Operando b reg1|inm (i_b)
                // wire [5:0] w_IM_ALU_shamt; // Corrimiento (i_shamt)
            // Salidas
                wire [63:0] w_ALU_ALURes; // Resultado ALU Direccion_DM|MUX_WrDataSel (o_ALURes)
                wire        w_ALU_Z;   // Flag 0 a CU (o_Z)
                wire        w_ALU_N;   // Flag 0 a CU (o_Z)
        

    // Data Memory
        // Wires
            // Entradas
            // Salidas
                wire [63:0] w_DM_MUX_wrDataSel_dataRd; // Dato lectura DM a MUX_WrDataSel (o_dataRd)


    // Program Counter
        // Conexiones
            assign w_PCSrc_PC = (w_PCSrc == 0)?w_res_sumBase:(w_PCSrc == 1? w_res_sumPri:w_RF_reg1); // MUX Sumador

    // Control Unit
        // Conexiones
            assign w_IM_CU = w_IM_ins[31:21];

    // Register File
        // Conexiones
            assign w_IM_RF_rdReg1 = w_IM_ins[9:5];
            assign w_IM_RF_rdReg2 = !(w_reg2Sel_MUX_RF)?w_IM_ins[20:16]:w_IM_ins[4:0];// MUX RF
            assign w_MUX_wrDataSel_RF_wrData = (w_wrDataSel == 0)?w_DM_MUX_wrDataSel_dataRd:(w_wrDataSel == 1? w_ALU_ALURes:w_res_sumBase); // MUX WrData de RF
            assign w_MUX_regWrSrc = !(w_regWrSrc_MUX_RF)?w_IM_ins[4:0]:30;

	// Sign Extend
        // Conexiones
            assign w_IM_SEU_inm = w_IM_ins[25:0];  

    // ALU
        // Conexiones
            assign w_MUX_ALU_ALU_b = !(w_ALUSrcB_MUX_ALU)?w_RF_reg1:w_SEU_ext; // MUX ALU

    Adder_Base adder_base(
        .i_a(w_PC_IM),
        .o_res(w_res_sumBase)
    );

    Adder_Pri adder_pri(
        .i_a(w_PC_IM),
        .i_b(w_SEU_ext),
        .o_res(w_res_sumPri)
    );

    Program_Counter program_counter_0(
        .i_clk(t_clk),
        .i_counter(w_PCSrc_PC),
        .o_adress(w_PC_IM)
    );

    Instruction_Memory intruction_memory_0(
        .i_add(w_PC_IM),
        .o_ins(w_IM_ins)
    );

    Control_Unit control_unit_0(
        .i_clk(t_clk),
        .i_opCode(w_IM_CU),
        .i_bCond(w_IM_ins[3:0]),
        .i_Z(w_ALU_Z),
        .i_N(w_ALU_N),
        .o_reg2Sel(w_reg2Sel_MUX_RF),
        .o_regWrSrc(w_regWrSrc_MUX_RF),
        .o_rfWr(w_rfWr_RF),
        .o_SEU(w_SEU_SEU),
        .o_ALUSrcB(w_ALUSrcB_MUX_ALU),
        .o_ALUOp(w_ALUOp_ALU),
        .o_memWr(w_memWr),
        .o_memRd(w_memRd),
        .o_PCSrc(w_PCSrc),
        .o_wrDataSel(w_wrDataSel)
    );

    Register_File register_file_0(
        .i_clk(t_clk),
        .i_rdReg1(w_IM_RF_rdReg1),
        .i_rdReg2(w_IM_RF_rdReg2),
        .o_reg0(w_RF_ALU_reg0),
        .o_reg1(w_RF_reg1),
        .i_wrReg(w_MUX_regWrSrc),
        .i_dataWr(w_MUX_wrDataSel_RF_wrData),
        .i_regWr(w_rfWr_RF)
    );

    Sign_Extend sign_extend_0(
        .i_inm(w_IM_SEU_inm),
        .i_SEU(w_SEU_SEU),
        .o_ext(w_SEU_ext)
    );

    ALU alu_0(
        .i_a(w_RF_ALU_reg0),
        .i_b(w_MUX_ALU_ALU_b),
        .i_ALUOp(w_ALUOp_ALU),
        .i_shamt(w_IM_ins[15:10]),
        .o_ALURes(w_ALU_ALURes),
        .o_Z(w_ALU_Z),
        .o_N(w_ALU_N)
    );

    Data_Memory data_memory_0(
        .i_clk(t_clk),
        .i_add(w_ALU_ALURes),
        .i_dataWr(w_RF_reg1),
        .i_sw(t_sw),
        .i_memRd(w_memRd),
        .i_memWr(w_memWr),
        .o_dataRd(w_DM_MUX_wrDataSel_dataRd),
        .o_leds(o_leds)
    );





endmodule
