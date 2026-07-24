`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 11:15:57 PM
// Design Name: 
// Module Name: sync_w2r
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


module sync_w2r#(parameter ADDR_WIDTH = 4)(input rd_clk,
                                           input rd_rst_n,
                                           input [ADDR_WIDTH:0] wr_gray,
                                           output reg [ADDR_WIDTH:0] wr_ptr_gray_sync

    );
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync1;
    always @(posedge rd_clk or negedge rd_rst_n) begin
        if(!rd_rst_n) begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync <= 0;
        end
        else begin
            wr_ptr_gray_sync1 <= wr_gray;
            wr_ptr_gray_sync <= wr_ptr_gray_sync1;
        end
    end
    
endmodule
