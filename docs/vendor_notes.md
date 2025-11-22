# Vendor simulator notes (Questa/Xcelium/VCS)

This file explains how to run the UVM testbench with a commercial simulator.

Example (QuestaSim):
```bash
# TODO: Ensure Questa is licensed on your host
vlib work
vlog -sv +acc rtl/*.sv uvm/*.sv
vsim -c -do "run -all; exit" tb_top +UVM_TESTNAME=basic_test +UVM_SEED=12345
```

Collect logs & coverage:
- Use simulator-specific switches to dump functional coverage and test logs (`-coverage`, `-cm` etc).
- Export UVM report and seeds to a file for downstream parsing.

TODO: Add Xcelium and VCS examples depending on site licenses.
