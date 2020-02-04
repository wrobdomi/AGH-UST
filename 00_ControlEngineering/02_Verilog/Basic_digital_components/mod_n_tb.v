`timescale 1ns / 1ps

module mod_n_tb(

    );
    
    reg clk = 1'b0; 
    reg ce = 1'b1; 
    reg rst = 1'b0; 
    wire [8:0]y;
    
    mod_n # ( .WIDTH(9) ) DUT (
        .clk(clk),
        .ce(ce),
        .rst(rst),
        .y(y)
        );
        
        initial
        begin
        
        while(1)
            begin
                #1; clk=1'b0;
                #1; clk=1'b1;
        end
        
        end
        
endmodule
