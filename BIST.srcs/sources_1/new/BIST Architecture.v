`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2018 14:47:43
// Design Name: 
// Module Name: BIST_Architecture
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

module MBIST_Architecture #(parameter DWIDTH = 32, AWIDTH = 4)
   (
    input clk,
    input rst,memrst,
    input TEST,
    input rd_en,
    input wr_en,
    input [AWIDTH-1:0] wr_addr,
    input [AWIDTH-1:0] rd_addr,
    input [DWIDTH-1:0] data_in,
    
    output bist_status,
    output bist_check_valid,
    output [7:0] control,
    output [7:0] Z
    );
    
//Display
wire sysclk, dispclk,bist_status_temp;

//Controller
wire rd_en_gen,wr_en_gen,sel_BIST,check;
wire [AWIDTH-1:0] wr_addr_gen,rd_addr_gen;
wire [DWIDTH-1:0] data_in_gen;

//Mux
wire [DWIDTH-1:0] DATA;
wire [AWIDTH-1:0] WR_ADDRESS,RD_ADDRESS;
wire W,R;
wire [1:0] state;
//Memory
wire [DWIDTH-1:0] MEMDATA_OUT;
 
CLK_Generator CLK_GENERATOR (.clk(clk),.dispclk(dispclk),.sysclk(sysclk));

Seven_Segment DISPLAY (.dispclk(dispclk),.rst(rst),.state(state),.bist_status(bist_status_temp),.control(control),
                   .Z(Z));
                   
BIST_controller #(.DWIDTH(DWIDTH), .AWIDTH(AWIDTH))
    
    CONTROLLER (.clk(sysclk),.rst(rst),.TEST(TEST),.state(state),.rd_en_gen(rd_en_gen),.wr_en_gen(wr_en_gen),
               .wr_addr_gen(wr_addr_gen),.rd_addr_gen(rd_addr_gen),.data_in_gen(data_in_gen),
               .sel_BIST(sel_BIST),.check(check));

Mux #(.DWIDTH(DWIDTH), .AWIDTH(AWIDTH))

    SELECT_NORMAL_OR_BIST (.sel_BIST(sel_BIST),.rd_en_gen(rd_en_gen),.wr_en_gen(wr_en_gen),
                          .rd_en(rd_en),.wr_en(wr_en),.wr_addr_gen(wr_addr_gen),.rd_addr_gen(rd_addr_gen),
                          .wr_addr(wr_addr),.rd_addr(rd_addr),.data_in_gen(data_in_gen),
                          .data_in(data_in),.DATA(DATA),.WR_ADDRESS(WR_ADDRESS),
                          .RD_ADDRESS(RD_ADDRESS),.W(W),.R(R));

Memory_CUT #(.DWIDTH(DWIDTH), .AWIDTH(AWIDTH))

    MEMORY_UNDER_TEST (.clk(sysclk),.rst(rst),.memrst(memrst),.wr_en(W),.wr_addr(WR_ADDRESS),.data_in(DATA),
                       .rd_en(R),.rd_addr(RD_ADDRESS),.data_out(MEMDATA_OUT));

Response_Analyser #(.DWIDTH(DWIDTH))

    COMPARATOR (.clk(sysclk),.rst(rst),.check(check),.state(state),.data_out_mem(MEMDATA_OUT),.bist_status(bist_status_temp),
               .bist_check_valid(bist_check_valid));

assign bist_status = bist_status_temp;
 
endmodule
