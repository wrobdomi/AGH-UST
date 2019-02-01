`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2018 15:44:21
// Design Name: 
// Module Name: sum_tb
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


module sum_tb(
      
    );
    reg[17:0] A = 18'b000110010001010111;
                        
    reg[12:0] B = 13'b0011101011101;
                        
    reg[11:0] C = 11'b01001110101 ;
                       
    reg[14:0] D = 15'b001001000111000;
                      
    reg[17:0] E = 18'b001100011111111010 ;
                       
    reg[18:0] F = 19'b0010000110100011110;
                       
    
    
    reg clk = 0;
    reg ce = 1;
    wire[30:0] Y;
    wire[38:0] Y2;
    wire[18:0] sum_res;
    wire[11:0] c_del;
    wire[18:0] de_out;
    wire[19:0] fe_out;
    wire[39:0] equals;
   
    
    sum summ(
        .clk(clk),
        .ce(ce),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .F(F),
        .Y(Y),
        .Y2(Y2),
        .equals(equals),
        .sum_res(sum_res),
        .c_del(c_del),
        .de_out(de_out),
        .fe_out(fe_out)
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
//        A = 18'b00000000110110011;
//        B = 13'b0001010000000;
//        C = 12'b000010000000;
        A=-A;
        C=-C;
        E=-E;
        #2
        A = 18'b000000000110110011; // -1,984375
        B = 13'b0001010000000; // -1.96875
        C = 12'b000100000000; // 0,375
        D = 15'b000001001100110;
        E = 18'b000000001001100110;
        F = 19'b0000000001000110011;
        #2
        A = 18'b000000000110110011; // -0,984375
        B = 13'b0001010000000; // -1.96875
        C = 12'b000011000000; // 0,0
        D = 15'b000001001100110;
        E = 18'b000000010011001100;
        F = 19'b0000000100110011000;
        #2
        A = 18'b000000000110110011;
        B = 13'b0001010000000;
        C = 12'b000100000000;
        D = 15'b000001001100110;
        E = 18'b000000001001100110;
        F = 19'b0000000100110011000;
        #20
        $finish;
    end
    
    initial begin
    while (1)
        #1 clk = ~clk;
    end
    
endmodule
 
