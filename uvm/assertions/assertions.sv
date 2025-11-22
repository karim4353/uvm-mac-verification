// Simple SVA assertions to catch basic issues
module assertions(input logic clk, input logic rst_n, input logic rx_valid, input logic rx_last);
    // example: if rx_last asserted, rx_valid must be high at same cycle
    property last_requires_valid;
        @(posedge clk) disable iff (!rst_n) rx_last |-> rx_valid;
    endproperty
    assert property (last_requires_valid) else $error("SVA: rx_last without rx_valid");
endmodule
