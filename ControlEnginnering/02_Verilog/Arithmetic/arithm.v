`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2018 01:18:59
// Design Name: 
// Module Name: 33
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


module summator(
        input clk,
        input ce,
        input[7:0] A,
        input[7:0] B,
        input[7:0] C,
        output[16:0] Y,
        output[8:0] sum_res

    );


wire [8:0] sum;
wire [7:0] delayed_C;
wire [16:0] result;

c_addsub_0 add (A, B, clk, ce, sum); // latency 1
ShiftRegDelay#(2,8) del (ce, clk, C, delayed_C);
mult_gen_0 muultiply (clk, sum, delayed_C, result);  

assign Y = result;
assign sum_res = sum;

endmodule