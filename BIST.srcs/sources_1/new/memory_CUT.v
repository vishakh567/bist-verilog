`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2018 14:08:57
// Design Name: 
// Module Name: memory_CUT
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


module Memory_CUT #(parameter DWIDTH = 32, AWIDTH = 4)  //default parameter

   (
    input clk,
    input rst,memrst,
    input wr_en,
    input [AWIDTH-1:0] wr_addr,
    input [DWIDTH-1:0] data_in,
    input rd_en,
    input [AWIDTH-1:0] rd_addr,
    output reg [DWIDTH-1:0] data_out
   );

reg [DWIDTH-1:0] mem [2**AWIDTH-1:0];
integer i;

always @ (posedge clk)
    begin
        if(rst)
            begin
                for(i=0 ; i<(2**AWIDTH) ;i=i+1)
                mem[i] <= 0;
            end
        else if(memrst)
            begin
            mem[3] <= 0;
            mem[6][4] <= 0;
            end
        else if(wr_en)
            mem[wr_addr] <= data_in;
    end

always @ (posedge clk)
    begin
        if(rd_en)
            data_out <= mem[rd_addr];
    end

endmodule
