`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2018 13:08:20
// Design Name: 
// Module Name: mux
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


module Mux #(parameter DWIDTH = 32, AWIDTH = 4)

   (
    input sel_BIST,
    
    input rd_en_gen,
    input wr_en_gen,
    input rd_en,
    input wr_en,
    
    input [AWIDTH-1:0] wr_addr_gen,
    input [AWIDTH-1:0] rd_addr_gen,
    input [AWIDTH-1:0] wr_addr,
    input [AWIDTH-1:0] rd_addr,
    
    input [DWIDTH-1:0] data_in_gen,
    input [DWIDTH-1:0] data_in, 
    
    output reg [DWIDTH-1:0] DATA,
    output reg [AWIDTH-1:0] WR_ADDRESS,
    output reg [AWIDTH-1:0] RD_ADDRESS,
    output reg W,R
     
    );
    
always @ (*)
    begin
        if(sel_BIST)
            begin
                DATA = data_in_gen;
                WR_ADDRESS = wr_addr_gen;
                R = rd_en_gen;
                RD_ADDRESS = rd_addr_gen;
                W = wr_en_gen;
            end
        else
            begin
                DATA = data_in;
                WR_ADDRESS = wr_addr;
                R = rd_en;
                RD_ADDRESS = rd_addr;
                W = wr_en;
            end        

    end
endmodule
