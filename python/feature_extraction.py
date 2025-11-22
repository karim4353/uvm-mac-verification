#!/usr/bin/env python3
"""Convert parsed logs into ML features (text -> TF-IDF tokens, numeric fields)."""
import argparse, pandas as pd, numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
parser = argparse.ArgumentParser()
parser.add_argument('--input', default='out/parsed_failures.csv')
parser.add_argument('--output', default='out/features.npz')
args = parser.parse_args()
df = pd.read_csv(args.input)
msgs = df['msg'].fillna('')
vec = TfidfVectorizer(max_features=50, ngram_range=(1,2))
X_text = vec.fit_transform(msgs).toarray()
# numeric features: is_fail, msg_len
is_fail = (df['result']=='FAIL').astype(int).values.reshape(-1,1)
msg_len = df['msg'].fillna('').str.len().values.reshape(-1,1)
X = np.hstack([X_text, is_fail, msg_len])
import numpy as np, scipy.sparse as sps
np.savez(args.output, X=X, idx=df.index.values, cols=vec.get_feature_names_out())
print(f"Wrote features to {args.output}")    
