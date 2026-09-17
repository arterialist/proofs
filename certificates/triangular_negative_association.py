"""Exact rational certificate for negative association failure at cutoff 570.

The actual weights are (t-n)/sqrt(n), including all positive integers n<t.
No floating-point square roots or sampled probability approximations are used.
"""
from fractions import Fraction
from math import gcd, isqrt, prod

K = 10**8
PRIME_PRODUCT = prod((2, 3, 5, 7, 11, 13, 17))
TABLE = {(30, False): (175471059, 175471061),
         (30, True): (142302190, 142302191),
         (570, False): (17312553610, 17312553645),
         (570, True): (14013546815, 14013546841)}

def enclosure(t, union_event):
    lo = Fraction(0)
    hi = Fraction(0)
    for n in range(1, t):
        if union_event and gcd(n, PRIME_PRODUCT) == 1:
            continue
        r = isqrt(n * K * K)
        assert r*r <= n*K*K < (r+1)*(r+1)
        lo += Fraction((t-n)*K, r+1)
        hi += Fraction((t-n)*K, r)
    return lo, hi

def main():
    for key, (lower, upper) in TABLE.items():
        lo, hi = enclosure(*key)
        assert Fraction(lower, 10**6) < lo <= hi < Fraction(upper, 10**6)
    s30lo, s30hi = TABLE[30, False]
    u30lo, u30hi = TABLE[30, True]
    s570lo, s570hi = TABLE[570, False]
    u570lo, u570hi = TABLE[570, True]
    assert u30lo * 10**6 > 810972 * s30hi
    assert u570hi * 10**6 < 809445 * s570lo
    print('Exact enclosures passed; covariance at x=570 is strictly positive.')

if __name__ == '__main__':
    main()
