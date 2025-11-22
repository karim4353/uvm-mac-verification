package uvm_mac_pkg;
    import uvm_pkg::*;
    class mac_scoreboard extends uvm_component;
        `uvm_component_utils(mac_scoreboard)
        function new(string name, uvm_component parent); super.new(name,parent); endfunction
        virtual function void write(packet p);
            `uvm_info("SCORE","Scoreboard compare placeholder",UVM_LOW)
        endfunction
    endclass
endpackage
