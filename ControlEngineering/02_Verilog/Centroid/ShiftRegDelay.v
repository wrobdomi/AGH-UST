`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2018 11:19:10
// Design Name: 
// Module Name: ShiftRegDelay
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



    


module ShiftRegDelay#(
    parameter DELAY = 2, // DELAY tells about number of registers connected in series
    // What is more important, delays is the number of rising edge with which signal
    // from input is seen in output  
    // For DELAY = 3 , signal from input will be in the output together with third rising edge
    // of clock signal 
    parameter N = 12  // DATA BUS WIDTH , 1 bit by default
    ) 

(
    input ce,
    input clk,
    input [ N-1 : 0 ]idata,
    output [ N-1 : 0 ]odata
    );
    
    wire [N-1:0] tdata [DELAY:0];
    
    genvar i;
    
    generate 
    
    if(DELAY==0) 
    begin
        assign odata = idata ;
    end 
    
    else 
    begin 
    
        assign tdata[0] = idata;
        
        for(i=0;i<DELAY;i=i+1) 
        begin
                ShiftReg  # ( .BUS_WIDTH(N) ) RegDel
                ( 
                .d(tdata[i]),
                .q(tdata[i+1]), 
                .clk(clk),
                .ce(ce)
                ); 
        end
        
        assign odata = tdata[DELAY];
    end 
    
    
    
    endgenerate 
    
endmodule
