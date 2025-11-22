package uvm_mac_pkg;
    import uvm_pkg::*;
    class mac_seq_item extends uvm_sequence_item;
        rand bit [7:0] data[];
        rand int unsigned len;
        function new(string name="mac_seq_item");
            super.new(name);
        endfunction
        `uvm_object_utils(mac_seq_item)
    endclass
endpackage
