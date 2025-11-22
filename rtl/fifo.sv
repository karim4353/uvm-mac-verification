module fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
)(
    input logic clk,
    input logic rst_n,
    input logic wr_en,
    input logic [WIDTH-1:0] wr_data,
    input logic rd_en,
    output logic [WIDTH-1:0] rd_data,
    output logic full,
    output logic empty,
    output logic [$clog2(DEPTH):0] used
);
    logic [WIDTH-1:0] mem [0:DEPTH-1];
    integer wptr, rptr;
    integer count;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr <= 0; rptr <= 0; count <= 0;
        end else begin
            if (wr_en && !full) begin
                mem[wptr] <= wr_data;
                wptr <= (wptr + 1) % DEPTH;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                rd_data <= mem[rptr];
                rptr <= (rptr + 1) % DEPTH;
                count <= count - 1;
            end
        end
    end
    assign full = (count == DEPTH);
    assign empty = (count == 0);
    assign used = count;
endmodule
