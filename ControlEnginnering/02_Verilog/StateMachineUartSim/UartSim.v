`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2018 17:54:31
// Design Name: 
// Module Name: UartSim
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


module from_file_to_module(
    input clk,
    output send,
    output [7:0] data
    );
    
    localparam STATE0 = 2'd0;           // 2 bits, decimal basis
    localparam STATE1 = 2'd1; 
    
    integer i = 0;
    reg [1:0] state = STATE0;           // Initial State is STATE0
    integer file; // Points to file with data
    reg send_ready = 1'b0; // Flag to signalize ready data
    reg [7:0]data_from_file = 8'b00000000; // Store data from file

    initial 
    begin
        file = $fopen("C:/input.txt","r"); // open file with data 
    if (file == 0) 
        begin               
         $display("NULL"); 
         $finish;
        end
    else
         $display("not NULL");
    end
    
    
       
        always@(posedge clk)                
        begin
             case(state)             
                  STATE0:             
                  begin  
                        send_ready=1'b0;
                        i=i+1;
                        if( i <11 )    
                             state=STATE0;
                        else
                        begin
                            state=STATE1;
                            i=0;                   
                        end  
                  end 
                   
                  STATE1:             
                  begin             
                            data_from_file=$fgetc(file); 
                            send_ready=1'b1;
                            state<=STATE0;  
                  end 
                  
                 
                  
             endcase
                   
    end    
    
    assign data = data_from_file;
    assign send = send_ready;
    
endmodule

module stateMachine(
    input clk,
    input rst,
    input send,
    input [7:0] data,
    output txd
    );
    
    localparam STATE0 = 2'd0;           // 2 bits, decimal basis
    localparam STATE1 = 2'd1; 
    localparam STATE2 = 2'd2;
    localparam STATE3 = 2'd3;
    
    reg [1:0] state = STATE0;           // Initial State is STATE0
    reg txd_reg = 1'b0;                 // store value of output
    reg [7:0] data_reg = 8'b00000000;   // store data from input
    reg previous = 1'b0;                // To compare to previous value
    reg [2:0] counter = 3'b0;           // Store indexes of data_reg to send them every clk tick
    
    
    always@(posedge clk)                // state machine can change state only on rising edge
    
    begin
    
        if(rst)                         // test reset signal
            begin                       // go back to state0 when rst is one 
                state<=STATE0;          
                data_reg<=8'b00000000;  // clear data and counter on reset
                counter<=3'b000; 
            end
            
        else                            // if reset is not pressed start start state machine
            begin
                case(state)             // state machine choose states according to vriable state
               
                    STATE0:             
                    begin  
                        if( previous == 0 && send == 1)     // rising edge detection
                        begin
                            state=STATE1;                   // if send is enabled go to state1 
                            data_reg=data;                  // and save data from input
                        end  
                    end 
               
                    STATE1:             // Start transmission by sending 1 
                    begin               // and change state to next
                        txd_reg=1'b1; 
                        state<=STATE2;  
                    end 
               
                    STATE2:             // Transform parallel data into serial
                    begin               // send 1 bit every clk rising_edge
                        txd_reg=data_reg[counter];
                        if(counter==7)
                            state=STATE3;
                        counter=counter+1; 
                    end    
                    
                    STATE3:             // End transmission by sending 1 
                    begin               // and change state to initial
                        txd_reg=1'b0; 
                        state<=STATE0;
                    end    
                    
                endcase 
            end
    
    previous=send;
    
    end
    
    assign txd=txd_reg; 
            
endmodule

module from_mod_to_file(
    input txd
    );
    
    integer outfile; // Points to file with data
    reg [7:0]i = 8'b00000000;
    reg [7:0]j = 8'b00000000;
    
    initial 
    begin
        outfile = $fopen("C:/output.txt", "wb");
    if (outfile == 0) 
        begin               
         $display("NULL"); 
         $finish;
        end
    else
         $display("OPENED SUCCESSFULLY");
    end
    
    initial
    begin
       
        
        #24
        for(i=0;i<32;i=i+1)
        begin
            for(j=0;j<12;j=j+1)
            begin
                #2
                if(j==0 || j==1 || j==2 || j==10 || j==11)
                begin
                 $fwrite(outfile, "|");
                end
                 $fwrite(outfile, "%b", txd);
                 if(j==11)
                 begin
                 $fwrite(outfile, "|");
                 end
            end
        $fwrite(outfile, "   ");
        end  
               
                
     end
endmodule
