"""Exact formal-coefficient Möbius and finite-prime checks. Standard library only."""
from fractions import Fraction
from math import isqrt

B=100
primes=[n for n in range(2,B+1) if all(n%d for d in range(2,isqrt(n)+1))]
def mobius(n):
    parity=0
    for p in primes:
        if p*p>n: break
        if n%p==0:
            n//=p; parity+=1
            if n%p==0: return 0
    if n>1: parity+=1
    return (-1)**parity
mu=[0]+[mobius(n) for n in range(1,B+1)]
def smooth(n,y):
    for p in primes:
        if p>y: break
        while n%p==0: n//=p
    return n==1
def powers(p,N):
    a=p
    while a<=N:
        yield a
        a*=p
checks=0
for N in range(1,B+1):
    ys=[1]+[p for p in primes if p<=N]
    for y in ys:
        # Represent the answer as independent formal log(p), 1, gamma coefficients.
        log_coeff={p:0 for p in primes if p<=y}
        const=0; gamma=0
        for n in range(1,N+1):
            q=N//n
            for p in log_coeff:
                log_coeff[p]+=mu[n]*sum(q//r for r in powers(p,q))
            const-=mu[n]*sum(q//d for d in range(1,q+1) if smooth(d,y))
            gamma+=2*mu[n]*q
        assert log_coeff=={p:sum(1 for _ in powers(p,N)) for p in log_coeff}
        assert const==-sum(smooth(d,y) for d in range(1,N+1))
        assert gamma==2
        if y*y>=N:
            assert N+const==sum(N//p for p in primes if y<p<=N)
        checks+=1
    for m in range(1,2*N+1):
        actual=sum(mu[n]*(Fraction(N//n//m)-Fraction(N//n,m)) for n in range(1,N+1))
        assert actual==int(m<=N)-Fraction(1,m)
        checks+=1
    for p in primes:
        if p>N: break
        previous=max([1]+[r for r in primes if r<p])
        shell=sum(smooth(d,p)-smooth(d,previous) for d in range(1,N+1))
        assert shell==sum(sum(smooth(d,previous) for d in range(1,N//r+1)) for r in powers(p,N))
        checks+=1
print(f'Passed {checks} exact formal-coefficient and rational endpoint checks for N=1..{B}.')
