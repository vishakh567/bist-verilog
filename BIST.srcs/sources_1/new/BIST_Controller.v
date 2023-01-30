`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2018 14:23:57
// Design Name: 
// Module Name: BIST_Controller
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


module BIST_controller #(parameter DWIDTH = 32, AWIDTH = 4)
    (
     input clk,
     input rst,
     input TEST,
     
     output reg [1:0] state,
     output reg rd_en_gen,
     output reg wr_en_gen,
     output reg [AWIDTH-1:0] wr_addr_gen,
     output reg [AWIDTH-1:0] rd_addr_gen,
     output reg [DWIDTH-1:0] data_in_gen,
     output reg sel_BIST,check
    );


reg start;
localparam IDLE = 2'b00, BIST_MODE_READ_0 = 2'b01, BIST_MODE_WRITE_1 = 2'b10, BIST_MODE_READ_1 = 2'b11;

always @ (posedge clk) 
    begin
        if(rst)
            begin
                state <= IDLE;
                sel_BIST <= 0;
                wr_addr_gen <= 0;
                rd_addr_gen <= 0;
                data_in_gen <= 0;
                wr_en_gen <= 0;
                rd_en_gen <= 0;
                check <= 0;
                start <= 1;
            end
        else
            begin
                case(state)
                    IDLE : 
                    begin
                        $display("State = IDLE");
                        if(TEST && start)
                             begin
                                wr_en_gen <= 0;
                                rd_en_gen <= 1;
                                wr_addr_gen <= 0;
                                rd_addr_gen <= 0;
                                state <= BIST_MODE_READ_0;
                                sel_BIST <= 1;
                                $display("State = BIST_MODE_READ_0");
                             end
                        else
                             begin
                                 state <= IDLE;
                                 sel_BIST <= 0;
                                 wr_addr_gen <= 0;
                                 rd_addr_gen <= 0;
                                 data_in_gen <= 0;
                                 wr_en_gen <= 0;
                                 rd_en_gen <= 0;
                                 check <= 0;
                             end
                    end
                    
                    BIST_MODE_READ_0:
                    
                    begin
                        $display("rdaddr_gen=%x",rd_addr_gen);
                        check <= 1;
                        rd_addr_gen <= rd_addr_gen + 1;
                        if(rd_addr_gen == (2**AWIDTH)-1)
                            begin
                               state <= BIST_MODE_WRITE_1;
                               check <= 0;
                               wr_en_gen <= 1;
                               rd_en_gen <= 0;
                               wr_addr_gen <= 0;
                               rd_addr_gen <= 0;
                               data_in_gen <= {DWIDTH{1'b1}};
                               $display("State = BIST_MODE_WRITE_1");
                            end
                    end
                       
                    BIST_MODE_WRITE_1:
                    
                    begin
                       wr_addr_gen <= wr_addr_gen + 1;      
                       data_in_gen <= {DWIDTH{1'b1}};
                       $display("wraddr_gen=%x,data_gen=%x",wr_addr_gen,data_in_gen);
                       if(wr_addr_gen == (2**AWIDTH)-1)
                        begin
                            wr_en_gen <= 0;
                            rd_en_gen <= 1;
                            wr_addr_gen <= 0;
                            rd_addr_gen <= 0;
                            state <= BIST_MODE_READ_1;
                            $display("State = BIST_MODE_READ_1");
                        end    
                    end
  
                    BIST_MODE_READ_1 :
                    
                    begin
                      $display("rdaddr_gen=%x",rd_addr_gen);
                      check <= 1;
                      rd_addr_gen <= rd_addr_gen + 1;
                      if(rd_addr_gen == (2**AWIDTH)-1)
                            begin
                                state <= IDLE;
                                start <= 0;
                            end
                    end
                endcase
            end
    end
    
endmodule                    
