package uvm_mac_pkg;
    import uvm_pkg::*;
    class mac_agent extends uvm_component;
        `uvm_component_utils(mac_agent)
        mac_driver driver;
        mac_monitor monitor;
        function new(string name, uvm_component parent); super.new(name,parent); endfunction
        virtual function void build_phase(uvm_phase phase);
            driver = mac_driver::type_id::create("driver", this);
            monitor = mac_monitor::type_id::create("monitor", this);
        endfunction
    endclass
endpackage
