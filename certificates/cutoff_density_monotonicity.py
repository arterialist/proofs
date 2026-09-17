"""Exact finite starting inequalities for cutoff density monotonicity.

The accompanying proof supplies the induction for every N >= 6.
Run without -O: the finite checks use assertions.
"""

from fractions import Fraction as F


lower = [0, 1000000, 1414213, 1732050, 2000000, 2236067, 2449489]
upper = [0, 1000000, 1414214, 1732051, 2000000, 2236068, 2449490]
lo = [F(n, 10**6) for n in lower]
hi = [F(n, 10**6) for n in upper]

for n in range(1, 7):
    assert lo[n] ** 2 <= n <= hi[n] ** 2

targets = {2: F(2928, 10000), 3: F(27970, 10000),
           4: F(93958, 10000), 5: F(217517, 10000)}
for n, target in targets.items():
    a_lo = sum(1 / hi[k] for k in range(1, n + 1))
    b_lo = sum(1 / (k * hi[k]) for k in range(1, n + 1))
    c_lo = sum(lo[1:n + 1])
    b_hi = sum(1 / (k * lo[k]) for k in range(1, n + 1))
    c_hi = sum(hi[1:n + 1])
    h_lo = n*n*a_lo*b_lo - 2*n*b_hi*c_hi + a_lo*c_lo
    assert h_lo > target

d6_lo = 6 * sum(1 / hi[k] for k in range(1, 7)) - 2 * sum(hi[1:7])
assert d6_lo > F(17, 100)
print("Exact starting bounds H_N(N), N=2,...,5, and D_6 certified.")
