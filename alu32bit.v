`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:22 04/04/2024 
// Design Name: 
// Module Name:    alu32bit 
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
module alu32bit(opcode, a, b, result, flagC, flagZ);

//inputs declaration
input [3:0] opcode;
input[31:0] a,b;

//output declaration
output reg [31:0] result = 33'b0;
output reg flagC = 1'b0;
output reg flagZ = 1'b0;
	parameter [3:0] 		 //Phep toan so hoc
					 ADD  = 4'b0000,        //CONG
					 SUB  = 4'b0001,	//TRU
					 MUL  = 4'b0010,	//MUL
					 DIV  = 4'b0011,        //DIV
					 //Phep toan logic
					 AND  = 4'b0100,	//AND
					 OR   = 4'b0101,	//OR
					 NAND = 4'b0110,	//NAND
					 NOR  = 4'b0111,	//NOR
					 XOR  = 4'b1000,	//XOR
					 IN   = 4'b1001,	//Tang A len 1
				         RE   = 4'b1010,	//Giam A di 1
					 NOT  = 4'b1011,	//NOT	
					 // Phep dich			 
					 SL   = 4'b1100, 	// Dich trai
					 SR   = 4'b1101, 	//Dich phai
					 //Phep toan so sanh
					 CW   = 4'b1110, 	// So sanh bang
					 CD   = 4'b1111; 	//So sanh HON
																				
always @(opcode or a or b)
begin
	case(opcode)
		//adder
		ADD: begin
			result = a+b;
			flagC  = result[32];
			flagZ  = (result == 32'b0);
		end
		
		//subtractor
		SUB: begin
			result = a-b;
			flagC  = result[32];
			flagZ  = (result == 32'b0);
		end
		
		//Mach da hop
		MUL: begin
			result = a*b;
			flagZ  = (result == 32'b0);
		end
		//division
		DIV: begin
			result = a/b;
			flagZ  = (result == 32'b0);
		end
		//AND
		AND: begin
			result = a&b;
			flagZ  = (result == 32'b0);
		end
		
		//OR
		OR: begin
			result = a|b;
			flagZ  = (result == 32'b0);
		end
		
		//NAND
		NAND: begin
			result = ~(a&b);
			flagZ  = (result == 32'b0);
		end
		
		//NOR
		NOR: begin
			result = ~(a|b);
			flagZ  = (result == 32'b0);
		end
		
		//XOR
		XOR: begin
			result = a^b;
			flagZ  = (result == 32'b0);
		end
		
		//Tang A len 1
		IN: begin
			result = a+1;
			flagZ  = (result == 32'b0);
		end
		
		//Giam A xuong 1
		RE: begin
			result = a-1;
			flagZ  = (result == 32'b0);
		end
		
		// NOT
		NOT: begin
			result = ~a;
			flagZ  = (result == 32'b0);
		end
		
		//Dich trai
		SL: begin
			result = a<<1;
			flagZ  = (result == 32'b0);
		end
		
		//Dich phai
		SR: begin
			result = a>>1;
			flagZ  = (result == 32'b0);
		end
		
		//So sang bang
		CW: begin
			result = (a == b) ? 1 : 0;
			flagZ  = (result == 32'b0);
		end
		
		//So sanh khac
		CD: begin
			result = (a > b) ? 1 : 0;
			flagZ  = (result == 32'b0);
		end
		default : begin
			result = 32'b0;
			flagC  = 1'b0;
			flagZ  = 1'b0;
		end
	endcase
end
endmodule


