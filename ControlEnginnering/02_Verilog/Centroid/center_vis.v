`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2018 10:08:50
// Design Name: 
// Module Name: center_vis
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


module center_vis# (
    parameter IMG_W = 64, // I am parameterizable module ! -> max 1280
    parameter IMG_H = 64  // I am parameterizable module ! -> max 720
)(
    input clk,
    input de_in,
    input h_sync_in,
    input v_sync_in,
    input [23:0] pixel_in,
     
    output de_out,
    output h_sync_out,
    output v_sync_out,
    output [23:0] pixel_out,
    
    input [10:0] x_center,
    input [10:0] y_center
    
    );
    
    
 reg [10:0] x_pos = 11'b0; // MAX 1280 => 11 bit needed at least
 reg [10:0] y_pos = 11'b0; // MAX 720
 reg prev_vsync = 1'b0;
    
    // DETERMINE CURRENCT POSITION ON THE PICTURE --------------------------------------------------- //
    // WHERE AM I ?! -------------------------------------------------------------------------------- //  
     always @(posedge clk)
     begin 
            if (v_sync_in == 1)         // Are we done for this frame?
            begin 
                x_pos <= 11'b0;         // Yes, we are done for this frame
                y_pos <= 11'b0;         // Start counting from 0
            end 
            
            else if (de_in == 1'b1)     // Or are we just done for this pixel and we are in next column now ?
            begin
                x_pos <= x_pos + 1;         // Yes, we are done only for this pixel and we go to next column
                
                if (x_pos == IMG_W - 1)     // Are we done for one row so we go to the next?
                begin   
                    x_pos <= 11'b0;             // Yes, we are done for this row -> Start from 0
                    y_pos <= y_pos + 1;         // It logically implies => we are in next row now
                
                    if (y_pos == IMG_H - 1)     // Are we done for all the rows ?  
                    begin 
                        y_pos <= 11'b0;             // Yes, we are done for all rows -> Start from 0
                    end   
                end
                
            end
    
    prev_vsync <= v_sync_in;  // Store previous value of vsync to determine end of frame 
            
    end // End clock trigerred part
    
   //  wire[7:0] i_red;
    wire[23:0] o_red;
    
    // assign i_red = pixel_in[23:16];
    
    assign o_red = ( (x_pos[10:0]==x_center || y_pos[10:0]==y_center) ? {8'hff,16'b0000000000000000} : pixel_in ); 
    
   // assign pixel_out = {o_red, pixel_in[15:0]};
    assign pixel_out = o_red;
    
   // assign pixel_out = pixel_in;
    
    wire const_ce = 1'b1; 
    
    ShiftRegDelay#(1,3) del_in_vis (const_ce, clk, {de_in, h_sync_in, v_sync_in}, {de_out, h_sync_out, v_sync_out} );
    
    
endmodule
