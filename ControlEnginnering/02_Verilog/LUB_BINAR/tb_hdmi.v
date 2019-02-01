`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH
// Engineer: Tomasz Kryjak
// 
// Create Date:    11:29:28 10/28/2013 
// Design Name: 
// Module Name:    tb_filter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tb_hdmi(
    );
	 

wire rx_pclk;

wire rx_de;
wire rx_hsync;
wire rx_vsync;
wire lut_de;
wire lut_hsync;
wire lut_vsync;

wire [7:0] rx_red;
wire [7:0] rx_green;
wire [7:0] rx_blue;
wire [23:0] merge_in_LUT = {rx_red, rx_green, rx_blue}; // merge RBG before LUT **************************

wire lut_de_out;
wire lut_hsync_out;
wire lut_vsync_out;
wire tx_de;
wire tx_hsync;
wire tx_vsync;



wire [7:0] tx_red;
wire [7:0] tx_green;
wire [7:0] tx_blue;
wire [7:0] merge_out_LUT; // output wire from LUT
wire [7:0] red_demerge = merge_out_LUT;  // demerge red after LUT  *************************************
wire [7:0] green_demerge = merge_out_LUT; // demerge green after LUT **********************************
wire [7:0] blue_demerge = merge_out_LUT; // demerge blue after LUT ***********************************


// --------------------------------------
// HDMI input
// --------------------------------------
hdmi_in file_input (
    .hdmi_clk(rx_pclk), 
    .hdmi_de(rx_de), 
    .hdmi_hs(rx_hsync), 
    .hdmi_vs(rx_vsync), 
    .hdmi_r(rx_red), 
    .hdmi_g(rx_green), 
    .hdmi_b(rx_blue)
    );
	 
// -------------------------------------
// LUT
// -------------------------------------

vp_binarisation_0 Look ( 
        .clk(rx_pclk),
        .de_in(lut_de),
        .h_sync_in(lut_hsync),
        .v_sync_in(lut_vsync),
        .pixel_in(merge_in_LUT),
        .de_out(lut_de_out),
        .h_sync_out(lut_hsync_out),
        .v_sync_out(lut_vsync_out),
        .pixel_out(merge_out_LUT)
        );
	 
// --------------------------------------
// Output assigment
// --------------------------------------
//assign tx_de = rx_de;
//assign tx_hsync = rx_hsync;
//assign tx_vsync = rx_vsync;

//assign tx_red = rx_red;
//assign tx_green = rx_green;
//assign tx_blue = rx_blue;

assign lut_de = rx_de;
assign lut_hsync = rx_hsync;
assign lut_vsync = rx_vsync;

assign tx_de = lut_de_out;
assign tx_hsync = lut_hsync_out;
assign tx_vsync = lut_vsync_out;
assign tx_red = red_demerge;
assign tx_green = green_demerge;
assign tx_blue = blue_demerge;
	 
// --------------------------------------
// HDMI output
// --------------------------------------
hdmi_out file_output (
    .hdmi_clk(rx_pclk), 
    .hdmi_vs(tx_vsync), 
    .hdmi_de(tx_de), 
    .hdmi_data({8'b0,tx_red,tx_green,tx_blue})
    );


endmodule
