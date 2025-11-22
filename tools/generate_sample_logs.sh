#!/bin/bash
mkdir -p out/sim_logs
python3 - <<'PY'
import os,random
os.makedirs('out/sim_logs',exist_ok=True)
for i in range(10):
    seed=random.randint(1,1000000)
    with open(f'out/sim_logs/sim_{i}_seed_{seed}.log','w') as f:
        f.write(f'SEED={seed}\nTEST=sample_{i}\n')
        if random.random()<0.4:
            f.write('RESULT=FAIL\n')
            f.write('MSG=CRC mismatch at packet 3\n')
            f.write('SVA=[rx_last_requires_valid]\n')
        else:
            f.write('RESULT=PASS\nMSG=OK\n')
print('Sample logs generated in out/sim_logs') 
PY
