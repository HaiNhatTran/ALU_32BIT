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

    reg [31:0] A, B;
    reg [3:0] ALUControl;
    wire Carry, OverFlow, Zero, Negative;
    wire [31:0] Result;

    // Instantiate the ALU
    alu32bit uut (
        .A(A),
        .B(B),
        .Result(Result),
        .ALUControl(ALUControl),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative)
    );

    initial begin
        // Initialize inputs
        A = 32'd0; B = 32'd0; ALUControl = 4'b0000;

        // Monitor changes
        $monitor("Time=%d : A=%d, B=%d, ALUControl=%b, Result=%d, Carry=%b, OverFlow=%b, Zero=%b, Negative=%b", $time, A, B, ALUControl, Result, Carry, OverFlow, Zero, Negative);

        // Test addition
        #10 A = 32'd15; B = 32'd10; ALUControl = 4'b0000; // Expect Result=25
        // Test overflow in addition
        #10 A = 32'h7FFFFFFF; B = 32'd1; ALUControl = 4'b0000; // Expect OverFlow=1
        // Test subtraction
        #10 A = 32'd15; B = 32'd10; ALUControl = 4'b0001; // Expect Result=5
        // Test overflow in subtraction
        #10 A = 32'h80000000; B = 32'd1; ALUControl = 4'b0001; // Expect OverFlow=1
        // Test AND
        #10 A = 32'd15; B = 32'd10; ALUControl = 4'b0010; // Expect Result=10
        // Test OR
        #10 A = 32'd15; B = 32'd10; ALUControl = 4'b0011; // Expect Result=15
        // Test multiplication
        #10 A = 32'd5;  B = 32'd3;  ALUControl = 4'b0100; // Expect Result=15
        // Test division
        #10 A = 32'd10; B = 32'd3;  ALUControl = 4'b0101; // Expect Result=3
        // Test remainder of division
        #10 A = 32'd10; B = 32'd3;  ALUControl = 4'b1010; // Expect Result=1
        // Test right shift by 1
        #10 A = 32'd16; ALUControl = 4'b0110; // Expect Result=8
        // Test left shift by 1
        #10 A = 32'd16; ALUControl = 4'b0111; // Expect Result=32
        // Test greater than
        #10 A = 32'd10; B = 32'd15; ALUControl = 4'b1000; // Expect Result=1
        #10 A = 32'd15; B = 32'd10; ALUControl = 4'b1000; // Expect Result=0
        // Test sign bit of sum
        #10 A = 32'd15; B = 32'd10; ALUControl = 4'b1001; // Expect Result=0

        // Test zero flag
        #10 A = 32'd0; B = 32'd0; ALUControl = 4'b0000; // Expect Zero=1
        #10 A = 32'd10; B = 32'd10; ALUControl = 4'b0001; // Expect Zero=1 (10 - 10 = 0)
        // Test negative flag
        #10 A = 32'hFFFFFFFF; B = 32'd0; ALUControl = 4'b0000; // Expect Negative=1
        #10 A = 32'd10; B = 32'd15; ALUControl = 4'b0001; // Expect Negative=1 (10 - 15 = -5)

        // Test carry flag
        #10 A = 32'hFFFFFFFF; B = 32'd1; ALUControl = 4'b0000; // Expect Carry=1
        #10 A = 32'hFFFFFFFF; B = 32'd0; ALUControl = 4'b0001; // Expect Carry=1

        // Finish simulation
        #10 $finish;
    end
endmodule

