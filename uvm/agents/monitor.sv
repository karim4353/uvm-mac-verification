package uvm_mac_pkg;
    import uvm_pkg::*;
    class mac_monitor extends uvm_component;
        `uvm_component_utils(mac_monitor)
        function new(string name, uvm_component parent); super.new(name,parent); endfunction
        virtual task run_phase(uvm_phase phase);
            `uvm_info("MON","Monitor running (placeholder)",UVM_LOW)
            // TODO: sample DUT signals via virtual interface
        endtask
    endclass
endpackage
