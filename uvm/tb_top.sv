`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_mac_pkg.svh"
module tb_top;
    logic clk = 0;
    logic rst_n = 0;
    // DUT interfaces
    logic rx_valid; logic [7:0] rx_data; logic rx_last;
    logic tx_start; logic [7:0] tx_payload [0:255]; int tx_len;
    logic tx_valid; logic [7:0] tx_byte; logic tx_last;
    logic rx_packet_valid; logic rx_byte; logic rx_last_o; logic rx_crc_ok;

    // Clock generation
    always #5 clk = ~clk;

    // DUT instantiation
    mac_top dut(.clk(clk), .rst_n(rst_n),
                .rx_valid(rx_valid), .rx_data(rx_data), .rx_last(rx_last),
                .tx_start(tx_start), .tx_payload(tx_payload), .tx_len(tx_len),
                .tx_valid(tx_valid), .tx_byte(tx_byte), .tx_last(tx_last),
                .rx_packet_valid(rx_packet_valid), .rx_byte(rx_byte), .rx_last_o(rx_last_o), .rx_crc_ok(rx_crc_ok));

    initial begin
        // Simple reset
        rst_n = 0; #20; rst_n = 1;
        // Start UVM
        `uvm_info("TB","Starting UVM test",UVM_MEDIUM)
        run_test("basic_test");
    end
endmodule
