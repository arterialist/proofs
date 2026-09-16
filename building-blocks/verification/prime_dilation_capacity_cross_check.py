from fractions import Fraction
from math import isqrt


def mobius_sieve(limit: int) -> list[int]:
    mu = [1] * (limit + 1)
    prime = [True] * (limit + 1)
    mu[0] = 0
    for p in range(2, limit + 1):
        if prime[p]:
            for m in range(p, limit + 1, p):
                prime[m] = False if m != p else prime[m]
                mu[m] *= -1
            pp = p * p
            for m in range(pp, limit + 1, pp):
                mu[m] = 0
    return mu

N, D, p = 146, 13, 11
mu = mobius_sieve(N)
M13 = sum(mu[1:14])
M146 = sum(mu[1:147])
upper = sum(mu[m] for m in range(14, 147) if m % p != 0)
lower = sum(mu[m] for m in range(2, 14) if m % p != 0)
B = sum(mu[m] for m in range(D + 1, N + 1))

assert Fraction(p, 1) / Fraction(N, D) == Fraction(143, 146)
assert (M13, M146) == (-3, 1)
assert (upper, lower, B) == (1, -3, 4)
assert B == upper - lower
assert -2 * upper * lower == 6

print("Certified integer counterexample: N=146, D=13, p=11, U=1, L=-3, B=4, cross=6")
