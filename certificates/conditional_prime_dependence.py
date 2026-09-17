"""Exact integer/rational checks for one analytic conditional counterexample.

No covariance sampling and no cutoff grid. The proof uses only these finite
prime counts and rational bounds; no floating-point arithmetic is involved.
"""

from fractions import Fraction as F
from math import isqrt


def prime(n):
    return n >= 2 and all(n % d for d in range(2, isqrt(n) + 1))


primes = [n for n in range(2, 3001) if prime(n)]
small = [r for r in primes if 101 <= r < 206]
assert small == [101, 103, 107, 109, 113, 127, 131, 137, 139,
                 149, 151, 157, 163, 167, 173, 179, 181, 191,
                 193, 197, 199]
assert len(small) == 21 and sum(small) == 3167
assert [r for r in small if r < 202] == small
counts = [sum(lo < r <= hi for r in primes)
          for lo, hi in [(100, 1000), (1000, 2000), (2000, 3000)]]
assert counts == [143, 135, 127]
assert 1000 < 32**2 and 2000 < 45**2 and 3000 < 55**2

p, q = 101, 103
x = 2 * p * q
assert x == 20806 and p**3 > x and q**3 > x
assert p**2 * q > x and p * q**2 > x
assert F(x, p**2) < 101 and F(x, q**2) < 101

small_zp = 205 + F(sum(206-r for r in small), 10)
small_zq = 201 + F(sum(202-r for r in small), 10)
A_upper = p * small_zp + x-p*p
B_upper = q * small_zq + x-q*q
Z_lower = (F(x-1) + 143*F(x-1000, 32)
           + 135*F(x-2000, 45) + 127*F(x-3000, 55))
C = p*q
margin = C*Z_lower-A_upper*B_upper
assert A_upper == F(430159, 10)
assert B_upper == F(83945, 2)
assert Z_lower == F(182025127, 880)
assert margin == F(304780716961, 880) and margin > 0

# The exact regression reversal is certified using the same coarse bounds.
assert small_zp < 4*q
assert Z_lower-11*small_zp > 4*B_upper
print("Exact conditional positive covariance and regression reversal certified.")
print("Rational covariance-numerator lower margin:", margin)
