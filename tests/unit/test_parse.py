from python.parse_logs import *
def test_parse_sample(tmp_path, monkeypatch):
    # Create a sample log file
    p = tmp_path / "sim_0.log"
    p.write_text("SEED=123\nTEST=sample\nRESULT=FAIL\nMSG=CRC mismatch at packet 3\nSVA=[rx_last_requires_valid]\n")
    # Run parser
    import subprocess, os, csv
    out = tmp_path / "parsed.csv"
    subprocess.check_call(["python3","python/parse_logs.py","--input",str(tmp_path)+"/","--output",str(out)])
    assert out.exists()
