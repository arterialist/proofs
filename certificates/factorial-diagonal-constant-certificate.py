"""Exact rational certificates for the factorial strong-bound obstruction."""
from fractions import Fraction as F
from math import factorial

L = 2000
zetalower = sum(F(1, n * n) for n in range(1, 101)) + F(1, 101)
partialupper = F(0)
for r in range(1, L + 1):
    z = F(1, 4 * r - 1)
    logupper = 2 * z + 2 * z**3 / (3 * (1 - z**2))
    partialupper += (F(1, r) - F(1, L + 1)) * logupper
assert (partialupper + F(11, L + 1)) / zetalower < F(16, 25)
assert sum(F(2)**k / factorial(k) for k in range(9)) > F(59, 8)
assert F(27, 10)**10 > 2 * L + 3
assert sum(F(1, factorial(k)) for k in range(6)) > F(27, 10)
assert F(5, 7)**2 > F(1, 2)
assert F(35, 51) * F(317, 413)**2 / 2 > F(1, 5)
assert F(1, 5) * F(9, 5)**2 - F(16, 25) == F(1, 125)
print('PASS: diagonal d < 16/25, tail coercivity c > 1/5, gap > 1/125')
