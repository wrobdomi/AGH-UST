`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2017 13:10:32
// Design Name: 
// Module Name: acumulator
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


module accumulator(
        input clk,
        input rst, 
        input ce,
        input[12:0] A,
        output[20:0] Y,
        output[20:0] sum_out
    );
    wire[20:0] out_reg;
    reg[20:0] store_val = 0;
    //assign Y = rejestr;
    
    c_addsub_0 adder (
        // .CLK(clk),
        .CE(ce),
        .A(A),
        .B(store_val),
        .S(out_reg)
    );
    
 
    always @(posedge clk) begin
        if (rst) begin
            store_val = 21'b000000000000000000000;
        end
        else begin
            store_val = out_reg;
            
        end
    end
    
    assign sum_out = out_reg;
    assign Y = store_val;
    
endmodule
