#!/usr/bin/env python3
"""Build and audit the pinned finite Mertens-to-prime transfer."""
from pathlib import Path
import argparse,hashlib,json,os,shutil,subprocess,time

here=Path(__file__).resolve().parent
root=here.parents[1]
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--lake',default='lake')
parser.add_argument('--log-dir',type=Path,default=here/'mertens-transfer-replay')
args=parser.parse_args()
lake=shutil.which(args.lake)
if lake is None:raise SystemExit('Pinned Lean 4.24.0 lake executable required')
lake=str(Path(lake).resolve())
env=dict(os.environ);env['PATH']=str(Path(lake).parent)+os.pathsep+env.get('PATH','')
manifest=json.loads((here/'mertens-transfer-sources.json').read_text())
def check():
    for rel,h in manifest.items():
        if hashlib.sha256((root/rel).read_bytes()).hexdigest()!=h:
            raise SystemExit('Source hash mismatch: '+rel)
check()
args.log_dir.mkdir(parents=True,exist_ok=True)
results=[]
for name,cmd in [
    ('build',[lake,'build','BuildingBlocks.MertensPrimeTransfer']),
    ('axioms',[lake,'env','lean','formalization/verification/MertensTransferAudit.lean'])]:
    started=time.monotonic()
    with (args.log_dir/(name+'.log')).open('w') as f:
        r=subprocess.run(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)
    results.append({'step':name,'exit_code':r.returncode,'seconds':time.monotonic()-started})
    (args.log_dir/'result.json').write_text(json.dumps(results,indent=2)+'\n')
    if r.returncode:raise SystemExit(r.returncode)
check()
print('Pinned source hashes, finite-transfer build, and complete local axiom closure passed.')
