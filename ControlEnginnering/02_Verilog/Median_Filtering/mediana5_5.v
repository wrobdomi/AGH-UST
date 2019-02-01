`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 16:53:30
// Design Name: 
// Module Name: mediana5_5
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


module mediana5_5#(
   parameter H_SIZE = 83,
   parameter H_SIZE_LESS = 77)
(  
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
    
   wire mask = pixel_in[0];
   wire[3:0] glued_four = {mask, de_in, h_sync_in, v_sync_in};
   wire[3:0] bram_1;
   wire[3:0] bram_2;
   wire[3:0] bram_3;
   wire[3:0] bram_4;
   reg context_de_1 = 0;
   reg context_de_2 = 0;
   reg context_de_3 = 0;
   reg context_de_4 = 0;
   reg context_de_5 = 0;
   reg overall_context_de = 0;
   reg [3:0] D11 = 0;
   reg [3:0] D12 = 0;
   reg [3:0] D13 = 0;
   reg [3:0] D14 = 0;
   reg [3:0] D15 = 0; 
   reg [3:0] D21 = 0;
   reg [3:0] D22 = 0;
   reg [3:0] D23 = 0;
   reg [3:0] D24 = 0;
   reg [3:0] D25 = 0;
   reg [3:0] D31 = 0;
   reg [3:0] D32 = 0;
   reg [3:0] D33 = 0;
   reg [3:0] D34 = 0;
   reg [3:0] D35 = 0; 
   reg [3:0] D41 = 0;
   reg [3:0] D42 = 0;
   reg [3:0] D43 = 0;
   reg [3:0] D44 = 0;
   reg [3:0] D45 = 0; 
   reg [3:0] D51 = 0;
   reg [3:0] D52 = 0;
   reg [3:0] D53 = 0;
   reg [3:0] D54 = 0;
   reg [3:0] D55 = 0;
   reg [2:0] sum_1 = 0;
   reg [2:0] sum_2 = 0; 
   reg [2:0] sum_3 = 0; 
   reg [2:0] sum_4 = 0; 
   reg [2:0] sum_5 = 0; 
   reg [4:0] overall_sum = 0;
   
always @(posedge clk)
    begin
        D11 <= glued_four;
        D12 <= D11;
        D13 <= D12;
        D14 <= D13;
        D15 <= D14;
        D21 <= bram_1;
        D22 <= D21;
        D23 <= D22;
        D24 <= D23;
        D25 <= D24;
        D31 <= bram_2; 
        D32 <= D31;
        D33 <= D32; 
        D34 <= D33;             
        D35 <= D34;
        D41 <= bram_3;
        D42 <= D41;
        D43 <= D42;
        D44 <= D43;       
        D45 <= D44;        
        D51 <= bram_4;
        D52 <= D51;
        D53 <= D52;
        D54 <= D53;
        D55 <= D54;
            
        sum_1 <= D11[3] + D12[3] + D13[3] + D14[3] + D15[3];
        sum_2 <= D21[3] + D22[3] + D23[3] + D24[3] + D25[3];
        sum_3 <= D31[3] + D32[3] + D33[3] + D34[3] + D35[3];
        sum_4 <= D41[3] + D42[3] + D43[3] + D44[3] + D45[3];
        sum_5 <= D51[3] + D52[3] + D53[3] + D54[3] + D55[3];
        overall_sum <= sum_1 + sum_2 + sum_3 + sum_4 + sum_5;
        
//        context_de_1 = D11[2] & D12[2] & D13[2] & D14[2] & D15[2];
//        context_de_2 = D21[2] & D22[2] & D23[2] & D24[2] & D25[2]; 
//        context_de_4 = D31[2] & D32[2] & D33[2] & D34[2] & D35[2];
//        context_de_4 = D41[2] & D42[2] & D43[2] & D44[2] & D45[2];
//        context_de_5 = D51[2] & D52[2] & D53[2] & D54[2] & D55[2];
//        overall_context_de = context_de_1 &  context_de_2 &  context_de_3 &  context_de_4 &  context_de_5;
        overall_context_de = D11[2] & D12[2] & D13[2] & D14[2] & D15[2] & D21[2] & D22[2] & D23[2] & D24[2] & D25[2] & D31[2] & D32[2] & D33[2] & D34[2] & D35[2] & D41[2] & D42[2] & D43[2] & D44[2] & D45[2] & D51[2] & D52[2] & D53[2] & D54[2] & D55[2];
end

delayLinieBRAM_WP #(
        .BRAM_SIZE_W(11)
    ) bram_memory (
        .clk(clk),
        .rst(1'b0),
        .ce(1'b1),
        .din({D15, D25, D35, D45}),
        .h_size(H_SIZE_LESS),
        .dout({bram_1, bram_2, bram_3, bram_4})
);

wire [4:0] final_sum;
wire final_context_de;
ShiftRegDelay #(
        .N(6),
        .DELAY(H_SIZE*2+1)
    ) final_delay ( 1'b1, clk, {overall_sum, overall_context_de}, {final_sum, final_context_de} );


wire[7:0] output_vector;
wire[7:0] output_vector_1;
assign output_vector = final_sum > 5'd12 ? 8'd255 : 8'd0;
assign output_vector_1 = final_context_de ? output_vector : 8'd0;
assign pixel_out = {  output_vector_1, output_vector_1, output_vector_1 };
   
assign de_out = D55[2];
assign h_sync_out = D55[1];
assign v_sync_out = D55[0];

endmodule
