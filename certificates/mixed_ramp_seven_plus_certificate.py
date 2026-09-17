"""Arb certificate of complete Q(f_L,f_M)>0 for min(L,M)>=7.

Uses actual primes only up to exp(10), and the independently certified
min>=10 theorem for the remaining range.
Run from the repository root with python-flint installed:
python3 certificates/mixed_ramp_seven_plus_certificate.py
"""
from bisect import bisect_right
from flint import arb,ctx
ctx.prec=192
limit=22027
assert arb(10).exp().upper() < limit
p=bytearray(b'\1')*(limit+1)
p[0]=p[1]=0
for q in range(2,int(limit**.5)+1):
    if p[q]:p[q*q:limit+1:q]=b'\0'*len(p[q*q:limit+1:q])
items=[]
for q in range(2,limit+1):
    if p[q]:
        n=q
        while n<=limit:
            items.append((n,q))
            n*=q
items.sort()
ns=[n for n,q in items]
A=[arb(0)];Psi=[arb(0)]
for n,q in items:
    lq=arb(q).log()
    A.append(A[-1]+lq/n)
    Psi.append(Psi[-1]+lq)
def cutoff(x):
    y=x.exp(); n=int(float(y))
    assert y.lower()>n and y.upper()<n+1,(x,y,n)
    return bisect_right(ns,n)
def pole0(x): return x-1+(-x).exp()
def P0(x):
    j=cutoff(x)
    return A[j]-(-x).exp()*Psi[j]
N=8192
minimum=None; min_i=None
for i in range(N):
    a=arb(7)+arb(3)*i/N
    b=arb(7)+arb(3)*(i+1)/N
    lower=pole0(a)-P0(b)
    if minimum is None or lower.lower()<minimum.lower():
        minimum,min_i=lower,i
    assert lower.lower()>arb('0.5753'),(i,a,b,lower)

# Exact portions of r(7); left-endpoint quadrature on [3,7].
gamma=arb.const_euler();kappa=arb(2).log()/2
assert (gamma-arb(13)/90-kappa).lower()>0
g0=2-gamma-(4*arb.pi()).log()
I1=(-arb(7)).exp()*((kappa-1)*kappa.exp()+1)
I2=kappa*((arb(3)-7).exp()-(kappa-7).exp())
I3=arb(0)
for j in range(100):
    a=arb(3)+arb(4)*j/100
    b=a+arb(4)/100
    I3+=(gamma-arb(13)/(10*a*a))*((b-7).exp()-(a-7).exp())
r7_lower=I1+I2+I3
margin=minimum+r7_lower+g0
assert minimum.lower()>arb('0.57581456609753')
assert r7_lower.lower()>arb('0.53487402394328')
assert margin.lower()>arb('0.00244867816')
print('prime powers:',len(items),'boxes:',N)
print('minimum r0 interval lower:',minimum,'at box',min_i)
print('r(7) certified lower:',r7_lower)
print('full Q margin for 7<=L<=10, M>=L:',margin)
assert margin.lower()>0
print('CERTIFIED: Q(f_L,f_M)>0 for 7<=min(L,M)<=10; min>=10 follows separately')
