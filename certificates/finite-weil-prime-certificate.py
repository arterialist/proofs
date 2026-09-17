"""Exact integer leaves of the p=10007 signed full-form certificate.

The analytic proof and phase-sequence existence are in the companion note;
this script does not numerically evaluate the Weil form or prove RH.
"""
from fractions import Fraction
from math import isqrt


def is_prime(n):
    return n >= 2 and all(n % d for d in range(2, isqrt(n) + 1))


p = 10007
selected = [
    9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767,
    9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829,
    9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887,
]
assert is_prime(p)
assert len(set(selected)) == 24
for q in selected:
    assert is_prime(q) and q != p
    assert 32 * abs(q - p) < p
    assert 2**13 < q < 102**2
assert 100**2 < p < 2**14

even_powers = []
for q in range(2, isqrt(4 * p // 3) + 1):
    if not is_prime(q):
        continue
    k = 2
    while 3 * q**k <= 4 * p:
        if k % 2 == 0 and 4 * q**k >= 3 * p:
            even_powers.append((q, k, q**k))
        k += 1
assert even_powers == [
    (89, 2, 7921), (97, 2, 9409), (101, 2, 10201),
    (103, 2, 10609), (107, 2, 11449), (109, 2, 11881),
    (113, 2, 12769),
]
assert all(86 < q < 2**7 for q, _, _ in even_powers)
margin = Fraction(24 * 13, 1632) - Fraction(14, 400) - Fraction(49, 344)
assert margin == Fraction(251, 18275) > 0
print("Exact primality, window, complete even-power, and rational-margin checks passed.")
print("Certified margin in units of log(2):", margin)
