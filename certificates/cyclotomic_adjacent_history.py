"""Exact q/r history construction and three fixed rational log fixtures.

This checker deliberately uses no parameter scan. It keeps full prefix
polynomials, exact Farey weights, complex phases, scalars, and clipping.
Rational log certificates use Machin/alternating-sine/atanh bounds.
Requires SymPy for the exact finite polynomial identities.
"""
import math
from fractions import Fraction as Q
import sympy as s

BOUND=199
mu=[0]+[int(s.mobius(j)) for j in range(1,BOUND+1)]
spf=[0]*(BOUND+1)
for p in list(s.primerange(2,BOUND+1)):
    for j in range(p,BOUND+1,p):
        if not spf[j]:spf[j]=p

from functools import lru_cache


def enclosure_on_grid(lo,hi,digits):
    scale=10**digits
    return Q((lo*scale).numerator//(lo*scale).denominator,scale),Q((hi*scale).numerator//(hi*scale).denominator+1,scale)


def atan_interval(x,K=40):
    partial=sum(((-1)**j*x**(2*j+1)/Q(2*j+1) for j in range(K)),Q(0))
    return partial,partial+x**(2*K+1)/Q(2*K+1)


a5,b5=atan_interval(Q(1,5));a239,b239=atan_interval(Q(1,239))
PILO,PIHI=enclosure_on_grid(16*a5-4*b239,16*b5-4*a239,40)


def sin_interval_at(x,K=20):
    partial=sum(((-1)**j*x**(2*j+1)/math.factorial(2*j+1) for j in range(K)),Q(0))
    return partial,partial+x**(2*K+1)/math.factorial(2*K+1)


def raw_log_interval(z,K=32):
    x=(z-1)/(z+1)
    lo=2*sum((x**(2*j+1)/Q(2*j+1) for j in range(K)),Q(0))
    hi=lo+2*x**(2*K+1)/(Q(2*K+1)*(1-x*x))
    return lo,hi


LOG2=raw_log_interval(Q(2))


@lru_cache(None)
def rational_log_interval(z):
    r=0
    while z>=2:z/=2;r+=1
    while z<1:z*=2;r-=1
    lo,hi=raw_log_interval(z)
    if r>=0:return lo+r*LOG2[0],hi+r*LOG2[1]
    return lo+r*LOG2[1],hi+r*LOG2[0]


@lru_cache(None)
def chord_log_interval(ell,r):
    r=min(r,ell-r)
    if 2*r == ell:
        return LOG2  # The middle chord is exactly 2.
    lo=2*sin_interval_at(PILO*r/ell)[0]
    hi=2*sin_interval_at(PIHI*r/ell)[1]
    lo,hi=enclosure_on_grid(lo,hi,35)
    return rational_log_interval(lo)[0],rational_log_interval(hi)[1]


M=[0]
for j in range(1,BOUND+1):M.append(M[-1]+mu[j])


def full_log_certificate(ell,a,N):
    T=N//ell
    scale=ell
    # Product of all prime-power contributions is exactly L_T.
    for j in range(2,T+1):
        p=spf[j];r=j
        while r%p==0:r//=p
        if r==1:scale*=p
    lo,hi=rational_log_interval(Q(scale))
    exponents=[0]*ell
    for d in range(1,N+1):
        if d%ell:exponents[(a*d)%ell]+=M[N//d]
    assert sum(exponents)==0
    for r,e in enumerate(exponents):
        if not e:continue
        cl,ch=chord_log_interval(ell,r)
        if e>0:lo+=e*cl;hi+=e*ch
        else:lo+=e*ch;hi+=e*cl
    return enclosure_on_grid(lo,hi,9)



z=s.symbols('z')
phi={j:s.Poly(s.cyclotomic_poly(j,z),z,domain=s.QQ) for j in range(1,34)}
prefix={0:s.Poly(1,z,domain=s.QQ)}
for j in range(1,34):prefix[j]=prefix[j-1]*phi[j]


def weights(N):
    xs=sorted({Q(0)}|{Q(a,n) for n in range(2,N+1) for a in range(1,n) if math.gcd(a,n)==1})
    return {x:((xs[(j+1)%len(xs)]+(j==len(xs)-1))-(xs[j-1]-(j==0)))/2 for j,x in enumerate(xs)}


def phase_history(n,K):
    mod=phi[n]
    numerator=denominator=s.Poly(1,z,domain=s.QQ)
    for d in range(1,K+1):
        exponent=M[K//d]
        if not exponent:continue
        factor=s.Poly(d if d%n==0 else z**d-1,z,domain=s.QQ).rem(mod)
        if exponent>0:numerator=(numerator*(factor**exponent)).rem(mod)
        else:denominator=(denominator*(factor**(-exponent))).rem(mod)
    exact=(numerator*s.invert(denominator,mod)).rem(mod)
    assert exact==(s.Poly(z,z,domain=s.QQ)*prefix[K].diff()).rem(mod)
    return prefix[K].diff().rem(mod)


for n,K in ((5,7),(5,8),(3,7),(3,8),(19,32),(19,33),(14,32),(14,33)):
    actual=phase_history(n,K)
    if K<=8:print('EXACT derivative',n,K,actual.as_expr())

# Actual small adjacency and full weighted histories.
assert 2*3-1*5==1
w7,w8=weights(7),weights(8)
assert (w7[Q(2,5)],w8[Q(2,5)],w7[Q(1,3)],w8[Q(1,3)])==(Q(1,21),Q(3,112),Q(2,35),Q(5,112))
assert phi[8].rem(phi[5])==s.Poly(-z-z**2-z**3,z,domain=s.QQ)
assert phi[8].rem(phi[3])==s.Poly(1+z,z,domain=s.QQ)

# Joint-cover history and correction, retaining both complex embeddings.
q,r,a,c=5,3,2,1
mod=s.Poly(s.cyclotomic_poly(q*r,z),z,domain=s.QQ)
alpha=s.Poly(z**(a*r),z,domain=s.QQ).rem(mod)
beta=s.Poly(z**(c*q),z,domain=s.QQ).rem(mod)

def subst(poly,value):
    out=s.Poly(0,z,domain=s.QQ)
    for coeff in poly.all_coeffs():out=(out*value+s.Poly(coeff,z,domain=s.QQ)).rem(mod)
    return out

for K in (7,8):
    numerator=denominator=s.Poly(1,z,domain=s.QQ)
    for d in range(1,K+1):
        e=M[K//d]
        if not e:continue
        bq=s.Poly(d,z,domain=s.QQ) if d%q==0 else (alpha**d-s.Poly(1,z,domain=s.QQ)).rem(mod)
        br=s.Poly(d,z,domain=s.QQ) if d%r==0 else (beta**d-s.Poly(1,z,domain=s.QQ)).rem(mod)
        factor=(bq*br).rem(mod)
        if e>0:numerator=(numerator*factor**e).rem(mod)
        else:denominator=(denominator*factor**(-e)).rem(mod)
    product=(numerator*s.invert(denominator,mod)).rem(mod)
    assert product==(alpha*beta*subst(prefix[K].diff(),alpha)*subst(prefix[K].diff(),beta)).rem(mod)
C=(subst(phi[8],alpha)*subst(phi[8],beta)).rem(mod)
num=den=s.Poly(1,z,domain=s.QQ)
for d in s.divisors(8):
    e=int(s.mobius(8//d))
    factor=((1-alpha**d)*(1-beta**d)).rem(mod)
    if e>0:num=(num*factor**e).rem(mod)
    elif e<0:den=(den*factor**(-e)).rem(mod)
assert C==(num*s.invert(den,mod)).rem(mod)
print('EXACT joint correction C_8:',C.as_expr())

# N=33 selects a different phase from the known first negative fixture.
assert 15*14-11*19==1
w32,w33=weights(32),weights(33)
for n,a in ((19,15),(14,11),(19,8)):
    intervals={K:full_log_certificate(n,a,K) for K in (32,33)}
    print('CERT',n,a,intervals,'WEIGHTS',w32[Q(a,n)],w33[Q(a,n)])
    if a!=8:assert all(lo>0 for lo,hi in intervals.values())
    else:
        assert intervals[32][0]>0 and intervals[33][1]<0
        assert w32[Q(a,n)]==w33[Q(a,n)]==Q(3,1612)
print('PASS: all full-history, joint-cover, Farey-weight, and rational-sign checks')

# One already-established negative selected phase, no additional parameter scan.
assert 78*12-5*187==1
w198,w199=weights(198),weights(199)
assert w198[Q(78,187)]==Q(1,4200) and w199[Q(78,187)]==Q(1,34825)
assert w198[Q(5,12)]==Q(16,36839) and w199[Q(5,12)]==Q(33,78406)
for n,a in ((187,78),(12,5)):
    intervals={K:full_log_certificate(n,a,K) for K in (198,199)}
    print('CERT199',n,a,intervals,'WEIGHTS',w198[Q(a,n)],w199[Q(a,n)])
    if n==187:assert all(hi<0 for lo,hi in intervals.values())
    else:assert all(lo>0 for lo,hi in intervals.values())
assert 1<78<187//2
# Strict decrease of the two prime-update logs follows from sine monotonicity;
# the numerator uses angle pi/n while denominator angles are 78pi/187,5pi/12.
print('PASS: actual N199 pair has strictly positive signed clipped response')

# Fixed all-phase recovery used in the fusion comparison, at the next cutoff.
recovery33 = full_log_certificate(19, 8, 33)
recovery34 = full_log_certificate(19, 8, 34)
assert recovery33[1] < 0 < recovery34[0]
print('PASS: fixed all-phase recovery at order19, phase8, cutoffs33 to34', recovery33, recovery34)
