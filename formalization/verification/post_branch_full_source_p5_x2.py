#!/usr/bin/env python3
"""Exact-rational interval audit of the literal p=5, D=6, X=2 source row."""
import importlib.util
from fractions import Fraction as Q
from math import factorial
from pathlib import Path

source = Path(__file__).with_name('post_branch_kernel_p5_x2.py')
spec = importlib.util.spec_from_file_location('kernel', source)
k = importlib.util.module_from_spec(spec)
spec.loader.exec_module(k)

DIVISORS = ((1, 1), (2, -1), (3, -1), (6, 1))
M = 30


def mobius(n):
    value = 1
    p = 2
    while p * p <= n:
        if n % p == 0:
            n //= p
            if n % p == 0:
                return 0
            value = -value
        p += 1
    if n > 1:
        value = -value
    return value


def is_prime(n):
    return n >= 2 and all(n % d for d in range(2, int(n**.5) + 1))


def endpoint_poly():
    out = {}
    for e, me in DIVISORS:
        for a, ma in DIVISORS:
            term = k.add(k.g_polynomial(5*e, 5*a),
                         k.scale(k.g_polynomial(e, 5*a), -2))
            out = k.add(out, k.scale(term, me*ma))
    return out


def source_poly(predicate):
    out = {}
    for e, me in DIVISORS:
        for a, ma in DIVISORS:
            for n in range(3, M + 1, 2):
                mu = mobius(n)
                if mu and predicate(n):
                    term = k.add(k.g_polynomial(5*e*n, a),
                                 k.scale(k.g_polynomial(5*e*n, 5*a), -1))
                    out = k.add(out, k.scale(term, -2*me*ma*mu))
    return out


def lower_atom_poly():
    out={}
    for e,me in DIVISORS:
        for a,ma in DIVISORS:
            term=k.add(k.g_polynomial(10*e,a),
                       k.scale(k.g_polynomial(10*e,5*a),-1))
            out=k.add(out,k.scale(term,-2*me*ma))
    return out


def model_poly():
    out = {}
    for e, me in DIVISORS:
        for a, ma in DIVISORS:
            term = k.add(k.h_polynomial(5*e,a),
                         k.scale(k.h_polynomial(5*e,5*a),-1))
            out = k.add(out,k.scale(term,2*me*ma))
    return out


def mul_scalar_interval(scale, value):
    return k.interval_mul(scale,value)


def decimal(x):
    return f'[{float(x[0]):+.15e}, {float(x[1]):+.15e}]'


def main():
    q=k.exp_minus_one_interval()
    L=k.log_two_interval()
    assert 0 < q[0] <= q[1] < Q(3,8)
    h=(L[0]/2,L[1]/2)
    h2=k.interval_mul(h,h)
    end=mul_scalar_interval(h2,k.polynomial_interval(endpoint_poly(),q))
    prime_part=mul_scalar_interval(h2,k.polynomial_interval(source_poly(is_prime),q))
    rough_part=mul_scalar_interval(h2,k.polynomial_interval(source_poly(lambda n:not is_prime(n)),q))
    model=mul_scalar_interval(h,k.polynomial_interval(model_poly(),q))
    lower_atom=mul_scalar_interval(h2,k.polynomial_interval(lower_atom_poly(),q))
    # For each n>M, both endpoint arguments are <=30 while 5 e n>30.
    # |G(5en,a)-G(5en,5a)| <= q^(5en), and 16 ordered divisor pairs remain.
    # As q <= exp(-1) < 3/8, bound the entire prime or composite tail.
    bound = 32*h2[1]*(Q(3,8)**(5*(M+1)))/(1-Q(3,8)**5)
    prime=(prime_part[0]-bound,prime_part[1]+bound)
    rough=(rough_part[0]-bound,rough_part[1]+bound)
    full=k.interval_add(end,k.interval_add(prime,rough))
    studied=k.interval_add(end,model)
    correction=k.interval_sub(full,studied)
    prime_error=k.interval_sub(prime,model)
    density_pnt_combined=k.interval_sub(prime_error,lower_atom)
    print('endpoint',decimal(end))
    print('exact odd-prime row',decimal(prime))
    print('rough odd-composite row',decimal(rough))
    print('sampled main H row',decimal(model))
    print('closed-lower-atom subtraction',decimal(lower_atom))
    print('prime minus main (all density/PNT/atom effects)',decimal(prime_error))
    print('J + second-log + PNT (not individually signed)',decimal(density_pnt_combined))
    print('full literal mixed+endpoint',decimal(full))
    print('studied main+endpoint',decimal(studied))
    print('full minus studied',decimal(correction))
    print('per-class tail bound',float(bound))
    assert end[0]>0 and full[0]>0 and studied[0]>0
    assert prime[0]>0 and rough[0]>0 and lower_atom[0]>0
    assert model[1]<0 and prime_error[0]>0 and correction[0]>0
    assert density_pnt_combined[1]<0
    assert Q(534,10**9)<correction[0] and correction[1]<Q(535,10**9)

if __name__=='__main__':main()
