"""Exact-rational checks for the finite and constant comparisons in the gap note.

This certifies only the elementary computations. The all-x estimate comes
from Johnston--Ramare--Trudgian, Lemma 10, and is a separate analytic input.
"""

from fractions import Fraction


TERMS = 100
PRIME_POWER_BASE = {
    2: 2,
    3: 3,
    4: 2,
    5: 5,
    7: 7,
    8: 2,
    9: 3,
    11: 11,
    13: 13,
    16: 2,
    17: 17,
}
LOWER_MICRO = {
    3: 39261,
    4: 153656,
    5: 54912,
    7: 113397,
    8: 160285,
    9: 156000,
    11: 138680,
    13: 108430,
    16: 272748,
    17: 166713,
}


def log_interval(z: int) -> tuple[Fraction, Fraction]:
    """Rational bounds from log(z) = 2 atanh((z-1)/(z+1))."""
    t = Fraction(z - 1, z + 1)
    partial = sum(
        (2 * t ** (2 * j + 1) / (2 * j + 1) for j in range(TERMS)),
        Fraction(0),
    )
    remainder = 2 * t ** (2 * TERMS + 1) / (
        (2 * TERMS + 1) * (1 - t * t)
    )
    return partial, partial + remainder


logs = {z: log_interval(z) for z in (*PRIME_POWER_BASE, 10)}
assert all(
    hi - lo < Fraction(25, 10**13)
    for z, (lo, hi) in logs.items()
    if z <= 17
)

for n, bound in LOWER_MICRO.items():
    # H(n) - log(2)/2, with all proper prime powers at their endpoints.
    lower = logs[n][0] - logs[2][1] / 2
    for power, base in PRIME_POWER_BASE.items():
        if power <= n:
            lower -= logs[base][1] / power
    assert lower > Fraction(bound, 10**6), n

# The standard harmonic-Euler inequality gives
# gamma > H_100 - log(100) - 1/200.
harmonic_100 = sum((Fraction(1, k) for k in range(1, 101)), Fraction(0))
gamma_lower = harmonic_100 - 2 * logs[10][1] - Fraction(1, 200)
assert gamma_lower > Fraction(577, 1000)
assert logs[2][1] < Fraction(6932, 10000)
assert Fraction(2295, 10000) ** 2 > Fraction(1, 19)
assert logs[10][0] > Fraction(23, 10)

# For 19 <= x <= 10^19 and x > 10^19, respectively.
assert Fraction(577, 1000) - Fraction(2295, 10000) > Fraction(6932, 20000)
assert Fraction(577, 1000) - Fraction(13, 10) / Fraction(437, 10) ** 2 > Fraction(6932, 20000)

print("Exact rational gap comparisons passed at every prime-power jump below 19.")
