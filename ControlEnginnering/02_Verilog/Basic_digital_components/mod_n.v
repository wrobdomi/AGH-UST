`timescale 1ns / 1ps
module mod_n
    # (
    parameter WIDTH = 9 // COUNTER WILL COUNT UP TO THIS VALUE
    )

(

    input clk, 
    input ce, 
    input rst, // RESET VALUE OF COUNTER
    output [WIDTH-1:0]y
    );
    
    reg [ WIDTH-1 : 0 ]val = 4'b00000000 ; // STORE COUNTER VALUE 
    
    always @( posedge clk)
    begin
    if (rst) val<=4'b00000000;
    else
        if( val < WIDTH-1 ) val<=val+1;
        else val<=4'b00000000;
    end
    
    assign y=val;
    
endmodule
