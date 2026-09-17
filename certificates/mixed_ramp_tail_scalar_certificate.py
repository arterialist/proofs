"""One-dimensional Arb certificate for the mixed-ramp large-M tail.

For .08<=L<=7 and M-L>=6, the complete Q(L,M) is positive.
This runs with python-flint 0.9.0 at 192-bit precision from the
repository root: python3 certificates/mixed_ramp_tail_scalar_certificate.py
"""
from bisect import bisect_right
from flint import arb, ctx
ctx.prec=192
left=arb(2)/25
right=arb(7)
N=2048
# n<=floor(exp(7)); simple exact sieve and exact prime-power enumeration.
limit=1097
assert arb(7).exp().upper() < limit
prime=bytearray(b'\1')*(limit+1)
prime[0]=prime[1]=0
for p in range(2,int(limit**.5)+1):
    if prime[p]:
        prime[p*p:limit+1:p]=b'\0'*len(prime[p*p:limit+1:p])
items=[]
for p in range(2,limit+1):
    if not prime[p]: continue
    n=p
    while n<=limit:
        items.append((n,p))
        n*=p
items.sort()
ns=[n for n,p in items]
A=[arb(0)]
Psi=[arb(0)]
for n,p in items:
    lp=arb(p).log()
    A.append(A[-1]+lp/n)
    Psi.append(Psi[-1]+lp)

def cutoff(x):
    y=x.exp()
    n=int(float(y))
    # Prove the integer cutoff for this rational x from a rigorous ball.
    assert y.lower()>n and y.upper()<n+1, (x,y,n)
    return bisect_right(ns,n)

def pole0(x): return x-1+(-x).exp()
def P0(x):
    j=cutoff(x)
    return A[j]-(-x).exp()*Psi[j]
def T(x):
    q=(-x).exp()
    return q-q/2*(1-q*q).log()-q.atanh()

K=1-(2*arb.pi()).log()-arb(13)/360
S=1-arb(2).log()
assert K.upper()<0
min_lb=None
min_i=None
for i in range(N):
    a=left+(right-left)*i/N
    b=left+(right-left)*(i+1)/N
    # Monotonicity: pole0, P0, S-T are increasing; K(1-e^-L)
    # decreases. This is a rigorous lower bound for F(L) throughout [a,b].
    lower=pole0(a)-P0(b)+K*(1-(-b).exp())+S-T(a)
    if min_lb is None or lower.lower()<min_lb.lower():
        min_lb,min_i=lower,i
    assert lower.lower()>0, (i,a,b,lower)
print('prime powers',len(items),'intervals',N)
print('minimum certified lower for F(L):',min_lb,'on interval',min_i)
assert min_lb.lower()>arb('0.00505263119')
print('CERTIFIED: Q(f_L,f_M)>0 for 2/25<=L<=7 and M-L>=6')
