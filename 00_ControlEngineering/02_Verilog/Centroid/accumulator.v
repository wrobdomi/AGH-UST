`timescale 1ns / 1ps

// MODULE ACCUMULATOR ------------------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------- //  
module accumulator(
        input clk,
        input rst, 
        input ce,
        input[10:0] A, // Input is position x or y so must be 11 bits at least as we have max pos = 1280 
        output[29:0] Y // max value to be stored = ( 1+2+...+1280 ) * 720 = 590 284 800 => 29 bits needed at least
    );                 // but taken 30 to have same size as output from accumulator which is 30 for 29 bit input           
    wire[29:0] out_wire;
    reg[29:0] store_val = 0;
    
    // What is going on here ?! :
    // -- A input pos ----> | SUM | --> out_wire is THIS wire --- | when pos edge assign out_wire to store_val | --- Y output = store_val  ------ > 
    //                         ^                                                              |                                                
    //                         |------------------------  store_val register -----------------|           
    
    //  Implementing algorithm on the board we use picture 1280 x 720
    //  Lets take image ( very one-color image ) :
    //            0 1 2 3 4 5 6 ... 1280
    //            -------------------------> x_pos
    //   |    0    1 1 1 1 1 1 1 ... 1
    //   |    1    1 1 1 1 1 1 1 ... 1
    //   |    2    1 1 1 1 1 1 1 ... 1
    //   |    3    1 1 1 1 1 1 1 ... 1
    //   |    .    . . . . . . . . . .
    //   |    .    . . . . . . . . . .
    //   |    .    . . . . . . . . . .
    //  \/    720  1 1 1 1 1 1 1 1 1 1 
    //  y_pos
    
    // We will then accumulate :    ( 0 + 1 + 2 + 3 + ... + 1279 ) * 720   for m10
    //                          for ( 0 + 1 + 2 + 3 + ... 629 ) * 1280     for m01
    //                          
    
    
    wire[10:0] in_accum; 
    assign in_accum = (ce == 1) ? A : 11'b00000000000; 
    // Do some math magic then :
    // Caution ! adder must be generated propely with parametres as below !
    add_add adder ( 
        // lATENCY = 0 => no clock
        // .CLK(clk),
        // Fabric, Manual 
        // !!! !!! CAUTION ....... !!! !!!
        // !!! !!! NAME  = add_add !!! !!!      
        .A(in_accum),   // unsigned 11 bit
        .B(store_val),  // unsigned 30 bit
        .CE(1'b1), 
        .S(out_wire)    // unsigned 30 bit
    );
    
    // Counting, counting, counting... wait ! Enf of frame ! 
    always @(posedge clk) begin
        if (rst) begin              
            store_val = 30'b000000000000000000000000000000;
        end
        else begin
            store_val = out_wire;
        end
    end
    
    // Finally our result ! 
    assign Y = store_val;
    
endmodule
// ------------------------------------------------------------------------------------------- //  
// ------------------------------------------------------------------------------------------- //  

