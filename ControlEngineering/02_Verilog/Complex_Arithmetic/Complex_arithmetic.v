`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2018 15:36:00
// Design Name: 
// Module Name: sum
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


module sum(
        input clk,
        input ce,
        input[17:0] A,
        input[12:0] B,
        input[11:0] C,
        
        input[14:0] D,
        input[17:0] E,
        output[18:0] de_out,
        
        input[18:0] F,
        output[19:0] fe_out,
        
        output[30:0] Y,
        output[38:0] Y2,
        output[39:0] equals,
    
        
        output[18:0] sum_res,
        output[12:0] c_del
        
        
    );



wire [18:0] sum;
wire [11:0] delayed_C;
wire [30:0] result;
wire [38:0] result2;
wire [18:0] de;
wire [19:0] fe;
wire [39:0] equal;
wire [33:0] result_plus;


c_addsub_0 add (A, B, clk, ce, sum); // latency = 2
c_addsub_1 add_de (.A(D), .B(E), .CLK(clk), .CE(ce), .S(de)); // latency = 2
c_addsub_2 add_fe (.A(E), .B(F), .CLK(clk), .CE(ce), .S(fe)); // latency = 2
ShiftRegDelay#(2,12) del (ce, clk, C, delayed_C);
mult_gen_0 muultiply ( clk, sum, delayed_C, result);  // latency = 1
mult_gen_1 muultiply2 ( clk, de, fe, result2);  // latency = 1
c_addsub_3 add_final (.A(result_plus), .B(result2), .CLK(clk), .CE(ce), .S(equal)); // latency = 2




assign  result_plus={result,3'b0}; 
assign sum_res = sum;
assign c_del = delayed_C;
assign Y = result;
assign Y2 = result2;
assign de_out = de;
assign fe_out = fe;
assign equals = equal;
// assign de_out = 18'b000011000000000000;

endmodule
