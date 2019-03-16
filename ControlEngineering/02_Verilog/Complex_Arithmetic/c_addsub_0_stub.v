// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Wed Apr 11 16:53:38 2018
// Host        : LAPTOP-O5FT8VUE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Dominik/Desktop/Systemy_Rekonfigurowalne/Programy/Lab4/Z_dom_2/sum/sum/sum.srcs/sources_1/ip/c_addsub_0/c_addsub_0_stub.v
// Design      : c_addsub_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_addsub_v12_0_9,Vivado 2016.2" *)
module c_addsub_0(A, B, CLK, CE, S)
/* synthesis syn_black_box black_box_pad_pin="A[17:0],B[12:0],CLK,CE,S[18:0]" */;
  input [17:0]A;
  input [12:0]B;
  input CLK;
  input CE;
  output [18:0]S;
endmodule
