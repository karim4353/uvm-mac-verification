#!/usr/bin/env python3
"""Parse simulation logs into structured CSV/JSON for ML."""
import argparse, os, csv, json, re
parser = argparse.ArgumentParser()
parser.add_argument('--input', default='out/sim_logs/')
parser.add_argument('--output', default='out/parsed_failures.csv')
args = parser.parse_args()
rows = []
for fn in sorted(os.listdir(args.input)):
    if not fn.endswith('.log'): continue
    path = os.path.join(args.input, fn)
    with open(path) as f:
        text = f.read()
    seed = re.search(r'SEED=(\d+)', text); seed = seed.group(1) if seed else ''
    test = re.search(r'TEST=(.+)', text); test = test.group(1).strip() if test else ''
    result = re.search(r'RESULT=(PASS|FAIL)', text); result = result.group(1) if result else 'UNKNOWN'
    msg = re.search(r'MSG=(.+)', text); msg = msg.group(1).strip() if msg else ''
    sva = re.search(r'SVA=\[(.*)\]', text); sva = sva.group(1).split(',') if sva and sva.group(1) else []
    rows.append({'file':fn,'seed':seed,'test':test,'result':result,'msg':msg,'sva':';'.join(sva)})
os.makedirs(os.path.dirname(args.output), exist_ok=True)
with open(args.output,'w',newline='') as csvf:
    w = csv.DictWriter(csvf, fieldnames=['file','seed','test','result','msg','sva'])
    w.writeheader()
    for r in rows: w.writerow(r)
print(f"Wrote {args.output} ({len(rows)} entries)")    
