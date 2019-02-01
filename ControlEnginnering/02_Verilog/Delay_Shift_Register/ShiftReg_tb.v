`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2018 10:51:57
// Design Name: 
// Module Name: ShiftReg_tb
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


module ShiftRegDelay_tb(

    );
    
       reg [7:0]d = 8'b00000000 ;  // REGISTERS SUBSTITUTE INPUTS IN TB
       reg ce = 1'b1 ;
       reg clk = 1'b0 ;
       
       wire [7:0]q ; // WIRES SUBSTITUTE OUTPUTS IN TB
     
       ShiftRegDelay #( .DELAY(3), .N(8) ) DUT (
        .idata(d),
        .ce(ce),
        .clk(clk),
        .odata(q)
        );
        
       initial
       begin
   //    #2; x = 3'b01001111;
       while(1)
           begin
               #1; clk=1'b0;  // GENERATE SQUARE WAVE - CHANGE EVERY 1 NS
//               #1; d<=d+1;
               #1; clk=1'b1;
           end
       end
       
       always @(posedge clk)  // PROCESS ACTIVATED BY POSITIVE EDGE OF CLOCK 
       begin
           d<=d+1;
       end    
       
    
endmodule
