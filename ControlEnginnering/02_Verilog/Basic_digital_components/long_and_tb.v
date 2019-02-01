`timescale 1ns / 1ps

module long_and_tb // 1-MODULE TESTBENCH
    (
    );
    
    reg [7:0] x = 8'b00000000 ;  // REGISTERS SUBSTITUTE INPUTS IN TB
    wire y; // WIRES SUBSTITUTE OUTPUTS IN TB
    reg clk = 1'b0 ;  // SIGNAL CLOCK 
  
    long_and #( .LENGTH(8) ) DUT (
     .x(x),
     .y(y)
     );
     
    initial
    begin
    while(1)
        begin
            #1; clk=1'b0;  // GENERATE SQUARE WAVE - CHANGE EVERY 1 NS
            #1; clk=1'b1;
        end
    end
    
    always @(posedge clk)  // PROCESS ACTIVATED BY POSITIVE EDGE OF CLOCK 
    begin
        x<=x+1;
    end    
    
endmodule
