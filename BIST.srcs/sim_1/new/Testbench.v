`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2018 18:09:20
// Design Name: 
// Module Name: Testbench
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


module Testbench;
parameter DWIDTH=32, AWIDTH=4;
reg clk, rst, TEST, rd_en, wr_en;

reg [AWIDTH-1:0] wr_addr, rd_addr;
reg [DWIDTH-1:0] data_in;
reg memrst;    
wire bist_status, bist_check_valid;

MBIST_Architecture UUT (clk, rst, memrst, TEST, rd_en, wr_en, wr_addr,
                              rd_addr, data_in, bist_status, bist_check_valid);

initial
    begin
        clk = 0;
        forever #10 clk = ~clk;
    end

initial
    begin
        rst = 0;
        #10
        rst = 1;
        #20
        rst = 0; TEST = 1;
        #1000
        rst = 1;
        #20
        TEST = 1;
        #380
        memrst = 1;
        #1000
        $finish;
            
    end
endmodule
