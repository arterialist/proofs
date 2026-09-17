"""Rigorous actual source curvature signs at cutoffs 2 and 6.

Requires python-flint 0.9.0. All nonzero arrivals and exact density moments
through six are included. This certifies two finite scalars, not an RH bound.
"""
from flint import arb, ctx

ctx.prec = 192


def actual_curvature(n):
    # Every nonzero von Mangoldt value through six, including the proper power 4.
    base = {2: 2, 3: 3, 4: 2, 5: 5}
    sums = [arb(0), arb(0), arb(0)]
    for m, p in base.items():
        if m <= n:
            logarithm = arb(m).log()
            birth = arb(p).log() / arb(m).sqrt()
            for j in range(3):
                sums[j] += birth * logarithm**j
    root = arb(n).sqrt()
    logarithm = arb(n).log()
    mass = -1 + sums[0] - 2 * (root - 1)
    first = -sums[1] + 2 * root * logarithm - 4 * root + 4
    second = sums[2] - (
        2 * root * logarithm**2 - 8 * root * logarithm + 16 * root - 16
    )
    return mass, first, second, first**2 - mass * second


for n, lower, upper in [(2, 12, 13), (6, -39, -38)]:
    values = actual_curvature(n)
    assert values[3] > arb(lower) / 100
    assert values[3] < arb(upper) / 100
    print(f"N={n}: M, D', D'', curvature = {values}")
    print(f"Certified {lower}/100 < curvature < {upper}/100")
