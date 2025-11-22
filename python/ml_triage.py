#!/usr/bin/env python3
"""Clustering pipeline to triage failures."""
import argparse, numpy as np, pandas as pd
from sklearn.cluster import DBSCAN, KMeans
parser = argparse.ArgumentParser()
parser.add_argument('--input', default='out/parsed_failures.csv')
parser.add_argument('--output', default='out/triage_summary.csv')
args = parser.parse_args()
df = pd.read_csv(args.input)
msgs = df['msg'].fillna('').tolist()
# Naive token features (bag of words)
from sklearn.feature_extraction.text import CountVectorizer
v = CountVectorizer(max_features=20)
X = v.fit_transform(msgs).toarray()
if len(X) == 0:
    print("No entries to cluster; writing empty output.")
    df.to_csv(args.output, index=False)
else:
    # Try KMeans with small k then DBSCAN fallback
    k = min(3, max(1, len(X)//2))
    km = KMeans(n_clusters=k, random_state=0).fit(X)
    df['cluster'] = km.labels_
    # Simple heuristics for labeling clusters
    def label_cluster(messages):
        txt = ' '.join(messages).lower()
        if 'crc' in txt: return 'CRC-related'
        if 'fifo' in txt: return 'FIFO-related'
        if 'assert' in txt or 'sva' in txt: return 'Assertion-related'
        if 'scoreboard' in txt: return 'Scoreboard'
        return 'Other'
    summary_rows = []
    for c in sorted(df['cluster'].unique()):
        members = df[df['cluster']==c]
        rep = members['msg'].mode().iloc[0] if not members['msg'].mode().empty else ''
        label = label_cluster(members['msg'].tolist())
        summary_rows.append({'cluster':c,'label':label,'count':len(members),'representative':rep})
    out = pd.DataFrame(summary_rows)
    out.to_csv(args.output, index=False)
    df.to_csv('out/parsed_with_clusters.csv', index=False)
    print(f"Wrote triage summary to {args.output}")    
