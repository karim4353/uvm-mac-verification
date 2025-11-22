package uvm_mac_pkg;
    import uvm_pkg::*;
    class basic_seq extends uvm_sequence #(mac_seq_item);
        `uvm_object_utils(basic_seq)
        virtual task body();
            mac_seq_item it = mac_seq_item::type_id::create("it");
            it.len = 8;
            it.data = new[it.len];
            foreach(it.data[i]) it.data[i] = $urandom_range(0,255);
            `uvm_info("SEQ","Basic sequence launched",UVM_LOW)
            start_item(it); finish_item(it);
        endtask
    endclass
endpackage
