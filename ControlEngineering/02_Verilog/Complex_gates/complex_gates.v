`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2018 20:16:28
// Design Name: 
// Module Name: complex_gates
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


module complex_gates(
    input [7:0]x ,
    input [7:0]y ,
    output out
    );
    
        wire[7 : 0 ]chain_1 ;    // WIRES NEEDED
        wire[3 : 0 ]chain_2 ;
        wire[2 : 0 ]chain_3 ;
        wire out_1;
        
        genvar i; // GENERATE VARIABLE i
        
        generate // 'MACRODEF'
        
            for( i=0 ; i<8 ; i=i+1 )
            begin
           
            assign chain_1[i] = y[i] & x[i];
            
            if( i%2 == 1 )
                assign chain_2[ (i-1)/2] = chain_1[i-1] | chain_1[i];
               
            if ( i%4 == 3 )
                assign chain_3[ (i-3)/4 ] = chain_2[(i-3)/2 ] & chain_2[ (i-3)/2 + 1  ];
                
            if ( i%7 == 0 && i != 0  )
                assign out_1 = chain_3[i-7] | chain_3[i-6];
              
            end
            
            
        endgenerate 
        
      
      assign out = out_1;
    
endmodule
