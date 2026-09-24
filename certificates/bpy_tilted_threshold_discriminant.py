"""Exact rational certificate for the actual BPY threshold stability failure.

Run with Python 3. No third-party dependencies.
Analytic inputs proved in the companion note:
  b_empty <= (pi/(3*A))^(1/4);
  k^(1/4) <= b_S < k^(1/4) + 1/A, for k=|S| >= 1;
  pi < 4.
"""
from fractions import Fraction as F

A = 10**6
a0, a1 = F(1316, 1000), F(1317, 1000)
b0, b1 = F(3567, 1000), F(3568, 1000)
c0, c1 = F(3), F(3001, 1000)
d1 = F(1, 25)

# Three-high coefficient; monotonicity of the fourth power is used on R_+.
assert a0 > 0 and a1 - F(1, A) > 0
assert a0**4 < 3 < (a1 - F(1, A))**4

# Sum of the three separately bounded two-high coefficients.
assert b0 / 3 > 0 and b1 / 3 - F(1, A) > 0
assert (b0 / 3)**4 < 2 < (b1 / 3 - F(1, A))**4

# Sum of one-high coefficients and the full-remainder zero-high bound.
assert F(3) + F(3, A) < c1
assert F(4, 3 * A) < d1**4

# The omitted cubic-discriminant terms are -4*b^3*d and -27*a^2*d^2.
upper = b1**2 * c1**2 - 4 * a0 * c0**3 + 18 * a1 * b1 * c1 * d1
assert upper == -F(8458321897, 488281250)
assert upper < -17
print('Threshold A =', A)
print('All rational coefficient enclosures passed.')
print('Cubic discriminant <=', upper, '< -17.')
