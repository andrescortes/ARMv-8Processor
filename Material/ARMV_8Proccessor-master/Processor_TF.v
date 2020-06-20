`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:37:44 05/08/2020
// Design Name:   Processor
// Module Name:   C:/Users/acer/Documents/Arquitectura/Procesador_ARMV8/Processor_TF.v
// Project Name:  Procesador_ARMV8
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Processor_TF;

	// Inputs
	reg t_clk;
	reg [7:0] SWITCHES;

	// Outputs
	wire [7:0] LEDS;


	// Instantiate the Unit Under Test (UUT)
	Processor uut (
		.t_clk(t_clk),
		.t_sw(SWITCHES), 
		.o_leds(LEDS)
	);

	initial begin
		// Initialize Inputs
		t_clk = 0;
		SWITCHES = 8'b00100101;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end

	always #10 t_clk=~t_clk;
      
endmodule

