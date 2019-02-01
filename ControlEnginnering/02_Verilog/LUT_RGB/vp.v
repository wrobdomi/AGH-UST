`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2018 23:09:49
// Design Name: 
// Module Name: vp
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

module vp(
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
    LUT red(pixel_in[23:16], clk, pixel_out[23:16]);
    LUT green(pixel_in[15:8], clk, pixel_out[15:8]);
    LUT blue(pixel_in[7:0], clk, pixel_out[7:0]);
    
    reg de_in_del;
    reg h_sync_in_del;
    reg v_sync_in_del;
       
    always @(posedge clk) begin
        de_in_del = de_in;
        h_sync_in_del = h_sync_in;
        v_sync_in_del = v_sync_in;
    end
    
    assign h_sync_out = h_sync_in_del;
    assign v_sync_out = v_sync_in_del;
    assign de_out = de_in_del;
    
endmodule
