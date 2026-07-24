module rptr_empty #(parameter ADDR_WIDTH = 4)
(input rd_clk,
 input rd_rst_n,
 input rd_en,
 input [ADDR_WIDTH:0] wr_ptr_gray_sync,
 
 output [ADDR_WIDTH-1:0] rd_addr,
 output reg [ADDR_WIDTH:0] rd_gray,
 output reg rd_empty);
 
 reg [ADDR_WIDTH:0] rd_ptr_bin;
 reg [ADDR_WIDTH:0] rd_ptr_bin_next;
 reg [ADDR_WIDTH:0] rd_ptr_gray_next;
 reg rd_empty_next;
assign rd_addr = rd_ptr_bin[ADDR_WIDTH-1:0];

always @(*) begin
    if(rd_en && !rd_empty) begin
        rd_ptr_bin_next = rd_ptr_bin + 1;
    end
    else begin
        rd_ptr_bin_next = rd_ptr_bin;
    end
    rd_ptr_gray_next = rd_ptr_bin_next ^ (rd_ptr_bin_next >> 1);
    rd_empty_next = (rd_ptr_gray_next == wr_ptr_gray_sync);
end

always @(posedge rd_clk or negedge rd_rst_n) begin
    if(!rd_rst_n) begin
        rd_ptr_bin <= 0;
        rd_empty <= 1'b1;
        rd_gray <= 0;
    end
    else begin
        rd_ptr_bin <= rd_ptr_bin_next;
        rd_gray <= rd_ptr_gray_next;
        rd_empty <= rd_empty_next;
    end
end
endmodule