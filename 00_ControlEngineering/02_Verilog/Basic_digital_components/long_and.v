`timescale 1ns / 1ps

module long_and #
    (   
        parameter LENGTH = 8  // PARAMETER DEFINITION, 8 AND GATES IN SERIAL
    )
    (
        input[LENGTH-1 : 0 ]x,  // INPUT ARRAY
        output y                // OUTPUT
    );
    
    wire[LENGTH : 0 ]chain ;    // WIRES NEEDED TO CONNECT ANDs IN SERIAL
    assign chain[0] = 1'b1;     // 1st WIRE IS CONSTANT '1'
    
    genvar i; // GENERATE VARIABLE i FOR GENERATE BLOCK
    
    generate // 'MACRODEF'
        for(i=0;i<LENGTH;i=i+1)
        begin
        assign chain[i+1]=chain[i]&x[i];
        end
    endgenerate 
    
    assign y = chain[LENGTH];
    
endmodule
