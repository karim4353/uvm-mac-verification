package uvm_mac_pkg;
    import uvm_pkg::*;
    class mac_driver extends uvm_driver #(mac_seq_item);
        `uvm_component_utils(mac_driver)
        virtual task run_phase(uvm_phase phase);
            mac_seq_item it;
            forever begin
                seq_item_port.get_next_item(it);
                // TODO: drive to interface -- vendor simulation required to connect virtual interfaces
                `uvm_info("DRIVER","Got seq_item (placeholder drive)",UVM_LOW)
                seq_item_port.item_done();
            end
        endtask
    endclass
endpackage
