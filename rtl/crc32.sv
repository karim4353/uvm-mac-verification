module crc32(
    input logic clk,
    input logic rst_n,
    input logic valid_in,
    input logic [7:0] data_in,
    input logic last_in,
    output logic [31:0] crc_out,
    output logic crc_valid
);
    // Simple LFSR-like placeholder for CRC calculation (NOT a real CRC implementation)
    logic [31:0] crc;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            crc <= 32'hFFFFFFFF;
            crc_valid <= 0;
        end else begin
            if (valid_in) begin
                crc <= {crc[30:0], crc[31] ^ data_in[0]}; // toy mixing
                crc_valid <= last_in;
            end else begin
                crc_valid <= 0;
            end
        end
    end
    assign crc_out = crc;
endmodule
