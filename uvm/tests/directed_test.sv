`timescale 1ns/1ps
module directed_test;
    initial begin
        // TODO: run a directed sequence -- vendor simulation required for full UVM
        $display("Directed test placeholder - run under Questa/Xcelium for UVM sequences");
        #10 $finish;
    end
endmodule
