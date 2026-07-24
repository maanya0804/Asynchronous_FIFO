`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 02:26:21 AM
// Design Name: 
// Module Name: async_fifo
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


module async_fifo#(parameter DATA_WIDTH = 8, 
                   parameter ADDR_WIDTH = 4)(input wr_clk,
                                             input rd_clk,
                                             input wr_en,
                                             input rd_en,
                                             input wr_rst_n,
                                             input rd_rst_n,
                                             input [DATA_WIDTH-1:0]wr_data,
                                             
                                             output wr_full,
                                             output rd_empty,
                                             output [DATA_WIDTH-1:0]rd_data
                                             

    );
    wire [ADDR_WIDTH-1:0] wr_addr;
    wire [ADDR_WIDTH-1:0] rd_addr;
    wire [ADDR_WIDTH:0] wr_gray;
    wire [ADDR_WIDTH:0] rd_gray;
    wire [ADDR_WIDTH:0] wr_ptr_gray_sync;
    wire [ADDR_WIDTH:0] rd_ptr_gray_sync;
    
    fifo_mem #(.DATA_WIDTH(DATA_WIDTH),
               .ADDR_WIDTH(ADDR_WIDTH)) fifo_mem_inst(
                .wr_clk(wr_clk),
                .wr_en(wr_en),
                .wr_data(wr_data),
                .wr_addr(wr_addr),
                .rd_clk(rd_clk),
                .rd_en(rd_en),
                .rd_addr(rd_addr),
                .rd_data(rd_data)
                );
    wptr_full #(.ADDR_WIDTH(ADDR_WIDTH)) wptr_full_inst(
                .wr_clk(wr_clk),
                .wr_rst_n(wr_rst_n),
                .wr_en(wr_en),
                .rd_ptr_gray_sync(rd_ptr_gray_sync),
                .wr_full(wr_full),
                .wr_addr(wr_addr),
                .wr_gray(wr_gray)
                );
    rptr_empty #(.ADDR_WIDTH(ADDR_WIDTH)) rptr_empty_inst(
                .rd_clk(rd_clk),
                .rd_rst_n(rd_rst_n),
                .rd_en(rd_en),
                .wr_ptr_gray_sync(wr_ptr_gray_sync),
                .rd_addr(rd_addr),
                .rd_gray(rd_gray),
                .rd_empty(rd_empty)
                );
    sync_r2w #(.ADDR_WIDTH(ADDR_WIDTH)) sync_r2w_inst(
               .wr_clk(wr_clk),
               .wr_rst_n(wr_rst_n),
               .rd_gray(rd_gray),
               .rd_ptr_gray_sync(rd_ptr_gray_sync));
    sync_w2r #(.ADDR_WIDTH(ADDR_WIDTH)) sync_w2r_inst(
               .rd_clk(rd_clk),
               .rd_rst_n(rd_rst_n),
               .wr_gray(wr_gray),
               .wr_ptr_gray_sync(wr_ptr_gray_sync));
endmodule
