`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 17:11:33
// Design Name: 
// Module Name: med_delay
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


module med_delay
(
    input clk,
    input[3:0] in,
    output[2:0] sum,
    output de,
    output[3:0] out
);
    wire[3:0] temp_1;
    wire[3:0] temp_2;
    wire[3:0] temp_3;
    wire[3:0] temp_4;
    wire[3:0] temp_5;

    assign out = temp_5;
    
    ShiftRegDelay # (.N(4), .DELAY(1)) del_1 (1'b1, clk, in , temp_1);
    ShiftRegDelay # (.N(4), .DELAY(1)) del_2 (1'b1, clk, temp_1,  temp_2);
    ShiftRegDelay # (.N(4), .DELAY(1)) del_3 (1'b1, clk, temp_2, temp_3);
    ShiftRegDelay # (.N(4), .DELAY(1)) del_4 (1'b1, clk, temp_3, temp_4);
    ShiftRegDelay # (.N(4), .DELAY(1)) del_5 (1'b1, clk, temp_4,  temp_5);

    assign sum = (temp_1[3] + temp_2[3]) + temp_3[3] + (temp_4[3] + temp_5[3]); 
    assign de = (temp_1[2] & temp_2[2]) & temp_3[2] & (temp_4[2] & temp_5[2]); 
endmodule
