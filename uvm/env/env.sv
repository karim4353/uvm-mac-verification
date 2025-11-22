package uvm_mac_pkg;
    import uvm_pkg::*;
    // Minimal env skeleton
    class mac_env extends uvm_env;
        `uvm_component_utils(mac_env)
        function new(string name, uvm_component parent);
            super.new(name,parent);
        endfunction
        virtual function void build_phase(uvm_phase phase);
            `uvm_info("ENV","Build phase",UVM_LOW)
        endfunction
        virtual function void connect_phase(uvm_phase phase);
        endfunction
    endclass
endpackage : uvm_mac_pkg
