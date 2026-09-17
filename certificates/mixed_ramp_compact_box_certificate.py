"""Rigorous adaptive Arb proof of complete Q(f_L,f_M)>0 on compact box.

Domain: 2/25 <= L <= 7 and 0 <= M-L <= 6.
Run from the repository root with python-flint installed:
python3 certificates/mixed_ramp_compact_box_certificate.py.
The proof is explained in
building-blocks/weil-and-spectral/complete-weil-positive-causal-ramp-cone.md.
The script uses integer dyadic subdivisions,
certified prime-power cutoffs, and lower balls throughout.
"""
from bisect import bisect_right
from functools import lru_cache
import math,time
from flint import arb, ctx
ctx.prec=192
start=time.time()
QGRID=2**24
DEN=25*QGRID
C=1-arb.const_euler()-(2*arb.pi()).log()
S=1-arb(2).log()
assert C.upper()<0

# One prime-power list covers M<=7+6=13.  No composite that is not a
# prime power contributes a Mangoldt term.
limit=442415
isprime=bytearray(b'\1')*(limit+1)
isprime[0]=isprime[1]=0
for p in range(2,math.isqrt(limit)+1):
    if isprime[p]:
        isprime[p*p:limit+1:p]=b'\0'*len(isprime[p*p:limit+1:p])
items=[]
for p in range(2,limit+1):
    if isprime[p]:
        n=p
        while n<=limit:
            items.append((n,p))
            n*=p
items.sort()
ns=[n for n,p in items]
A=[arb(0)];Psi=[arb(0)]
for n,p in items:
    lp=arb(p).log()
    A.append(A[-1]+lp/n)
    Psi.append(Psi[-1]+lp)
assert (arb(13).exp()).upper()<limit

def Lnum(i): return 2*QGRID+173*i
def Dnum(j): return 150*j

def x(num): return arb(num)/DEN

@lru_cache(maxsize=300000)
def eneg(num): return (-x(num)).exp()

@lru_cache(maxsize=300000)
def T(num):
    if num==0:return S
    q=eneg(num)
    return q-q/2*(1-q*q).log()-q.atanh()

@lru_cache(maxsize=300000)
def cutoff(num):
    y=x(num).exp()
    n=int(float(y))
    if y.lower()<n:n-=1
    if y.lower()>=n+1:n+=1
    assert n>=0 and y.lower()>=n and y.upper()<n+1,(num,y,n)
    return bisect_right(ns,n)

def lower(ai,bi,cj,dj):
    an=Lnum(ai);bn=Lnum(bi)
    cn=Dnum(cj);dn=Dnum(dj)
    man=an+cn;mbn=bn+dn
    ea=eneg(an);eb=eneg(bn);emb=eneg(mbn)
    jb=cutoff(bn);jmb=cutoff(mbn);jd=cutoff(dn)
    # Each of B0,P0,B1,P1 is separately nondecreasing in L,M.
    r0_lower=x(an)-1+ea-A[jb]+eb*Psi[jb]
    r1_lower=x(man)-1-ea*(x(cn)-1)-A[jmb]+eb*A[jd]+emb*(Psi[jmb]-Psi[jd])
    # G=G_inf(L)+D(L,M). C<0, S-T(L) increases in L;
    # each positive exponential summand of D increases in L and
    # decreases in M. Thus the lower corners below are rigorous.
    g_lower=C*(1-eb)+S-T(an)+ea*T(mbn-an)-T(mbn)
    return r0_lower+r1_lower+g_lower

stack=[(0,QGRID,0,QGRID,0)]
leaves=0;nodes=0;depthmax=0;minlower=None
while stack:
    ai,bi,cj,dj,depth=stack.pop()
    lb=lower(ai,bi,cj,dj)
    nodes+=1
    if lb.lower()>arb('0.00000001'):
        leaves+=1
        depthmax=max(depthmax,depth)
        if minlower is None or lb.lower()<minlower.lower():minlower=lb
    else:
        assert depth<32,(ai,bi,cj,dj,depth,lb)
        if bi-ai>dj-cj:
            mid=(ai+bi)//2
            assert ai<mid<bi
            stack.append((ai,mid,cj,dj,depth+1))
            stack.append((mid,bi,cj,dj,depth+1))
        else:
            mid=(cj+dj)//2
            assert cj<mid<dj
            stack.append((ai,bi,cj,mid,depth+1))
            stack.append((ai,bi,mid,dj,depth+1))
    if nodes%100000==0:
        print('progress nodes',nodes,'leaves',leaves,'remaining',len(stack),'seconds',int(time.time()-start),flush=True)
print('prime powers',len(items),'nodes',nodes,'leaves',leaves,'max depth',depthmax)
print('least certified interval lower',minlower)
assert minlower.lower()>arb('0.00000009')
print('elapsed seconds',time.time()-start)
print('CERTIFIED: Q(f_L,f_M)>1e-8 on 2/25<=L<=7, 0<=M-L<=6')
