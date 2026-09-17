#!/usr/bin/env python3
"""High-precision full-face check for the limiting Green admission formula.

Uses only Python's standard library. This is a numerical audit of the finite
expansion, not a proof of its uniform tail estimate.
"""

from decimal import Decimal, getcontext

getcontext().prec = 70


def primes_below(limit: int) -> list[int]:
    sieve = [True] * limit
    if limit:
        sieve[0] = False
    if limit > 1:
        sieve[1] = False
    for p in range(2, limit):
        if sieve[p]:
            for n in range(p * p, limit, p):
                sieve[n] = False
    return [p for p in range(2, limit) if sieve[p]]


def mobius_sieve(limit: int) -> list[int]:
    mu = [1] * (limit + 1)
    mu[0] = 0
    for p in primes_below(limit + 1):
        for n in range(p, limit + 1, p):
            mu[n] *= -1
        for n in range(p * p, limit + 1, p * p):
            mu[n] = 0
    return mu


def divisors_before(p: int) -> list[tuple[int, int]]:
    result = [(1, 1)]
    for prime in primes_below(p):
        result += [(prime * d, -mu) for d, mu in result]
    return result


def green_kernel(d: int, e: int) -> Decimal:
    dd, ee = Decimal(d), Decimal(e)
    leading = Decimal(-2 * max(d, e)).exp()
    corner = Decimal(-2 * (d + e)).exp()
    return (Decimal(2 * (abs(d - e) + 1)) * leading - corner) / (
        Decimal(8) * dd * ee
    )


def t_value(p: int, mu: list[int]) -> Decimal:
    pp = Decimal(p)
    return sum(
        (Decimal(mu[n]) * (pp / Decimal(n) - 1) for n in range(1, p + 1)),
        Decimal(0),
    )


def audit(p: int) -> tuple[int, Decimal, Decimal, Decimal]:
    faces = divisors_before(p)
    uu = sum(
        (Decimal(mu * nu) * green_kernel(p * d, p * e)
         for d, mu in faces for e, nu in faces),
        Decimal(0),
    )
    fu = sum(
        (Decimal(mu * nu) * green_kernel(d, p * e)
         for d, mu in faces for e, nu in faces),
        Decimal(0),
    )
    delta = 2 * (uu - 2 * fu)
    scaled = Decimal(p) * Decimal(2 * p).exp() * delta
    mu = mobius_sieve(p)
    t = t_value(p, mu)
    return len(faces), t, scaled, scaled + t


print("p faces T(p) p*exp(2p)*Delta residual=scaled+T")
for prime in [2, 3, 5, 7, 11, 13, 17, 19, 23]:
    face_count, t, scaled, residual = audit(prime)
    print(prime, face_count, f"{t:.20g}", f"{scaled:.20g}", f"{residual:.20g}")

face_count, t, scaled, residual = audit(23)
assert face_count == 256
assert abs(t - Decimal("1.9742281454355757761")) < Decimal("1e-19")
assert abs(scaled - Decimal("-1.9325563667484438815")) < Decimal("1e-19")
assert abs(residual - Decimal("0.041671778687131894596")) < Decimal("1e-19")
