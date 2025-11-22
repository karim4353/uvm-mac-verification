#!/bin/bash
set -e
# Quick demo: create venv, install deps, run regression (quick) which creates sample logs, parse and triage
PY=python3
if [ -z "$(which ${PY})" ]; then
  echo "python3 not found"; exit 1
fi
echo "Creating virtualenv..."
${PY} -m venv .venv
source .venv/bin/activate
pip install -r python/requirements.txt
echo "Running quick regression to generate sample logs..."
python python/run_regression.py --mode quick --seeds 10
echo "Parsing logs..."
python python/parse_logs.py --input out/sim_logs/ --output out/parsed_failures.csv
echo "Running ML triage..."
python python/ml_triage.py --input out/parsed_failures.csv --output out/triage_summary.csv
echo "Generating dashboard..."
python python/dashboard.py --input out/triage_summary.csv --output out/dashboard.html
echo "Demo complete. Outputs in out/"
