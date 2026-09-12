"""Actual full-derivative delayed inverse pairs, with clipping and Farey weights."""
import math
from fractions import Fraction as Q

BOUND=1537
mu=[1]*(BOUND+1);mu[0]=0
spf=[0]*(BOUND+1)
for p in range(2,BOUND+1):
    if not spf[p]:
        for j in range(p,BOUND+1,p):
            if not spf[j]:spf[j]=p
            mu[j]*=-1
        for j in range(p*p,BOUND+1,p*p):mu[j]=0

def weight(ell,a,N):
    inv=pow(a,-1,ell)
    b=inv+ell*((N-inv)//ell)
    c=ell-inv
    d=c+ell*((N-c)//ell)
    return (Q(1,b)+Q(1,d))/(2*ell)



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


for ell,a,k in ((19,8,33),(31,13,33),(29,11,53)):
    certificates={N:full_log_certificate(ell,a,N) for N in (k-1,k,k+1,ell*k-1,ell*k)}
    assert certificates[k-1][0]>0
    assert certificates[k][1]<0
    assert certificates[k+1][0]>0
    assert certificates[ell*k-1][0]>0
    assert certificates[ell*k][0]>0
    print(f'CERTIFIED actual positive corrected pair ell={ell},a={a},k={k}:')
    for N,interval in certificates.items():print(f'  N={N}: {interval[0]} < log|F_Nprime| < {interval[1]}')

for ell,a,k,w1,w2 in ((19,8,33,Q(3,1612),Q(13,152520)),(31,13,33,Q(1,456),Q(65,2030088)),(29,11,53,Q(3,3700),Q(105,4635928))):
    assert weight(ell,a,k)==w1
    assert weight(ell,a,ell*k)==w2
    assert w2<=w1/(ell-1)
print('PASS: all three exact Farey-weight pairs and contraction factors.')
