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
module alu32bit(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);
	 //Inputs
    input [31:0] A, B; 
    input [3:0] ALUControl; // Ðau vao dieu khien ALU, co 4 bit
	 
	 //Outputs
    output Carry, OverFlow, Zero, Negative; // Cac dau ra: Carry (du), OverFlow (tran), Zero (bang khong), Negative (dau am)
    output [31:0] Result; 

    wire Cout; 
    wire [31:0] Sum; 
    wire [31:0] DivResult; 
    wire [31:0] Remainder; 

    // Thuc hien phep cong hoac tru dua tren bit ALUControl[0]
    assign {Cout, Sum} = (ALUControl[0] == 1'b0) ? A + B : (A + ((~B) + 1));
    
    // Thuc hien phep chia lay phan nguyen neu B khac 0, neu khong thi ket qua la 0
    assign DivResult = (B != 0) ? (A / B) : 32'b0; // Tranh chia cho so 0
    
    // Thuc hien phep chia lay du neu B khac 0, neu khong thi ket qua la 0
    assign Remainder = (B != 0) ? (A % B) : 32'b0; // Tranh chia cho so 0

    // Chon ket qua dua tren gia tri cua ALUControl
    assign Result = (ALUControl == 4'b0000) ? Sum : // Phep cong
                    (ALUControl == 4'b0001) ? Sum : // Phep tru theo dang bu 2
                    (ALUControl == 4'b0010) ? A & B : // Phep AND
                    (ALUControl == 4'b0011) ? A | B : // Phep OR
                    (ALUControl == 4'b0100) ? A * B : // Phep nhan
                    (ALUControl == 4'b0101) ? DivResult : // Phep chia lay phan nguyen
                    (ALUControl == 4'b0110) ? A >> 1 : // Dich phai 1 bit
                    (ALUControl == 4'b0111) ? A << 1 : // Dich trai 1 bit
                    (ALUControl == 4'b1000) ? ((A > B) ? 32'b0 : 32'b1) : // So sanh lon hon
                    (ALUControl == 4'b1001) ? {{31{1'b0}},(Sum[31])} : // Lay bit dau cua Sum
                    (ALUControl == 4'b1010) ? Remainder : // Lay phan du cua phep chia
                    {32{1'b0}}; // Mac dinh gia tri la 0

    // Tinh toan bit tran (overflow) cho phep cong và tru
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    
    // Tinh toan bit du (carry) cho phep cong và tru
    assign Carry = ((~ALUControl[1]) & Cout);
    
    // Kiem tra xem ket qua co bang 0 khong
    assign Zero = &(~Result);
    
    // Kiem tra bit dau cua ket qua
    assign Negative = Result[31];

endmodule


