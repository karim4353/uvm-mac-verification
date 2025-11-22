# Architecture

- RTL: `rtl/` contains simplified MAC building blocks.
- UVM: `uvm/` contains a full UVM layout (env, agents, sequences, scoreboard).
- Verilator fallback: `verilator_fallback/` offers a cocotb-based smoke harness (not full UVM).
- Python: Orchestration, parsing, feature extraction, clustering and dashboard generation.
