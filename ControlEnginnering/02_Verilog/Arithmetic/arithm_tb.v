`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2018 01:25:12
// Design Name: 
// Module Name: sim33
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module tb_summator(
      
    );
    reg[7:0] A;
    reg[7:0] B;
    reg[7:0] C;
    reg clk = 0;
    wire[16:0] Y;
    wire[8:0] sum_res;
   
    
    summator summ(
        .clk(clk),
        .ce(1),
        .A(A),
        .B(B),
        .C(C),
        .Y(Y),
        .sum_res(sum_res)
    );
    
//    c_addsub_0 add ( // latency 1
//            .A(A),
//            .B(B),
//            .S(sum),
//            .CE(1),
//            .CLK(clk)
//     );
     
//      mult_gen_0 multiply (
//                 .A(sum),
//                 .B(C),
//                 .P(result),
//                 .CLK(clk)
//             );
    
    initial begin
    
    
        // | bit znaku, 1 to minus | bit ca³oœci, 1 to 0 | 2^-1 | 2^-2 | 2^-3 | 2^-4  | 2^-5 | 2^-6 |
        A = 8'b00000000;
        B = 8'b00000000;
        C = 8'b00000000;
        #3
        A = 8'b10000001; // -1,984375
        B = 8'b10000010; // -1.96875
        C = 8'b01011000; // 0,375
        #2
        A = 8'b11000001; // -0,984375
        B = 8'b10000010; // -1.96875
        C = 8'b01011000; // 0,0
        #2
        A = 8'b10000001;
        B = 8'b10000011;
        C = 8'b01011000;
        #20
        $finish;
    end
    
    initial begin
    while (1)
        #1 clk = ~clk;
    end
    
endmodule