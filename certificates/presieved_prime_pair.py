"""Exact finite matrices plus Arb logarithms for an actual presieved interval.

Run with Python 3 and python-flint 0.9.0. Fixed rational candidates are checked. Exact LDL and
Rayleigh arithmetic, followed by enclosing logarithm balls, certify claims.
"""
from fractions import Fraction as F
import math
from flint import arb,ctx
ctx.dps=80

def r(u):
 u=abs(F(u))
 if u<=F(1,2):return F(1,12)-u*u/2+u**3/2
 if u<=1:return (1-u)**3/6
 return F(0)
def R(h,d):return F(h,2)*(r(F(d,h))-r(F(2*d,h)))
def rp(h,q,d):
 d%=q
 return R(h,d)+R(h,d-q)
def toarb(x):return arb(x.numerator)/x.denominator

def factors(W):return [p for p in range(2,W+1) if W%p==0 and all(p%d for d in range(2,math.isqrt(p)+1))]
def crt_ratio(W,d):
 return math.prod((F(p-(1 if d%p==0 else 2),p-1) for p in factors(W)),start=F(1))
crt=[]
for W in (2,6,30,210,2310):
 for h in (8,16):
  def cosine(d):
   if h==8:return (-1)**(d//2)
   return {0:1,2:0,4:-1,6:0}[d%8]
  Q=2*sum((R(h,d)*crt_ratio(W,d)*cosine(d) for d in range(2,h,2)),F(0))
  expected=F(-1,6) if h==8 else F(-1,3)
  if W>=6:
   expected=F(-3,32) if h==8 else F(-3,16)
   for p in factors(W):
    if p>=5:expected*=F(p-2,p-1)
  assert Q==expected<0
  crt.append({'W':W,'h':h,'exact_masked_phase_rayleigh':str(Q)})

X,h,W,q=64,16,6,96
I=F(h*h,64);c=I/q
allowed=[n for n in range(q) if math.gcd(n,W)==1]
B=[[rp(h,q,n-m)-c for m in allowed] for n in allowed]
# The search revealed this exact period-12 sign vector.
w=[F(-1 if n%12 in (1,11) else 1) for n in allowed]
wBw=sum((w[i]*w[j]*B[i][j] for i in range(len(w)) for j in range(len(w))),F(0))
norm=sum((v*v for v in w),F(0))
L=-wBw/norm
assert L>F(8203,10000)
assert L==F(105,128)
assert all(sum(B[i][j]*w[j] for j in range(len(w)))==-L*w[i] for i in range(len(w)))
# A rational semidefinite LDL certificate also proves this lower bound optimal.
size=len(B)
pd=[]; pl=[[F(0) for _ in range(size)] for _ in range(size)]
for i in range(size):
 pl[i][i]=1
 for j in range(i):
  numerator=B[i][j]-sum(pl[i][k]*pd[k]*pl[j][k] for k in range(j))
  if pd[j]==0:
   assert numerator==0
   pl[i][j]=0
  else:pl[i][j]=numerator/pd[j]
 pivot=B[i][i]+L-sum(pl[i][k]**2*pd[k] for k in range(i))
 assert pivot>=0
 pd.append(pivot)
for i in range(size):
 for j in range(size):
  assert sum(pl[i][k]*pd[k]*pl[j][k] for k in range(size))==B[i][j]+(L if i==j else 0)

prime_bases={}
for p in range(2,2*X+1):
 if all(p%d for d in range(2,math.isqrt(p)+1)):
  n=p
  while n<=2*X:
   if n>X:prime_bases[n]=p
   n*=p
active=[n for n in prime_bases if math.gcd(n,W)==1]
excluded={n:p for n,p in prime_bases.items() if math.gcd(n,W)!=1}
assert excluded=={128:2,81:3}
logs={n:arb(prime_bases[n]).log() for n in active}
P=sum(logs.values());P2=sum(a*a for a in logs.values())
scalar_rhs_upper=(toarb(c)*P*P-toarb(L)*P2).upper()
assert scalar_rhs_upper<arb('-61.02')

assert active==[125,121,67,71,73,79,83,89,97,101,103,107,109,113,127]
# Fixed rational proposal obtained from the separate exploratory optimization.
charges=list(map(F,['212451/1000000','116751/125000','142607/250000',
 '348167/1000000','205089/500000','655647/1000000','242579/500000',
 '398821/1000000','636031/1000000','324071/500000','371357/500000',
 '129347/200000','559011/1000000','126471/200000','519/3125']))
eps=F(1,20000)
A=[[R(h,n-m)-c+(charges[i] if i==j else 0) for j,m in enumerate(active)] for i,n in enumerate(active)]
# Exact LDL of A-eps I. Positive pivots prove A >= eps I.
N=len(active)
D=[]; lower=[[F(0) for j in range(N)] for i in range(N)]
for i in range(N):
 lower[i][i]=1
 for j in range(i):
  lower[i][j]=(A[i][j]-sum(lower[i][k]*D[k]*lower[j][k] for k in range(j)))/D[j]
 pivot=A[i][i]-eps-sum(lower[i][k]**2*D[k] for k in range(i))
 assert pivot>0
 D.append(pivot)
for i in range(N):
 for j in range(N):
  assert sum(lower[i][k]*D[k]*lower[j][k] for k in range(N))==A[i][j]-(eps if i==j else 0)

active_residues={n%q for n in active}
inactive=[n for n in allowed if n not in active_residues]
cross_frob2=sum((rp(h,q,n-m)-c)**2 for n in active_residues for m in inactive)
outside_charge=I+cross_frob2/eps
weighted_cost=sum(toarb(d)*logs[n]**2 for d,n in zip(charges,active))
lower_bound=toarb(c)*P*P-weighted_cost
assert lower_bound>arb('16.90')
actual_pair=sum(toarb(R(h,n-m))*logs[n]*logs[m] for n in active for m in active)
assert actual_pair>lower_bound
assert cross_frob2 == F(241987,147456)
assert outside_charge == F(151260307,4608)
assert all(rp(h,q,n-m)==R(h,n-m) for n in range(X+1,2*X+1) for m in range(X+1,2*X+1))
print('Exact CRT, scalar optimum and full nonuniform completion passed.')
print('Scalar RHS upper:', scalar_rhs_upper)
print('Nonuniform lower bound:', lower_bound)
print('Inactive diagonal charge:', outside_charge)
print('Actual allowed pair energy:', actual_pair)
