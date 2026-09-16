#!/usr/bin/env python3
"""Certified total X=2 admission sign at p=23, with moving old primorial.

The finite polynomial contains the complete sampled old row through m=120
and the complete new row through k=4.  The omitted rows are bounded in the
Hilbert norm, uniformly using the exact number of old primorial divisors.
"""
from collections import defaultdict
from fractions import Fraction as Q
from decimal import Decimal
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

here = Path(__file__).parent
spec = spec_from_file_location('base', here/'post_branch_total_admission_p5_x2.py')
b = module_from_spec(spec)
spec.loader.exec_module(b)
spec = spec_from_file_location('arith', here/'post_branch_actual_primorial.py')
a = module_from_spec(spec)
spec.loader.exec_module(a)

P = 23
M = 120
K = 4
DIVISORS = a.divisors_mu(P)
T = len(DIVISORS)


def coefficient(n):
    return sum(md*b.mu(n//d) for d,md in DIVISORS
               if n%d == 0 and (n//d)%2 == 1)


def certify():
    assert T == 256
    assert max(d for d,_ in DIVISORS) == 9699690
    q0 = b.k.exp_minus_one_interval()
    l0 = b.k.log_two_interval()
    q = (b.rational_interval(q0[0])[0], b.rational_interval(q0[1])[1])
    L = (b.rational_interval(l0[0])[0], b.rational_interval(l0[1])[1])
    assert q[1] < Decimal(3)/8
    assert L[1] < Decimal(1)
    r,s = Q(5,8),Q(1,90000)
    assert q0[1] < r*r and q0[1]**P < s*s
    h = (b.down(lambda:L[0]/2),b.up(lambda:L[1]/2))
    h2 = b.multiply(h,h)
    old = {m:coefficient(m) for m in range(1,M+1) if coefficient(m)}
    new = {P*k:-coefficient(k) for k in range(1,K+1) if coefficient(k)}
    assert old[1] == 1 and new[P] == -1
    # Verify the closed m=p split in the principal cross coefficientwise.
    principal=defaultdict(int)
    for m,am in old.items():
        if m<=P:
            principal[P]+=am
            principal[P+m]-=am
        else:
            principal[m]+=am
            principal[m+P]-=am
    assert {n:c for n,c in principal.items() if c} == b.gram_polynomial(old,{P:1})
    poly = b.add_polynomials((1,b.gram_polynomial(new,new)),
                             (2,b.gram_polynomial(old,new)))
    finite = b.multiply(h2,b.polynomial_interval(poly,q))
    old_norm = Q(T)*r/(1-r)
    new_norm = Q(T)*s/(1-s)
    old_tail = Q(T)*r**(M+1)/(1-r)
    new_tail = Q(T)*s**(K+1)/(1-s)
    # Difference of ||new||² + 2<old,new> and the truncated expression.
    error = (2*new_norm*new_tail+new_tail**2
             +2*old_tail*new_norm+2*old_norm*new_tail
             +2*old_tail*new_tail)
    E = b.rational_interval(error)[1]
    total=(b.down(lambda:finite[0]-E),b.up(lambda:finite[1]+E))
    print(f'p={P}, X=2, old divisor count={T}, M={M}, K={K}')
    b.show('finite increment',finite)
    print(f'absolute tail error <= {E:.8E}')
    b.show('total increment',total)
    assert total[1] < 0
    return total


if __name__=='__main__':certify()
