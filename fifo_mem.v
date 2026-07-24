module fifo_mem
#(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 4)
(input wr_clk, 
input wr_en, 
input [DATA_WIDTH-1:0] wr_data, 
input [ADDR_WIDTH-1:0] wr_addr,
input rd_clk,
input rd_en,
input [ADDR_WIDTH-1:0] rd_addr,
output reg [DATA_WIDTH-1:0] rd_data 
);
reg [DATA_WIDTH-1:0] mem [0:(1 << ADDR_WIDTH)-1];

integer i;
initial begin
    rd_data = {DATA_WIDTH{1'b0}};
    for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
        mem[i] = {DATA_WIDTH{1'b0}};
    end
end
always @(posedge wr_clk) begin
    if(wr_en) begin
        mem[wr_addr] <= wr_data;
    end
end
always @(posedge rd_clk) begin
    if(rd_en) begin
        rd_data <= mem[rd_addr];
    end
end
endmodule