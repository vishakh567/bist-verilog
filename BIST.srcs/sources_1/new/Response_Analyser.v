`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2018 13:39:22
// Design Name: 
// Module Name: Respone Analyser
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


module Response_Analyser #(parameter DWIDTH = 32)

    (
     input clk,rst,check,
     input [1:0] state,
     input [DWIDTH-1:0] data_out_mem,
     
     output reg bist_status,
     output bist_check_valid

    );
    
reg flag;
assign bist_check_valid = check;

always @ (posedge clk) 
    begin
        if(rst)
            begin
                bist_status <= 0;
                flag <= 1;
            end
        else if ((check && flag) && (state == 2'b11 && ~&data_out_mem))
                    begin
                        bist_status <= 1; //Fault detected
                        flag <= 0;
                    end
                    
                $display("bist_status=%b",bist_status);
                $display("dataout_mem=%x",data_out_mem);
            
        end
        
endmodule
