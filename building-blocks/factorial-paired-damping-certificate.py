"""Exact actual-response certificates for two paired-scale damping failures."""
from collections import Counter
from fractions import Fraction
from math import comb


def mobius(n):
    sign, p = 1, 2
    while p * p <= n:
        if n % p == 0:
            n //= p
            sign = -sign
            if n % p == 0:
                return 0
        p += 1
    return -sign if n > 1 else sign


def response(n, scale=1):
    c = Counter()
    for k in range(1, n + 1):
        c[scale * (n // k)] += mobius(k)
    return {k: v for k, v in c.items() if v}


def difference(a, b):
    c = Counter(a)
    for k, v in b.items():
        c[k] -= v
    return {k: v for k, v in c.items() if v}


def kernel_ratio(a, b):
    # B(a,b) = log of this positive rational, with full compensated density.
    return Fraction((a + b) ** (a + b), a ** a * b ** b * comb(a + b, a))


def pairing_ratio(a, b):
    value = Fraction(1)
    for j, c in a.items():
        for k, d in b.items():
            value *= kernel_ratio(j, k) ** (c * d)
    return value


for n, expected, old_ratio, terminal_ratio in [
    (3, {2: 1, 3: -1}, Fraction(400000000, 387420489), None),
    (5, {4: 1, 2: 1, 1: 1, 5: -1, 3: -1}, None, Fraction(1953125, 1048576)),
]:
    innovation = difference(response(2 * n), response(n, 2))
    assert innovation == expected
    rows = [sum(c * (a // j) for a, c in innovation.items()) for j in range(1, 2 * n + 1)]
    assert rows[0] == -1
    assert all(rows[j - 1] == 0 for j in range(2, 2 * n + 1, 2))
    assert rows[:n] == ([-1, 0, -1] if n == 3 else [-1, 0, -1, 0, -1])
    full, old = Counter(), Counter()
    for k in range(1, 2 * n + 1):
        port = difference(response((2 * n) // k), response(n // k, 2))
        for a, c in port.items():
            full[a] += c
            if k <= n:
                old[a] += c
    assert all(c == 0 for c in full.values())
    assert {a: c for a, c in old.items() if c} == {1: -n}
    assert pairing_ratio(old, old) == Fraction(2) ** (n * n)
    if old_ratio is not None:
        assert pairing_ratio(response(n, 2), innovation) == old_ratio > 1
    if terminal_ratio is not None:
        assert pairing_ratio(innovation, response(1)) == terminal_ratio > 1
print("PASS: actual N=3/N=5 rows, complete renewal, terminal reserve, and positive damping ports")
