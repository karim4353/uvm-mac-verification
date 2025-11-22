def test_feature_runs(tmp_path):
    # Create a small parsed CSV
    p = tmp_path / "parsed.csv"
    p.write_text('file,seed,test,result,msg,sva\nfoo,1,t,FAIL,CRC mismatch,rx\n')
    import subprocess
    out = tmp_path / "features.npz"
    subprocess.check_call(["python3","python/feature_extraction.py","--input",str(p),"--output",str(out)])
    assert out.exists()
