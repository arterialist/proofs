"""One fixed actual selected recovery: order145, phase7, cutoff1533.

All enclosures use rational arithmetic with explicit analytic remainders.
This script does not search any neighboring phase, conductor, or cutoff.
The full log includes the exact scalar n*lcm(1..floor(K/n)).
"""
import math
from fractions import Fraction as Q

BOUND=1533
mu=[1]*(BOUND+1);mu[0]=0
spf=[0]*(BOUND+1)
for p in range(2,BOUND+1):
    if not spf[p]:
        for j in range(p,BOUND+1,p):
            if not spf[j]:spf[j]=p
            mu[j]*=-1
        for j in range(p*p,BOUND+1,p*p):mu[j]=0

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



n,a,N=145,7,1533
assert N==3*7*73 and math.gcd(n,N)==math.gcd(a,n)==1
assert (a*N)%n==1
assert (N-1)//n==N//n==10
assert n*math.lcm(*range(1,11))==365400

for d in range(1,N+1):
    difference=M[N//d]-(M[(N-1)//d] if d<=N-1 else 0)
    assert difference==(mu[N//d] if N%d==0 else 0)

old=full_log_certificate(n,a,N-1)
new=full_log_certificate(n,a,N)
assert old[1]<0 and new[1]<0
increase=(new[0]-old[1],new[1]-old[0])
assert increase[0]>0

# Independent eight-divisor factor certificate, without using full-log differences.
lo=hi=Q(0)
positive=[];negative=[]
for d in range(1,N+1):
    if N%d:continue
    assert d%n!=0
    exponent=mu[N//d]
    residue=(a*d)%n
    folded=min(residue,n-residue)
    cl,ch=chord_log_interval(n,residue)
    if exponent>0:
        lo+=cl;hi+=ch;positive.append(folded)
    elif exponent<0:
        lo-=ch;hi-=cl;negative.append(folded)
assert sorted(positive)==[1,21,49,69]
assert sorted(negative)==[2,7,48,62]
factor=enclosure_on_grid(lo,hi,9)
assert factor[0]>0
assert max(factor[0],increase[0])<min(factor[1],increase[1])

def actual_weight(K):
    u=pow(a,-1,n)
    left=u+n*((K-u)//n)
    v=n-u
    right=v+n*((K-v)//n)
    return (Q(1,left)+Q(1,right))/(2*n),(left,right)

wp,parents_old=actual_weight(N-1)
wn,parents_new=actual_weight(N)
assert parents_old==(1388,1512) and parents_new==(1533,1512)
assert wp==Q(5,1049328) and wn==Q(7,1545264)
assert wp-wn==Q(1,2*N*(N-n))
# Both full logs are negative, so Delta b is exactly -log|Phi_N(alpha)|.
response=(-wn*factor[1],-wn*factor[0])
assert response[1]<0

print('FULL L1532:',old)
print('FULL L1533:',new)
print('POSITIVE increment from full-log subtraction:',increase)
print('INDEPENDENT log factor:',factor)
print('EXACT sine ratio numerator indices:',positive,'denominator indices:',negative)
print('FULL scalar at both cutoffs:365400')
print('ACTUAL weights:',wp,'->',wn,'neighbor denominators:',parents_old,'->',parents_new)
print('NEGATIVE weighted old response:',response)
print('PASS: the single selected full-history recovery is rationally certified')
