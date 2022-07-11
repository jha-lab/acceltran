module fifo
(
    clk,
    reset,
    data_in,
    rd_en,
    wr_en,
    empty,
    full,
    data_out
);

parameter IL = 4, FL = 16;
parameter FIFO_DEPTH = 32;
parameter IN_BUS_WIDTH = IL + FL;
parameter FIFO_CNT_WIDTH = $clog2(FIFO_DEPTH);

input clk;
input reset;
input [IN_BUS_WIDTH-1:0] data_in;
input rd_en;
input wr_en;
output logic empty;
output logic full;
output logic [IN_BUS_WIDTH-1:0] data_out;
 
logic [FIFO_DEPTH-1:0] [IN_BUS_WIDTH-1:0] buff_mem;
logic [FIFO_CNT_WIDTH-1:0] rd_ptr, wr_ptr;
 
 
 
always@(posedge clk) begin
    if(reset) begin
        data_out <= 0;
        buff_mem <= 0;
        empty <= 1;
        full <= 0;
        rd_ptr <= 0;
        wr_ptr <= 0;
    end
    else begin
        if(rd_en && !empty ) begin
            data_out <= buff_mem[rd_ptr][IN_BUS_WIDTH-1:0];
            rd_ptr <= rd_ptr + 1;
            if (full) begin
                full <= 0;
            end
            if (rd_ptr + 1 == wr_ptr) begin
                empty <= 1;
            end
        end
        else if(wr_en && !full) begin
            buff_mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            if (empty) begin
                empty <= 0;
            end
            if (rd_ptr == wr_ptr + 1) begin
                full <= 1;
            end

	    data_out <= 0;
        end
	else begin
	    data_out <= 0;
	end
    end
end
 
 
endmodule
