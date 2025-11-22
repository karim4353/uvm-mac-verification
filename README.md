# AI-Assisted UVM Verification Environment for a High-Speed FPGA IP (Ethernet-like MAC)

Overview
--------
This repository is a *starter kit* that contains:
- A small, synthetic SystemVerilog RTL for an Ethernet-like MAC (tx/rx, CRC32, FIFO).
- A complete UVM testbench layout (env, agent, driver, monitor, scoreboard, sequences, coverage, SVA).
- An **open-source fallback** using Verilator + cocotb (small tests) and scripts to run smoke flows.
- Python tooling to orchestrate runs, parse logs, extract features and run ML triage (clustering).
- A demo script that runs a quick end-to-end flow (uses Verilator fallback or sample logs).

Quickstart (5-10 minutes)
-------------------------
Unzip and run the quick demo (this will try the Verilator fallback, but will use generated sample logs if Verilator is not available):
```bash
unzip uvm-mac-verification-starter.zip -d uvm-mac-verification
cd uvm-mac-verification
chmod +x tools/run_quick_demo.sh
./tools/run_quick_demo.sh
```

This produces `out/parsed_failures.csv`, `out/triage_summary.csv`, and `out/dashboard.html`.

Vendor tools notes
------------------
- The UVM environment is vendor-run ready (Questa, Xcelium, VCS). See `uvm/scripts/run_quick_sim.sh` and `docs/vendor_notes.md` for example command lines.
- **TODO**: Licensed simulators are required to run full UVM tests and collect native UVM functional coverage. Use the Verilator fallback for a lightweight, open-source demo (note: Verilator + cocotb does NOT implement UVM).

Repository layout
-----------------
See `package_manifest.txt` for a concise manifest.

License
-------
MIT. See `LICENSE`.


