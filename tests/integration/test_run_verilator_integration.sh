#!/bin/bash
# Integration test that calls the quick demo which will use sample logs if Verilator is NOT present
set -e
./tools/run_quick_demo.sh
python3 python/parse_logs.py --input out/sim_logs/ --output out/parsed_failures.csv
