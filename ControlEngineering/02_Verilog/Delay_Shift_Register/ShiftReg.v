`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2018 10:38:46
// Design Name: 
// Module Name: ShiftReg
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


module ShiftReg #(
    parameter BUS_WIDTH = 8 // DATA BUS WIDTH , 1 bit is default
    ) 

(
    input clk, 
    input ce, 
    input [ BUS_WIDTH-1 : 0] d, 
    output[ BUS_WIDTH-1 : 0] q
    );
    
    reg [ BUS_WIDTH-1 : 0 ]val = 0 ;
    always @(posedge clk) 
    begin 
    if(ce) 
    val<=d; 
    else 
    val<=val; 
    end
    
    assign q=val;
    
    endmodule

    
