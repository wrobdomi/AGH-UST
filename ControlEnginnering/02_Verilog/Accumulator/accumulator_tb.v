`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2018 10:16:47
// Design Name: 
// Module Name: project_3_tb
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


module accumulator_tb(
      
    );
    reg[12:0] A = 13'b0000000000000;            
    wire[20:0] Y;
    wire[20:0] sum_out;
    reg clk = 0;
    reg ce = 1;
    reg rst = 0;
    
    accumulator acu(
        .clk(clk),
        .ce(ce),
        .rst(rst),
        .A(A),
        .Y(Y),
        .sum_out(sum_out)
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

        #1.2
        A = 13'b0000000010000; // 1
        
        #0.3
        A = 13'b0000000100000; // 2
      
        #1.2
        A = 13'b0000000110000; // 3
    
        #1.3
        A = 13'b0000000011000; // 1.5
        
        #0.5
        A = 13'b0000000011010; // 1.6
        A = -A;
        #2
        A = 13'b0000000011011; // 1.7 
        
        #1.3
        A = 13'b0000000011100; // 1.8
        A=-A;   
        #2
        A = 13'b0000000011110; // 1.9
        
        #2
        A = 13'b0000000001000; // 1.5 
        
        #2
        A = 13'b0000000000011; // 0.2
        
        #2
        A = 13'b0000000000000;
           
              
                    
        #20
        $finish;
    end
    
    initial begin
    while (1)
        #1 clk = ~clk;
    end
    
endmodule
