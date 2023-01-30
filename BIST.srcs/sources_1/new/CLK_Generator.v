`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2018 10:15:45
// Design Name: 
// Module Name: CLK_Generator
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


module CLK_Generator(
    input clk,
    output reg dispclk,
    output reg sysclk
    );
    
integer sysclkcount,dispclkcount; 

always @(posedge clk)
    begin
        if(sysclkcount < 100000000)
            begin
            sysclkcount = sysclkcount+1;
            sysclk = 0;
            end
        else 
            begin
            sysclk = 1;
            sysclkcount = 0;
            end 
    end
    
always @(posedge clk)
    begin
        if(dispclkcount < 300000)
            begin
            dispclkcount = dispclkcount+1;
            dispclk = 0;
            end
        else 
            begin
            dispclk = 1;
            dispclkcount = 0;
            end 
    end
        
endmodule
