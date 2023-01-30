`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2018 12:18:47 PM
// Design Name: 
// Module Name: seven_seg
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


module Seven_Segment(
    input dispclk,rst,
    input [1:0] state,
    input bist_status,
    output reg [7:0] control,
    output reg [7:0] Z
    );

parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9, S10=10,
          S11=11, S12=12, S13=13 , S14=14, S15=15, S16=16, S17=17, S18=18, S19=19,
          S20=20, S21=21, S22=22, S00=23;
            
integer state_disp;

always @(posedge dispclk)
begin
    if (rst)
        state_disp = S00;
    else
    begin  
    case(state_disp)
    
        S00 : state_disp = S1;
        
        S0 : state_disp = S1; //IDLE
        S1 : state_disp = S2;
        S2 : state_disp = S3;
        S3 : begin
            if(state == 2'b01)
                state_disp = S4;
            else
                state_disp = S0;
            end
            
        S4 : state_disp = S5; //READ_0
        S5 : state_disp = S6;
        S6 : state_disp = S7;
        S7 : begin
             if (bist_status == 1'b1)
                state_disp = S15;
             else if(state == 2'b10)
                state_disp = S8;
             else
                state_disp = S4;
             end
             
        S8 : state_disp = S9; //WRITE_1
        S9 : state_disp = S10;
        S10 :begin
             if(state == 2'b11)
                state_disp = S11;
             else
                state_disp = S8;
             end
             
        S11 : state_disp = S12; //READ_1
        S12 : state_disp = S13;
        S13 : state_disp = S14;
        S14 : begin
              if (bist_status == 1'b1)
                state_disp = S15;
              else if (bist_status == 1'b0 && state == 2'b00)
                state_disp = S19;
              else
                state_disp = S11;
              end
              
        S15 : state_disp = S16; //FAIL
        S16 : state_disp = S17;
        S17 : state_disp = S18;
        S18 : state_disp = S15;
        
        S19 : state_disp = S20; //PASS
        S20 : state_disp = S21;
        S21 : state_disp = S22;
        S22 : state_disp = S19;
         
         default : state_disp = S00;
         endcase
     end        
     case(state_disp)
        S00: begin
             control = 8'b11110000;
             Z = 8'b11111101; //----
             end  
        S0 : begin
             control = 8'b11110111;
             Z = 8'b10011111; //I
             end
        S1 : begin
             control = 8'b11111011;
             Z = 8'b00000011; //D
             end
        S2 : begin
             control = 8'b11111101;
             Z = 8'b11100011; //L
             end
        S3 : begin
             control = 8'b11111110;
             Z = 8'b01100001; //E
             end
        S4 : begin
             control = 8'b11110111;
             Z = 8'b01100011; //C
             end
        S5 : begin
             control = 8'b11111011;
             Z = 8'b10010001; //H
             end
        S6 : begin
             control = 8'b11111101;
             Z = 8'b01100011; //C
             end
        S7 : begin
             control = 8'b11111110;
             Z = 8'b00000011; //0
             end
        S8 : begin
             control = 8'b11110111;
             Z = 8'b11000011; //W1
             end
        S9 : begin
             control = 8'b11111011;
             Z = 8'b10000111; //W2
             end
        S10 : begin
              control = 8'b11111101;
              Z = 8'b11110011; //1
              end
        S11 : begin
              control = 8'b11110111;
              Z = 8'b01100011; //C
              end
        S12 : begin
              control = 8'b11111011;
              Z = 8'b10010001; //H
              end
        S13 : begin
              control = 8'b11111101;
              Z = 8'b01100011; //C
              end
        S14 : begin
              control = 8'b11111110;
              Z = 8'b11110011; //1
              end
        S15 : begin
              control = 8'b11110111;
              Z = 8'b01110001; //F
              end
        S16 : begin
              control = 8'b11111011;
              Z = 8'b00010001; //A
              end
        S17 : begin
              control = 8'b11111101;
              Z = 8'b11110011; //I
              end
        S18 : begin
              control = 8'b11111110;
              Z = 8'b11100011; //L
              end  
        S19 : begin
              control = 8'b11110111;
              Z = 8'b00110001; //P
              end
        S20 : begin
              control = 8'b11111011;
              Z = 8'b00010001; //A
              end
        S21 : begin
              control = 8'b11111101;
              Z = 8'b01001001; //S
              end
        S22 : begin
              control = 8'b11111110;
              Z = 8'b01001001; //S
              end
                 
    default : begin
              control = 8'b11110000;
              Z = 8'b11111101;
              end
      endcase             
end
endmodule
