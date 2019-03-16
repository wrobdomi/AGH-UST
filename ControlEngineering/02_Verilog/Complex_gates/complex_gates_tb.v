`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2018 23:02:24
// Design Name: 
// Module Name: complex_gates_tb
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


module complex_gates_tb(

    );
    
        reg [7:0] x = 8'b00000000 ;  // REGISTERS SUBSTITUTE INPUTS IN TB
        reg [7:0] y = 8'b00000000 ;
        wire out; // WIRES SUBSTITUTE OUTPUTS IN TB
       
        complex_gates DUT (
         .x(x),
         .y(y),
         .out(out)
         );
         
        initial
        begin
        
         #1; 
         x = 8'b01100111; // 0
         y = 8'b00011011;
                
         #1; 
         x = 8'b01100111; // 1 
         y = 8'b00011111;
                        
         #1; 
         x = 8'b11100101; // 1 
         y = 8'b00011111;
                                
         #1; 
         x = 8'b11100100; // 0
         y = 8'b00011111;
                                        
         #1; 
         x = 8'b11100100; // 0 
         y = 8'b11011111;
    
    
         #1; 
         x = 8'b11110100; // 1
         y = 8'b11011111;
        
         #1; 
         x = 8'b11100100; // 1 
         y = 8'b11111111;
         
         #1; 
         x = 8'b11111111; // 1 
         y = 8'b11111111;
                 
         end
endmodule


