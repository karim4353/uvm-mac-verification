module mac_top (
    input logic clk,
    input logic rst_n,
    // RX interface (external)
    input logic rx_valid,
    input logic [7:0] rx_data,
    input logic rx_last,
    // TX interface (external)
    input logic tx_start,
    input logic [7:0] tx_payload [0:255],
    input int tx_len,
    output logic tx_valid,
    output logic [7:0] tx_byte,
    output logic tx_last,
    // status
    output logic rx_packet_valid,
    output logic rx_byte,
    output logic rx_last_o,
    output logic rx_crc_ok
);
    mac_rx u_rx(.clk(clk), .rst_n(rst_n), .in_valid(rx_valid), .in_data(rx_data), .in_last(rx_last), .out_packet_valid(rx_packet_valid), .out_byte(rx_byte), .out_last(rx_last_o), .crc_ok(rx_crc_ok));
    mac_tx u_tx(.clk(clk), .rst_n(rst_n), .start(tx_start), .payload(tx_payload), .payload_len(tx_len), .tx_valid(tx_valid), .tx_byte(tx_byte), .tx_last(tx_last));
endmodule
