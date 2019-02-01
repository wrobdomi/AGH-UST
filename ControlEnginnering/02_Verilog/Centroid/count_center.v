`timescale 1ns / 1ps

//// MODULE ACCUMULATOR ------------------------------------------------------------------------ //
//// ------------------------------------------------------------------------------------------- //  
//module accumulator(
//        input clk,
//        input rst, 
//        input ce,
//        input[10:0] A, // Input is position x or y so must be 11 bits at least as we have max pos = 1280 
//        output[29:0] Y // max value to be stored = ( 1+2+...+1280 ) * 720 = 590 284 800 => 29 bits needed at least
//    );                 // but taken 30 to have same size as output from accumulator which is 30 for 29 bit input           
//    wire[29:0] out_wire;
//    reg[29:0] store_val = 0;
    
//    // What is going on here ?! :
//    // -- A input pos ----> | SUM | --> out_wire is THIS wire --- | when pos edge assign out_wire to store_val | --- Y output = store_val  ------ > 
//    //                         ^                                                              |                                                
//    //                         |------------------------  store_val register -----------------|           
    
//    //  Implementing algorithm on the board we use picture 1280 x 720
//    //  Lets take image ( very one-color image ) :
//    //            0 1 2 3 4 5 6 ... 1280
//    //            -------------------------> x_pos
//    //   |    0    1 1 1 1 1 1 1 ... 1
//    //   |    1    1 1 1 1 1 1 1 ... 1
//    //   |    2    1 1 1 1 1 1 1 ... 1
//    //   |    3    1 1 1 1 1 1 1 ... 1
//    //   |    .    . . . . . . . . . .
//    //   |    .    . . . . . . . . . .
//    //   |    .    . . . . . . . . . .
//    //  \/    720  1 1 1 1 1 1 1 1 1 1 
//    //  y_pos
    
//    // We will then accumulate :    ( 0 + 1 + 2 + 3 + ... + 1279 ) * 720   for m10
//    //                          for ( 0 + 1 + 2 + 3 + ... 629 ) * 1280     for m01
//    //                          
    
//    // Do some math magic then :
//    // Caution ! adder must be generated propely with parametres as below !
//    c_addsub_0 adder ( // lATENCY = 0 => no clock
//        // .CLK(clk),
//        .CE(ce),       
//        .A(A),          // unsigned 11 bit
//        .B(store_val),  // unsigned 30 bit
//        .S(out_wire)    // unsigned 30 bit
//    );
    
//    // Counting, counting, counting... wait ! Enf of frame ! 
//    always @(posedge clk) begin
//        if (rst) begin              
//            store_val = 30'b000000000000000000000000000000;
//        end
//        else begin
//            store_val = out_wire;
//        end
//    end
    
//    // Finally our result ! 
//    assign Y = store_val;
    
//endmodule
//// ------------------------------------------------------------------------------------------- //  
//// ------------------------------------------------------------------------------------------- //  


// MODULE COUNT CENTER ----------------------------------------------------------------------- //  
// ------------------------------------------------------------------------------------------- //  
module count_center# (
    parameter IMG_W = 64, // I am parameterizable module ! -> max 1280
    parameter IMG_H = 64  // I am parameterizable module ! -> max 720
)
(
    input clk,            // standard interface
    input de_in,          //
    input h_sync_in,      //
    input v_sync_in,      //
    
    input mask,           // and mask - which is 1 for 255 ( white ) 
                          // and 0 for 0 - there are only two values after binarisation
    
    output [10:0]x,     // counted centroid coordinates 
    output [10:0]y     // ...someday they will be here :') 
    
);

assign mask_out = mask;

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

wire[10:0] x_pos_wire;
wire[10:0] y_pos_wire;

assign x_pos_wire = x_pos;
assign y_pos_wire = y_pos;
// ------------------------------------------------------------------------------------------- //          
// ------------------------------------------------------------------------------------------- //    


// End Of Frame detector --------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------- // 

wire eof;
assign eof = ( ( prev_vsync == 1'b0 )  && ( v_sync_in == 1'b1 ) ) ? 1'b1 : 1'b0; 
// Have you spotted that vsync was 0 and now it is 1 ? 
// End of frame then ! 


// ------------------------------------------------------------------------------------------- //  
// ------------------------------------------------------------------------------------------- // 

wire[19:0] m00_result;
reg [19:0] val_m00 = 20'b000000000000000000000; // 1280 * 720 = max. 1 048 575 pixels => 20 bit at least
// Count white pixels ------------------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------- // 
always @(posedge clk) 
begin 
if(eof) val_m00 <= 20'b000000000000000000000; // Have we arrived to the end_of_frame ? Yes ? Start counting from 0 then. 
else if(mask) val_m00 <= val_m00 + 1;             // '...It don't matter if you're black or white' ? Plus 1 for the whites... 
else val_m00 <= val_m00;                          // What is this line for ? ? ? 
end

assign m00_result = val_m00;

// ------------------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------- // 


wire [29:0] m10_result;
wire [29:0] m01_result;
// Accumulators ------------------------------------------------------------------------------ //
// Count m10 and m01 ------------------------------------------------------------------------- // 

accumulator_0 m10 ( // m10 for x_pos
        .clk(clk),
        .rst(eof),
        .ce(mask),
        .A(x_pos_wire),
        .Y(m10_result)
    );
    
accumulator_0 m01 ( // m01 for y_pos
        .clk(clk),
        .rst(eof),
        .ce(mask),
        .A(y_pos_wire),
        .Y(m01_result)
);    



// Prepare signals before devider ------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------- // 
wire [31:0] m10_extended;       // extend before devider
wire [31:0] m01_extended;       // extend before devider
                                // no need to extend m00 as default value in devider is 20 bit for m00
                                
wire [31:0] temp_out_x_center;  // temporary output from devider
wire [31:0] temp_out_y_center;  // temporary output from devider

wire enable_1;                    // enable passing values from devider 1 - is up when deviding is finshed
wire enable_2;                    // enable passing values from devider 2

assign m10_extended = {2'b0, m10_result};  // Add 2 bits to have total 32 bits for deviding
assign m01_extended = {2'b0, m01_result};  // Add 2 bits to have total 32 bits for dividing

reg[31:0] center_x;     // store value x from devider when enabled
reg[31:0] center_y;     // store value y from devider when enabled

// divider_32_30 ----------------------------------------------------------------------------- //
// Math magic applied to charm out coordidantes of centroid ---------------------------------- // 
divider_32_20_0 count_x_center (
        .clk(clk),
        .start(eof),                    // Start dividing
        .dividend(m10_extended),        // Devide this 
        .divisor(val_m00),              // with this
        .quotient(temp_out_x_center),   // result
        .qv(enable_1)                   // Tell me if you have finished deviding
        );
    
divider_32_20_0 count_y_center (
        .clk(clk),
        .start(eof),
        .dividend(m01_extended),
        .divisor(val_m00),
        .quotient(temp_out_y_center),
        .qv(enable_2)
        );  



always @(posedge clk) 
begin 
    if(enable_1) 
    begin
        center_x <= temp_out_x_center;  
    end
    if(enable_2)
    begin
        center_y <= temp_out_y_center;
    end
end

assign x = center_x[10:0];
assign y = center_y[10:0];



// ------------------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------- // 

endmodule
