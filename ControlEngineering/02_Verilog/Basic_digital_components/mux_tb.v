`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2018 09:56:44 AM
// Design Name: 
// Module Name: mux_tb
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


module mux_tb(

    );
    
           reg [7:0] x = 8'b00000000 ;  // REGISTERS SUBSTITUTE INPUTS IN TB
           reg [2:0] a = 8'b000 ;
           wire y; // WIRES SUBSTITUTE OUTPUTS IN TB
          
           mux DUT (
            .x(x),
            .a(a),
            .y(y)
            );
            
           initial
           begin
           
            #1; 
            x = 8'b01010101; // 0
            a = 8'b010;
                   
            #1; 
            x = 8'b01010101; // 0
            a = 8'b111;
                           
            #1; 
            x = 8'b01010101; // 0
            a = 8'b000;
                                   
            #1; 
            x = 8'b01010101; // 0
            a = 8'b011;
                                          
                    
            end
endmodule
