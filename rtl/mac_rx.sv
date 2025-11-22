module mac_rx(
    input logic clk,
    input logic rst_n,
    input logic in_valid,
    input logic [7:0] in_data,
    input logic in_last,
    output logic out_packet_valid,
    output logic [7:0] out_byte,
    output logic out_last,
    output logic crc_ok
);
    // Minimal RX datapath: passes bytes through, checks CRC via crc32 module
    logic [31:0] crc;
    logic crc_valid;
    crc32 u_crc(.clk(clk), .rst_n(rst_n), .valid_in(in_valid), .data_in(in_data), .last_in(in_last), .crc_out(crc), .crc_valid(crc_valid));
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_packet_valid <= 0;
            out_byte <= 0;
            out_last <= 0;
            crc_ok <= 0;
        end else begin
            if (in_valid) begin
                out_packet_valid <= 1;
                out_byte <= in_data;
                out_last <= in_last;
                if (crc_valid) begin
                    // toy check: accept if crc LSB == 0
                    crc_ok <= (crc[0] == 0);
                end
            end else begin
                out_packet_valid <= 0;
                out_last <= 0;
            end
        end
    end
endmodule
