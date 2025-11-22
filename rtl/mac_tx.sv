module mac_tx(
    input logic clk,
    input logic rst_n,
    input logic start,
    input logic [7:0] payload [0:255],
    input int payload_len,
    output logic tx_valid,
    output logic [7:0] tx_byte,
    output logic tx_last
);
    // Simple TX state machine that streams payload and appends a fake CRC byte (0x00)
    int idx;
    typedef enum logic [1:0] {IDLE, STREAM, CRC} state_t;
    state_t state;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE; idx <= 0; tx_valid <= 0; tx_byte <= 0; tx_last <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx_valid <= 0; tx_last <= 0;
                    if (start) begin state <= STREAM; idx <= 0; end
                end
                STREAM: begin
                    if (idx < payload_len) begin
                        tx_valid <= 1; tx_byte <= payload[idx]; tx_last <= 0;
                        idx <= idx + 1;
                    end else begin
                        state <= CRC; tx_valid <= 1; tx_byte <= 8'h00; tx_last <= 1; // fake CRC
                    end
                end
                CRC: begin
                    tx_valid <= 0; tx_last <= 0; state <= IDLE;
                end
            endcase
        end
    end
endmodule
