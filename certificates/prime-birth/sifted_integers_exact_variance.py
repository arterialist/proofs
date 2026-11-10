"""Exact law for finitely many deleted primes. S = k primes, P = their product, a = prod (1 - 1/p),
R(n) = #{m <= n : gcd(m, P) = 1} - a n.  Claim: the variance of R(n) over one full period n = 1..P is a (2^k - a) / 12."""
from fractions import Fraction
from math import gcd
def check(S):
    P = 1
    for p in S: P *= p
    a = Fraction(1)
    for p in S: a *= Fraction(p - 1, p)
    N = 0; vals = []
    for n in range(1, P + 1):
        N += 1 if gcd(n, P) == 1 else 0
        vals.append(Fraction(N) - a * n)
    mean = sum(vals) / P
    var = sum((v - mean) ** 2 for v in vals) / P
    pred = a * (2 ** len(S) - a) / 12
    return var, pred
for S in [[2], [3], [2, 3], [3, 7], [2, 3, 5], [3, 7, 13], [2, 3, 5, 7], [5, 11, 13, 17], [2, 3, 5, 7, 11]]:
    var, pred = check(S)
    print(f"S={S}: variance={var}  formula={pred}  equal={var == pred}")
