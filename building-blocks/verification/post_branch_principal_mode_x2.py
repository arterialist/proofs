#!/usr/bin/env python3
"""Directed intervals for the k=1 and k>=2 complete X=2 admission pieces."""
from collections import defaultdict
from decimal import Decimal
from fractions import Fraction as Q
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

here=Path(__file__).parent

def load(name,path):
    spec=spec_from_file_location(name,here/path)
    mod=module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod

b=load('base','post_branch_total_admission_p5_x2.py')
a=load('arith','post_branch_actual_primorial.py')
M=120
R=Q(5,8)

def coefficient(divisors,n):
    return sum(md*b.mu(n//d) for d,md in divisors
               if n%d==0 and (n//d)%2==1)

def interval(poly,q,h2):
    return b.multiply(h2,b.polynomial_interval(poly,q))

def widen(x,e):
    E=b.rational_interval(e)[1]
    return (b.down(lambda:x[0]-E),b.up(lambda:x[1]+E))

def certify(p,K,s):
    divisors=a.divisors_mu(p)
    T=len(divisors)
    q0=b.k.exp_minus_one_interval()
    l0=b.k.log_two_interval()
    q=(b.rational_interval(q0[0])[0],b.rational_interval(q0[1])[1])
    L=(b.rational_interval(l0[0])[0],b.rational_interval(l0[1])[1])
    assert q0[1]<R*R and q0[1]**p<s*s and L[1]<Decimal(1)
    h=(b.down(lambda:L[0]/2),b.up(lambda:L[1]/2))
    h2=b.multiply(h,h)
    A=lambda n:coefficient(divisors,n)
    old={m:A(m) for m in range(1,M+1) if A(m)}
    new1={p:-1}
    newrest={p*k:-A(k) for k in range(2,K+1) if A(k)}
    S=sum(A(m) for m in range(1,p+1))

    # Exact principal decomposition: self, doubled-Mobius prefix,
    # positive Abel past, and negative Abel future.  The closed m=p
    # endpoint is included in S and the past, not in the future.
    self_poly={p:1,2*p:-1}
    prefix_poly={p:-2*S}
    past_poly=defaultdict(int)
    future_poly=defaultdict(int)
    for m,am in old.items():
        if m<=p:past_poly[p+m]+=2*am
        else:
            future_poly[m]-=2*am
            future_poly[m+p]+=2*am
    terms=[self_poly,prefix_poly,dict(past_poly),dict(future_poly)]
    principal_poly=b.add_polynomials(*((1,x) for x in terms))
    direct_principal=b.add_polynomials(
        (1,b.gram_polynomial(new1,new1)),
        (2,b.gram_polynomial(old,new1)))
    assert principal_poly==direct_principal
    rest_poly=b.add_polynomials(
        (1,b.gram_polynomial(newrest,newrest)),
        (2,b.gram_polynomial(new1,newrest)),
        (2,b.gram_polynomial(old,newrest)))
    total_poly=b.add_polynomials((1,principal_poly),(1,rest_poly))
    assert total_poly==b.add_polynomials(
        (1,b.gram_polynomial(b.add_rows(new1,newrest),
                              b.add_rows(new1,newrest))),
        (2,b.gram_polynomial(old,b.add_rows(new1,newrest))))

    # Only the future term has a tail in the four-piece principal split.
    future_tail=2*Q(T)*Q(3,8)**(M+1)/(1-Q(3,8))
    vals=[interval(poly,q,h2) for poly in terms]
    vals[3]=widen(vals[3],future_tail)
    principal=b.add(b.add(vals[0],vals[1]),b.add(vals[2],vals[3]))

    old_norm=Q(T)*R/(1-R)
    old_tail=Q(T)*R**(M+1)/(1-R)
    rest_norm=Q(T)*s*s/(1-s)
    rest_tail=Q(T)*s**(K+1)/(1-s)
    # Tail of ||rest||²+2<new1,rest>+2<old,rest>, with ||new1||<=s.
    rest_error=(2*rest_norm*rest_tail+rest_tail**2+2*s*rest_tail
                +2*old_tail*rest_norm+2*old_norm*rest_tail
                +2*old_tail*rest_tail)
    remainder=widen(interval(rest_poly,q,h2),rest_error)
    total=b.add(principal,remainder)

    print(f'p={p} D={max(d for d,_ in divisors)} T={T} S_D(p)={S} K={K}')
    for name,value in zip(('self','prefix','Abel past','Abel future'),vals):
        b.show('  '+name,value)
    b.show('  principal k=1',principal)
    b.show('  remainder k>=2',remainder)
    b.show('  complete increment',total)
    print(f'  future tail <= {float(future_tail):.3e}; rest tail error <= {float(rest_error):.3e}')
    if p==5:
        assert principal[0]>0 and remainder[1]<0 and total[0]>0
    if p==23:
        assert principal[1]<0 and remainder[0]>0 and total[1]<0
    return principal,remainder,total

if __name__=='__main__':
    certify(5,80,Q(1,10))
    certify(23,5,Q(1,90000))
