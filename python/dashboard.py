#!/usr/bin/env python3
"""Generate a minimal Plotly HTML dashboard summarizing clusters."""
import argparse, pandas as pd, plotly.express as px, os
parser = argparse.ArgumentParser()
parser.add_argument('--input', default='out/triage_summary.csv')
parser.add_argument('--output', default='out/dashboard.html')
args = parser.parse_args()
if not os.path.exists(args.input):
    print('No triage_summary.csv found; creating a placeholder dashboard.')
    html = '<html><body><h1>Placeholder dashboard</h1><p>No data.</p></body></html>'
    with open(args.output,'w') as f: f.write(html)
else:
    df = pd.read_csv(args.input)
    if df.empty:
        html = '<html><body><h1>No clusters</h1></body></html>'
        with open(args.output,'w') as f: f.write(html)
    else:
        fig = px.bar(df, x='cluster', y='count', text='label', title='Failure clusters')
        fig.write_html(args.output)
print(f"Dashboard written to {args.output}")    
