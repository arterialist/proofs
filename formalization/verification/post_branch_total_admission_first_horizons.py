#!/usr/bin/env python3
"""Certified complete p=5 admission signs at integer X=2,3,4,5."""
from collections import defaultdict
from decimal import Decimal
from fractions import Fraction as Q
from importlib.util import module_from_spec, spec_from_file_location
from math import gcd
from pathlib import Path

here=Path(__file__).parent

def load(name,path):
    spec=spec_from_file_location(name,here/path)
    module=module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

b=load('base','post_branch_total_admission_p5_x2.py')
a=load('arithmetic','post_branch_actual_primorial.py')
M=120
DIVISORS=((1,1),(2,-1),(3,-1),(6,1))
ROOTS={2:(Q(5,8),Q(1,10)),3:(Q(3,4),Q(1,5)),
       4:(Q(4,5),Q(3,10)),5:(Q(5,6),Q(3,8))}


def is_prime(n):
    return n>=2 and all(n%d for d in range(2,int(n**.5)+1))


def primorial(X):
    out=1
    for n in range(2,X+1):
        if is_prime(n):out*=n
    return out


def rows(X):
    E,W,Z,T=defaultdict(int),defaultdict(int),defaultdict(int),defaultdict(int)
    PX=primorial(X)
    for d,md in DIVISORS:
        E[d]+=md
        W[5*d]-=md
        for n in range(2,M+1):
            c=b.mu(n) if gcd(n,PX)==1 else 0
            if c:
                Z[d*n]+=md*c
                T[5*d*n]-=md*c
    return tuple({m:c for m,c in row.items() if c} for row in (E,W,Z,T))


def certify(X):
    qf=a.exp_minus_two_over_x_interval(X)
    Lf=a.log_integer_interval(X)
    q=(b.rational_interval(qf[0])[0],b.rational_interval(qf[1])[1])
    L=(b.rational_interval(Lf[0])[0],b.rational_interval(Lf[1])[1])
    r,s=ROOTS[X]
    assert qf[1] < r*r and qf[1]**5 < s*s
    assert L[1]<Decimal(X)
    h=(b.down(lambda:L[0]/X),b.up(lambda:L[1]/X))
    h2=b.multiply(h,h)
    E,W,Z,T=rows(X)
    old=b.add_rows(E,Z)
    new=b.add_rows(E,Z,W,T)
    direct=b.add_polynomials((1,b.gram_polynomial(new,new)),
                             (-1,b.gram_polynomial(old,old)))
    parts=b.add_polynomials((2,b.gram_polynomial(T,E)),
                            (2,b.gram_polynomial(T,W)),
                            (2,b.gram_polynomial(E,W)),
                            (1,b.gram_polynomial(W,W)),
                            (2,b.gram_polynomial(Z,W)),
                            (2,b.gram_polynomial(Z,T)),
                            (1,b.gram_polynomial(T,T)))
    assert direct==parts
    def pair(A,B):
        return b.multiply(h2,b.polynomial_interval(b.gram_polynomial(A,B),q))
    def times2(x):return b.multiply((Decimal(2),Decimal(2)),x)
    scoped=b.add(b.add(times2(pair(T,E)),times2(pair(T,W))),
                 b.add(times2(pair(E,W)),pair(W,W)))
    oldW=times2(pair(Z,W))
    oldT=times2(pair(Z,T))
    t2=pair(T,T)
    # Sign-free geometric Hilbert bounds: h<1, q^(1/2)<r,
    # q^(5/2)<s, four old divisor faces, all n>M included.
    etaZ=b.rational_interval(4*r**(M+1)/(1-r))[1]
    etaT=b.rational_interval(4*s**(M+1)/(1-s))[1]
    En=b.rational_interval(4*r)[1]
    Wn=b.rational_interval(4*s)[1]
    Zn=b.rational_interval(4*r*r/(1-r))[1]
    Tn=b.rational_interval(4*s*s/(1-s))[1]
    errs=(b.up(lambda:2*etaT*(En+Wn)),
          b.up(lambda:2*etaZ*Wn),
          b.up(lambda:2*(etaZ*Tn+Zn*etaT+etaZ*etaT)),
          b.up(lambda:2*Tn*etaT+etaT*etaT))
    def widen(x,e):return b.down(lambda:x[0]-e),b.up(lambda:x[1]+e)
    scoped,oldW,oldT,t2=(widen(x,e) for x,e in zip((scoped,oldW,oldT,t2),errs))
    total=b.add(b.add(scoped,oldW),b.add(oldT,t2))
    print(f'X={X} X#={primorial(X)} q~{float((q[0]+q[1])/2):.9f}')
    b.show('  scoped',scoped)
    b.show('  2<Z,W>',oldW)
    b.show('  2<Z,T>',oldT)
    b.show('  ||T||^2',t2)
    b.show('  total',total)
    print(f'  tails: etaZ<={etaZ:.4E}, etaT<={etaT:.4E}')
    assert total[0]>0 and scoped[0]>0 and oldW[0]>0 and t2[0]>0
    if X>=3:assert oldT[1]<0
    else:assert oldT[0]>0
    return total

if __name__=='__main__':
    for X in (2,3,4,5):certify(X)
