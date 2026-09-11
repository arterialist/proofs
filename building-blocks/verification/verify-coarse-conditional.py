#!/usr/bin/env python3
"""Verify the pinned conditional coarse-energy implication."""
from pathlib import Path
import argparse,hashlib,json,os,shutil,subprocess,time

here=Path(__file__).resolve().parent
root=here.parents[1]
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--lake',default='lake')
parser.add_argument('--log-dir',type=Path,default=here/'coarse-conditional-replay')
args=parser.parse_args()
lake=shutil.which(args.lake)
if lake is None: raise SystemExit('Pinned Lean 4.24.0 lake executable required')
lake=str(Path(lake).resolve())
env=dict(os.environ)
env['PATH']=str(Path(lake).parent)+os.pathsep+env.get('PATH','')
manifest=json.loads((here/'coarse-conditional-sources.json').read_text())
def check():
    for rel,expected in manifest.items():
        if hashlib.sha256((root/rel).read_bytes()).hexdigest()!=expected:
            raise SystemExit('Source hash mismatch: '+rel)
check()
args.log_dir.mkdir(parents=True,exist_ok=True)
results=[]
for name,cmd in [
    ('build',[lake,'build','BuildingBlocks.CoarsePrimitiveCriterion']),
    ('axioms',[lake,'env','lean','building-blocks/verification/CoarseConditionalAudit.lean'])]:
    started=time.monotonic()
    with (args.log_dir/(name+'.log')).open('w') as f:
        result=subprocess.run(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)
    results.append({'step':name,'exit_code':result.returncode,'seconds':time.monotonic()-started})
    (args.log_dir/'result.json').write_text(json.dumps(results,indent=2)+'\n')
    if result.returncode: raise SystemExit(result.returncode)
check()
print('Pinned source hashes, final-module build, and complete local axiom closure passed.')
