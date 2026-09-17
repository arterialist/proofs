"""Actual coherent-matching witnesses and rational primal-dual certificates.
Run with Python, NumPy and SciPy. Floating assignment/LP calculations propose
witnesses only. Integer constraints and rational error bounds certify every
reported interval. No floating-point optimizer is trusted as a proof oracle.
The shared elementary observable/graph oracle is matching_three_step.py.
"""
from fractions import Fraction as F
import math
import numpy as np
from scipy.optimize import linear_sum_assignment,linprog
from scipy.sparse import csr_matrix,coo_matrix
from scipy.sparse.csgraph import maximum_bipartite_matching
import matching_three_step as oracle

def complete_cost(vals,ne):
 result=0
 for sgn in [1,-1]:
  entries=sorted((sgn*v,1 if i<ne else -1) for i,v in enumerate(vals) if sgn*v>0)
  count=sum(mu for w,mu in entries);last=0
  for w,mu in entries:
   result+=abs(count)*(w-last);last=w;count-=mu
 return result

X=128;N=2*X-1;S=oracle.S;Q=10**12
H,g=oracle.observables(N)
mid=[(l+u)//2 for l,u in H]
rad=[max(v-l,u-v) for v,(l,u) in zip(mid,H)]
e,o,edges=oracle.graph(N);labels=e+o;ne=len(e);no=len(o);nv=len(labels)
index={n:i for i,n in enumerate(labels)}
row=[[mid[j//n] for n in labels] for j in range(X,2*X)]
prefix=[[0]*nv]
for rr in row:prefix.append([a+b for a,b in zip(prefix[-1],rr)])
total=prefix[-1]
vrad=[X*max(rad[:2*X//n+1]) for n in labels]
vals=np.array(prefix,dtype=float)/S
suffix=np.array(total,dtype=float)/S-vals

def absints(a,b):
 a=F(a);b=F(b)
 if a*b>=0:return (abs(a)+abs(b))/2
 return (a*a+b*b)/(2*abs(b-a))
def w_exact(i):
 return sum((absints(prefix[k][i],prefix[k+1][i])+absints(total[i]-prefix[k][i],total[i]-prefix[k+1][i]) for k in range(X)),F(0))/S
weights=[w_exact(i) for i in range(nv)]
def absfloat(z):
 left=z[:-1];right=z[1:]
 normal=(np.abs(left)+np.abs(right))/2
 cross=np.divide(left*left+right*right,2*np.abs(right-left),out=normal.copy(),where=(left*right<0))
 return np.where(left*right<0,cross,normal).sum(axis=0)
wf=absfloat(vals)+absfloat(suffix)
gains=np.empty((ne,no))
scores={}
for i in range(ne):
 delta=vals[:,i,None]-vals[:,ne:]
 ds=suffix[:,i,None]-suffix[:,ne:]
 gains[i]=wf[i]+wf[ne:]-absfloat(delta)-absfloat(ds)
 for j in range(no):
  scores[i,j]=max(max(abs(v[i]-v[ne+j]),abs(total[i]-total[ne+j]-v[i]+v[ne+j])) for v in prefix)
A=np.zeros((ne,no),dtype=np.int64)
for i,j in edges:A[i,j]=1
A3=(A@A.T@A)>0
A3|=A.astype(bool)

def threshold(base,tau):
 out=[]
 for i,j in base:
  err=vrad[i]+vrad[ne+j]
  value=scores[i,j]
  if value+err<=tau*S:out.append((i,j))
  else:assert value-err>tau*S,('ambiguous threshold',i,j)
 return out

def integrate_fixed(pairs):
 used={i for i,j in pairs}|{ne+j for i,j in pairs}
 unmatched=[i for i in range(nv) if i not in used]
 energylo=energyhi=F(0);costfirst=F(0);pieces=0
 gamma=F(g[0]+g[1],2*S);gr=F(g[1]-g[0],2*S)
 for cell in range(X):
  for direction in (0,1):
   if direction==0:
    aa=prefix[cell];bb=row[cell]
    corr=[(2*gamma+F(1,2))*cell,2*gamma,F(1,2)]
   else:
    aa=[total[i]-prefix[cell][i] for i in range(nv)];bb=[-v for v in row[cell]]
    corr=[(2*gamma+F(1,2))*(X-cell),-2*gamma,F(-1,2)]
   lines=[(aa[i],bb[i]) for i in unmatched]+[(aa[i]-aa[ne+j],bb[i]-bb[ne+j]) for i,j in pairs]
   roots={F(0),F(1)}
   for a,b in lines:
    if b and 0<-F(a,b)<1:roots.add(-F(a,b))
   roots=sorted(roots)
   for l,r in zip(roots,roots[1:]):
    t=(l+r)/2
    signs=[1 if a+b*t>=0 else -1 for a,b in lines]
    cc=[F(sum(z*a for z,(a,b) in zip(signs,lines)),S),F(sum(z*b for z,(a,b) in zip(signs,lines)),S)]
    costfirst+=cc[0]*(r-l)+cc[1]*(r*r-l*l)/2
    poly=[cc[0]+corr[0],cc[1]+corr[1],corr[2]]
    square=[sum(poly[i]*poly[k-i] for i in range(max(0,k-2),min(k,2)+1)) for k in range(5)]
    value=sum(square[k]*(r**(k+1)-l**(k+1))/F(k+1) for k in range(5))
    lo=value*Q;flo=lo.numerator//lo.denominator
    energylo+=F(flo,Q);energyhi+=F(flo+1,Q);pieces+=1
 # Uniform true-observable perturbation, valid despite shifted zero crossings.
 E=F(sum(vrad),S)+2*X*gr
 B=F(X*sum(max(abs(v) for v in mid[:2*X//n+1]) for n in labels),S)+(2*gamma+F(1,2))*X
 error=2*X*(2*B*E+E*E)
 return {'raw_energy_lower':str(energylo-error),'raw_energy_upper':str(energyhi+error),
 'normalized_energy_enclosure':[float((energylo-error)/X**2),float((energyhi+error)/X**2)],
 'first_moment_midpoint':float(costfirst),'first_moment_radius':str(F(2*X*sum(vrad),S)),
 'unmatched_first_moment_midpoint':float(sum(weights[i] for i in unmatched)),
 'unmatched_first_moment_radius':str(F(2*X*sum(vrad[i] for i in unmatched),S)),
 'large_unmatched_first_moment_midpoint':float(sum(weights[i] for i in unmatched if labels[i]>math.isqrt(X))),
 'unmatched_labels':[labels[i] for i in unmatched],'integration_pieces':pieces,'observable_energy_error':str(error)}

def point_data(base,t):
 k=t-X;v=prefix[k]
 w=[abs(z) for z in v]
 gg=np.zeros((ne,no+ne))
 for i,j in base:gg[i,j]=(w[i]+w[ne+j]-abs(v[i]-v[ne+j]))/S
 rr,cc=linear_sum_assignment(gg,maximize=True)
 pairs=[(int(i),int(j)) for i,j in zip(rr,cc) if j<no and gg[i,j]>0]
 assert set(pairs)<=set(base)
 assert len({i for i,j in pairs})==len({j for i,j in pairs})==len(pairs)
 cost=sum(w)-sum(w[i]+w[ne+j]-abs(v[i]-v[ne+j]) for i,j in pairs)
 c0=complete_cost(v,ne)
 err=sum(vrad)
 gains_exact=[w[i]+w[ne+j]-abs(v[i]-v[ne+j]) for i,j in base]
 rows=np.repeat(np.arange(len(base)),2)
 cols=np.array([z for i,j in base for z in (i,ne+j)])
 matrix=coo_matrix((-np.ones(len(rows)),(rows,cols)),shape=(len(base),nv)).tocsr()
 lp=linprog(np.ones(nv),A_ub=matrix,b_ub=-np.array([x/S for x in gains_exact]),bounds=(0,None),method='highs')
 assert lp.success
 cover=[max(0,int(F(str(float(y)))*S)) for y in lp.x]
 violation=max([0]+[gain-cover[i]-cover[ne+j] for gain,(i,j) in zip(gains_exact,base)])
 cover=[v+(violation+1)//2 for v in cover]
 assert all(cover[i]+cover[ne+j]>=gain for gain,(i,j) in zip(gains_exact,base))
 lower=sum(w)-sum(cover)
 assert lower<=cost
 return {'t':t,'C0_enclosure':[float(F(c0-err,S)),float(F(c0+err,S))],
 'C0_exact_enclosure':[str(F(c0-err,S)),str(F(c0+err,S))],
 'optimal_cost_exact_enclosure':[str(F(lower-err,S)),str(F(cost+err,S))],
 'graph_penalty_exact_enclosure':[str(F(lower-c0-2*err,S)),str(F(cost-c0+2*err,S))],
 'optimal_cost_enclosure':[float(F(lower-err,S)),float(F(cost+err,S))],
 'graph_penalty_enclosure':[float(F(lower-c0-2*err,S)),float(F(cost-c0+2*err,S))],
 'exact_repaired_dual_cover':list(map(str,cover)),
 'feasible_cost_enclosure':[float(F(cost-err,S)),float(F(cost+err,S))],
 'feasible_cost_minus_C0_midpoint':float(F(cost-c0,S))}

full3=[(int(i),int(j)) for i,j in zip(*np.where(A3))]
configs=[('full',edges),('observable_cap_1',threshold(edges,1)),('observable_cap_2',threshold(edges,2)),
 ('observable_cap_4',threshold(edges,4)),('three_step_cap_1',threshold(full3,1)),('three_step_full',full3)]
results=[]
def path_witness(i,j):
 if A[i,j]:return [e[i],o[j]]
 for j1 in np.where(A[i])[0]:
  for i2 in np.where(A[:,j1])[0]:
   if A[i2,j]:return [e[i],o[int(j1)],e[int(i2)],o[j]]
 raise AssertionError('Missing three-step path')
for name,base in configs:
 mat=np.zeros((ne,no+ne))
 for i,j in base:mat[i,j]=gains[i,j]
 rr,cc=linear_sum_assignment(mat,maximize=True)
 pairs=[(int(i),int(j)) for i,j in zip(rr,cc) if j<no and mat[i,j]>0]
 assert set(pairs)<=set(base)
 assert len({i for i,j in pairs})==len({j for i,j in pairs})==len(pairs)
 adj=np.zeros((ne,no),dtype=int)
 for i,j in base:adj[i,j]=1
 cardinal_matching=maximum_bipartite_matching(csr_matrix(adj),perm_type='column')
 cardinality=int(sum(cardinal_matching>=0))
 inverse={int(j):i for i,j in enumerate(cardinal_matching) if j>=0}
 assert len(inverse)==cardinality
 assert all(adj[i,j] for j,i in inverse.items())
 reached_left={i for i,j in enumerate(cardinal_matching) if j<0};reached_right=set();queue=list(reached_left)
 for i in queue:
  for j in np.where(adj[i])[0]:
   j=int(j);reached_right.add(j)
   assert j in inverse,'An augmenting path would refute maximality'
   if inverse[j] not in reached_left:reached_left.add(inverse[j]);queue.append(inverse[j])
 cover_left=set(range(ne))-reached_left
 assert len(cover_left)+len(reached_right)==cardinality
 assert all(i in cover_left or j in reached_right for i,j in base)
 deg=np.r_[adj.sum(axis=1),adj.sum(axis=0)]
 isolated=[i for i in range(nv) if deg[i]==0 and labels[i]>math.isqrt(X)]
 rec={'name':name,'edges':len(base),'matching':[[e[i],o[j]] for i,j in pairs],
 'matching_path_witnesses':[path_witness(i,j) for i,j in pairs],
 'maximum_cardinality':cardinality,'unmatched_cardinality_deficit':nv-2*cardinality,
 'cardinality_cover_even':[e[i] for i in sorted(cover_left)],'cardinality_cover_odd':[o[j] for j in sorted(reached_right)],
 'large_isolated_labels':[labels[i] for i in isolated],
 'weighted_isolation_first_moment_midpoint':float(sum(weights[i] for i in isolated)),
 'weighted_isolation_first_moment_exact':str(sum(weights[i] for i in isolated)),
 'weighted_isolation_first_moment_radius':str(F(2*X*sum(vrad[i] for i in isolated),S)),
 'late_point':point_data(base,240),**integrate_fixed(pairs)}
 results.append(rec)
 print(name,'edges',len(base),'energy',rec['normalized_energy_enclosure'],'unmatched',len(rec['unmatched_labels']),flush=True)

# Exact source-graph neighborhood and the bounded-path repair of the n=210 cut.
i=index[210];assert i<ne
neighbors=sorted(o[j] for a,j in edges if a==i)
terminal=[m for m in neighbors if m>=X]
assert min(abs(210-m) for m in terminal)==12
assert all(105<=m<=255 for m in neighbors)
h1lo,h1hi=H[1];assert h1lo>1544*S//10000 and H[2][0]>19*S//10000
assert 12*h1lo>18528*S//10000
path=[210,222,185,211]
edge_labels={frozenset((e[i],o[j])) for i,j in edges}
assert all(frozenset((a,b)) in edge_labels for a,b in zip(path,path[1:]))
assert (index[210],index[211]-ne) in threshold(full3,1)
assert scores[index[210],index[211]-ne]==mid[1]

assert nv==157 and len(edges)==2553
expected=[(2553,77,3,5,'1106.1527615585','1106.1527615587'),
 (122,39,79,79,'6694.4051300512','6694.4051300514'),
 (268,55,47,49,'3571.4035150099','3571.4035150102'),
 (595,61,35,37,'2732.7683158691','2732.7683158695'),
 (154,43,71,71,'5803.8806389900','5803.8806389904'),
 (5244,77,3,3,'952.7275807833','952.7275807838')]
point_values=['173.413269','814.454481','555.735366','466.838852','758.061974','130.734362']
penalty_values=['93.868891','734.910103','476.190988','387.294474','678.517595','51.189983']
for rec,ex,pv,gv in zip(results,expected,point_values,penalty_values):
 assert (rec['edges'],rec['maximum_cardinality'],rec['unmatched_cardinality_deficit'],len(rec['unmatched_labels']))==ex[:4]
 assert F(ex[4]) <= F(rec['raw_energy_lower'])/X**2
 assert F(rec['raw_energy_upper'])/X**2 <= F(ex[5])
 for key,center in [('C0_exact_enclosure','79.544378'),('optimal_cost_exact_enclosure',pv),('graph_penalty_exact_enclosure',gv)]:
  lo,hi=map(F,rec['late_point'][key])
  assert F(center)-F(1,10**6)<lo<=hi<F(center)+F(1,10**6)
print('All six fixed-energy, cardinality and pointwise primal-dual enclosures passed.')

for rec,count,center in [(results[1],52,'90018.661'),(results[2],30,'54573.356'),(results[3],21,'40221.825'),(results[4],42,'75041.897')]:
 assert len(rec['large_isolated_labels'])==count
 assert abs(F(rec['weighted_isolation_first_moment_exact'])-F(center))+F(rec['weighted_isolation_first_moment_radius']) < F(1,1000)
print('Exact isolated-label weighted first-moment enclosures passed.')
