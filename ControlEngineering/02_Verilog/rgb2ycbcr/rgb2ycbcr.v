`timescale 1ns / 1ps

module rgb2ycbcr(
    input clk,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    input[23:0] pixel_in,
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output[23:0] pixel_out

);
        
    // ----------------------------------------------------------------------------- //
    // Delay sync signals according to overall latency
    wire const_ce = 1'b1; 
    ShiftRegDelay#(6,3) del (const_ce, clk, {de_in, h_sync_in, v_sync_in}, {de_out, h_sync_out, v_sync_out} );
    // Parameters are Delay, Bus Width
    // ----------------------------------------------------------------------------- //
   
   
    // ----------------------------------------------------------------------------- //
    wire signed [17:0] R_extended ; // These wires are to extend R,G,B vectors
    wire signed [17:0] G_extended ; // they are needed because inputs to mults
    wire signed [17:0] B_extended ; // are all 18 bits long
    assign R_extended = {10'b0, pixel_in[23:16]};
    assign G_extended = {10'b0, pixel_in[15:8]};
    assign B_extended = {10'b0, pixel_in[7:0]};
    // ----------------------------------------------------------------------------- //
   
    
    // ----------------------------------------------------------------------------- //
    // Wires below represent constant coefficients 
    // used in rgb2ycbcr conversion, they are 18 bits long
    // in accordance to mult inputs 
    wire[17:0] const_11 = 18'b000100110010001011; // 0.299
    wire[17:0] const_12 = 18'b001001011001000101; // 0.587 
    wire[17:0] const_13 = 18'b000001110100101111; // 0.114 
    wire[17:0] const_21 = 18'b111101010011001110; // -0.168736
    wire[17:0] const_22 = 18'b111010101100110010; // -0.331264
    wire[17:0] const_23 = 18'b001000000000000000; // 0.5
    wire[17:0] const_31 = 18'b001000000000000000; // 0.5
    wire[17:0] const_32 = 18'b111001010011010001; // -0.418688
    wire[17:0] const_33 = 18'b111110101100101111; // -0.081312
    wire[8:0] add_128 = 9'b010000000; 
    // ----------------------------------------------------------------------------- //
    
    
    // ----------------------------------------------------------------------------- //     
    // Wires below represent results of                                          
    // first line multiplications                                                                                           
    wire[35:0] r1R_mult_result;                                  
    wire[35:0] r1G_mult_result;                                   
    wire[35:0] r1B_mult_result;                                  
    wire[35:0] r2R_mult_result;                               
    wire[35:0] r2G_mult_result;                               
    wire[35:0] r2B_mult_result;                                    
    wire[35:0] r3R_mult_result;                                     
    wire[35:0] r3G_mult_result;                               
    wire[35:0] r3B_mult_result;                                                                                   
    // ----------------------------------------------------------------------------- //     
    
    
   // ----------------------------------------------------------------------------- //     
   // First line multiplications                                                  
    mult_gen_0 row_1_Red(.CLK(clk), .A(const_11), .B(R_extended), .P(r1R_mult_result) ); 
    mult_gen_0 row_1_Green(.CLK(clk), .A(const_12), .B(G_extended), .P(r1G_mult_result) ); 
    mult_gen_0 row_1_Blue(.CLK(clk), .A(const_13), .B(B_extended), .P(r1B_mult_result) ); 
    
    mult_gen_0 row_2_Red(.CLK(clk), .A(const_21), .B(R_extended), .P(r2R_mult_result) ); 
    mult_gen_0 row_2_Green(.CLK(clk), .A(const_22), .B(G_extended), .P(r2G_mult_result) ); 
    mult_gen_0 row_2_Blue(.CLK(clk), .A(const_23), .B(B_extended), .P(r2B_mult_result) ); 
       
    mult_gen_0 row_3_Red(.CLK(clk), .A(const_31), .B(R_extended), .P(r3R_mult_result) ); 
    mult_gen_0 row_3_Green(.CLK(clk), .A(const_32), .B(G_extended), .P(r3G_mult_result) ); 
    mult_gen_0 row_3_Blue(.CLK(clk), .A(const_33), .B(B_extended), .P(r3B_mult_result) );                
    // ----------------------------------------------------------------------------- //
    
        
    // ----------------------------------------------------------------------------- // 
    // Wires below represent shortened                                                
    // result of multiplications                                                  
    wire[8:0] sh_r1R_mult_result;                                                         
    wire[8:0] sh_r1G_mult_result;                                                         
    wire[8:0] sh_r1B_mult_result;                                                         
    wire[8:0] sh_r2R_mult_result;                                                         
    wire[8:0] sh_r2G_mult_result;                                                         
    wire[8:0] sh_r2B_mult_result;                                                         
    wire[8:0] sh_r3R_mult_result;                                                         
    wire[8:0] sh_r3G_mult_result;                                                         
    wire[8:0] sh_r3B_mult_result;                                                         
    // ----------------------------------------------------------------------------- // 
    
    
    // ----------------------------------------------------------------------------- // 
    // Shortening results of multiplication to 9 bits 
    // Shortened vector contains sign + 8 youngest bits of integer part                                                                                   
    assign sh_r1R_mult_result = {r1R_mult_result[35],r1R_mult_result[23:16]};
    assign sh_r1G_mult_result = {r1G_mult_result[35],r1G_mult_result[23:16]};
    assign sh_r1B_mult_result = {r1B_mult_result[35],r1B_mult_result[23:16]};
    assign sh_r2R_mult_result = {r2R_mult_result[35],r2R_mult_result[23:16]};
    assign sh_r2G_mult_result = {r2G_mult_result[35],r2G_mult_result[23:16]};
    assign sh_r2B_mult_result = {r2B_mult_result[35],r2B_mult_result[23:16]};
    assign sh_r3R_mult_result = {r3R_mult_result[35],r3R_mult_result[23:16]};
    assign sh_r3G_mult_result = {r3G_mult_result[35],r3G_mult_result[23:16]};
    assign sh_r3B_mult_result = {r3B_mult_result[35],r3B_mult_result[23:16]};    
    // ----------------------------------------------------------------------------- // 
    
    
    // ----------------------------------------------------------------------------- // 
    // Delaying Blue shortened multipliction result  
    // Second line, delay = 1
    wire [8:0] del_sh_r1B_mul_result;
    wire [8:0] del_sh_r2B_mul_result;
    wire [8:0] del_sh_r3B_mul_result;
    ShiftRegDelay#(1,9) del_1 (const_ce, clk, sh_r1B_mult_result , del_sh_r1B_mul_result );
    ShiftRegDelay#(1,9) del_2 (const_ce, clk, sh_r2B_mult_result , del_sh_r2B_mul_result );
    ShiftRegDelay#(1,9) del_3 (const_ce, clk, sh_r3B_mult_result , del_sh_r3B_mul_result );
    // ----------------------------------------------------------------------------- // 
    
    
    // ----------------------------------------------------------------------------- // 
    // Adding red and green shortened multiplication results  
    // Latency of summators is 1, second line
    wire [9:0] r1RG_add_result; // outputs of summators
    wire [9:0] r2RG_add_result;
    wire [9:0] r3RG_add_result;
    c_addsub_0 row_1_RG(.CLK(clk), .A(sh_r1R_mult_result), .B(sh_r1G_mult_result), .S(r1RG_add_result) ); 
    c_addsub_0 row_2_RG(.CLK(clk), .A(sh_r2R_mult_result), .B(sh_r2G_mult_result), .S(r2RG_add_result) ); 
    c_addsub_0 row_3_RG(.CLK(clk), .A(sh_r3R_mult_result), .B(sh_r3G_mult_result), .S(r3RG_add_result) ); 
    // ----------------------------------------------------------------------------- // 
    
    // ----------------------------------------------------------------------------- // 
    // Sum 3rd line, Latency = 1 
    wire [10:0] pre_Y; // outputs of summators
    wire [10:0] pre_Cb;
    wire [10:0] pre_Cr;
    c_addsub_1 row_1_RGB(.CLK(clk), .A(r1RG_add_result), .B(del_sh_r1B_mul_result), .S(pre_Y) ); 
    c_addsub_1 row_2_RGB(.CLK(clk), .A(r2RG_add_result), .B(del_sh_r2B_mul_result), .S(pre_Cb) ); 
    c_addsub_1 row_3_RGB(.CLK(clk), .A(r3RG_add_result), .B(del_sh_r3B_mul_result), .S(pre_Cr) ); 
    // ----------------------------------------------------------------------------- // 
        
    // + 128 Sum 4th line, Latency = 1
    // Cb Cr only 
    wire [11:0] Cb_long;
    wire [11:0] Cr_long;
    c_addsub_2 row_2_RGB_128(.CLK(clk), .A(pre_Cb), .B(add_128), .S(Cb_long) ); 
    c_addsub_2 row_3_RGB_128(.CLK(clk), .A(pre_Cr), .B(add_128), .S(Cr_long) );  
    // ----------------------------------------------------------------------------- // 
        
    // ----------------------------------------------------------------------------- // 
    // Delaying pre_Y  
    // 4th line
    wire [10:0] Y_long;     
    ShiftRegDelay#(1,11) del_4 (const_ce, clk, pre_Y , Y_long  );
    // ----------------------------------------------------------------------------- // 
        
    
    assign pixel_out = { Y_long[7:0], Cb_long[7:0], Cr_long[7:0] } ;
        
endmodule
