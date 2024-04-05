`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:12:14 04/05/2024
// Design Name:   alu32bit
// Module Name:   E:/BT_Verilog/ALU32bit/alu32bit_tb.v
// Project Name:  ALU32bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu32bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu32bit_tb;

	// Inputs
	reg [3:0] opcode;
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] result;
	wire flagC;
	wire flagZ;

	// Instantiate the Unit Under Test (UUT)
	alu32bit uut (
		.opcode(opcode), 
		.a(a), 
		.b(b), 
		.result(result), 
		.flagC(flagC), 
		.flagZ(flagZ)
	);

	initial begin
		// Initialize Inputs
		 a = 100;
		 b = 50;
		 #10;opcode = 4'b0000; // Add
		 #10;opcode = 4'b0001; // Sub
		 #10;opcode = 4'b0010; // MUL
		 #10;opcode = 4'b0011; // AND
		 #10;opcode = 4'b0100; // OR
		 #10;opcode = 4'b0101; // NAND
		 #10;opcode = 4'b0110; // NOR
		 #10;opcode = 4'b0111; // XOR	
		 #10;opcode = 4'b1000; // IN
		 #10;opcode = 4'b1001; // RE
		 #10;opcode = 4'b1010; // NOT
		 #10;opcode = 4'b1011; // SL
		 #10;opcode = 4'b1100; // SR
		 #10;opcode = 4'b1101; // Add
		 #10;opcode = 4'b1110; // Add
		 #10;opcode = 4'b1111; // Add
		 #10;

		 $finish;
	end
      
endmodule

