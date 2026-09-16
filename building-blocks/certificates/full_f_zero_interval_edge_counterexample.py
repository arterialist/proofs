#!/usr/bin/env python3
"""Exact-integer interval certificate for a finite first-window edge reversal.

All interval endpoints are integers divided by Q.  The only transcendental
operation, log, is enclosed by a positive arctanh series after dyadic
reduction.  Midpoint quadrature has a separate global Lipschitz error.
"""

from __future__ import annotations

from math import isqrt


Q = 10**30
TERMS = 35
ZERO = (0, 0)
ONE = (Q, Q)
QUARTER = (Q // 4, Q // 4)


def ceildiv(a: int, b: int) -> int:
    return -(-a // b)


def add(a: tuple[int, int], b: tuple[int, int]) -> tuple[int, int]:
    return a[0] + b[0], a[1] + b[1]


def sub(a: tuple[int, int], b: tuple[int, int]) -> tuple[int, int]:
    return a[0] - b[1], a[1] - b[0]


def mul_pos(a: tuple[int, int], b: tuple[int, int]) -> tuple[int, int]:
    assert a[0] >= 0 and b[0] >= 0
    return a[0] * b[0] // Q, ceildiv(a[1] * b[1], Q)


def div_pos(a: tuple[int, int], b: tuple[int, int]) -> tuple[int, int]:
    assert a[0] >= 0 and b[0] > 0
    return Q * a[0] // b[1], ceildiv(Q * a[1], b[0])


def by_ratio(a: tuple[int, int], n: int, d: int) -> tuple[int, int]:
    assert a[0] >= 0 and n >= 0 and d > 0
    return a[0] * n // d, ceildiv(a[1] * n, d)


def atanh2_bounds(n: int, d: int) -> tuple[int, int]:
    """Enclose 2 atanh(n/d), for 0 <= n/d <= 1/3."""
    assert 0 <= 3 * n <= d
    zlo, zhi = Q * n // d, ceildiv(Q * n, d)
    z2lo, z2hi = zlo * zlo // Q, ceildiv(zhi * zhi, Q)
    powerlo, powerhi = zlo, zhi
    slo = shi = 0
    for j in range(TERMS):
        den = 2 * j + 1
        slo += powerlo // den
        shi += ceildiv(powerhi, den)
        powerlo = powerlo * z2lo // Q
        powerhi = ceildiv(powerhi * z2hi, Q)
    # The omitted tail is at most
    # 2(1/3)^(2*TERMS+1) / ((2*TERMS+1)(1-1/9)) < 1/Q.
    assert 2 * Q * 9 < 8 * (2 * TERMS + 1) * 3 ** (2 * TERMS + 1)
    return 2 * slo, 2 * shi + 1


LOG2 = atanh2_bounds(1, 3)


def log_bounds(n: int, d: int = 1) -> tuple[int, int]:
    """Enclose log(n/d) for positive rational n/d >= 1."""
    assert n >= d > 0
    k = 0
    scaled_d = d
    while n >= 2 * scaled_d:
        scaled_d *= 2
        k += 1
    znum, zden = n - scaled_d, n + scaled_d
    assert 0 <= 3 * znum <= zden
    reduced = atanh2_bounds(znum, zden)
    return k * LOG2[0] + reduced[0], k * LOG2[1] + reduced[1]


def fmt(i: int, digits: int = 12) -> str:
    sign = "-" if i < 0 else ""
    i = abs(i)
    return f"{sign}{i // Q}.{str(i % Q).zfill(30)[:digits]}"


MAX_N = 216
atoms = [ZERO for _ in range(MAX_N + 1)]
for p in range(2, MAX_N + 1):
    if all(p % d for d in range(2, isqrt(p) + 1)):
        lp = log_bounds(p)
        n = p
        while n <= MAX_N:
            atoms[n] = lp
            n *= p

psi = [ZERO for _ in range(MAX_N + 1)]
reciprocal = [ZERO for _ in range(MAX_N + 1)]
for n in range(1, MAX_N + 1):
    psi[n] = add(psi[n - 1], atoms[n])
    reciprocal[n] = add(reciprocal[n - 1], by_ratio(atoms[n], 1, n))

a, b = psi[103], psi[107]
assert 103 * Q < a[0] <= a[1] < 104 * Q
assert 107 * Q < b[0] <= b[1] < 108 * Q
loga = (log_bounds(a[0], Q)[0], log_bounds(a[1], Q)[1])
logb = (log_bounds(b[0], Q)[0], log_bounds(b[1], Q)[1])


def ground(xn: int, xd: int) -> tuple[int, int]:
    n = xn // xd
    return add(sub(log_bounds(xn, xd), reciprocal[n]), by_ratio(psi[n], xd, xn))


def P(t: tuple[int, int], r: tuple[int, int]) -> tuple[int, int]:
    """P(t)=1/4-r^2(t^2/2+t/2+1/4), r=e^-t."""
    t = max(0, t[0]), max(0, t[1])
    poly = add(add(by_ratio(mul_pos(t, t), 1, 2), by_ratio(t, 1, 2)), QUARTER)
    return sub(QUARTER, mul_pos(mul_pos(r, r), poly))


J = P(LOG2, (Q // 2, Q // 2))
assert 0 < J[0] <= J[1] < Q // 4


def clip(a: tuple[int, int], lo: int, hi: int) -> tuple[int, int]:
    assert a[1] >= lo and a[0] <= hi
    return max(lo, a[0]), min(hi, a[1])


def kernel(xn: int, xd: int) -> tuple[int, int]:
    # Every queried rational point is separated from the four irrational
    # breakpoints by the certified endpoint intervals.
    if 2 * xn * Q < a[0] * xd or xn * Q >= 2 * b[1] * xd:
        return ZERO
    lx = log_bounds(xn, xd)
    if xn * Q < a[0] * xd:
        assert 2 * xn * Q > a[1] * xd
        t = sub(add(LOG2, lx), loga)
        r = by_ratio(a, xd, 2 * xn)
        return clip(P(t, r), 0, J[1])
    if xn * Q < b[0] * xd:
        assert xn * Q >= a[1] * xd
        return J
    assert xn * Q >= b[1] * xd and xn * Q < 2 * b[0] * xd
    t = sub(lx, logb)
    r = by_ratio(b, xd, xn)
    return clip(sub(J, P(t, r)), 0, J[1])


def integrand(xn: int, xd: int) -> tuple[int, int]:
    k = kernel(xn, xd)
    if k == ZERO:
        return ZERO
    return div_pos(k, ground(xn, xd))


# Certify coarse pointwise estimates needed for the quadrature error.
min_f = 10 * Q
max_e = 0
for n in range(51, 216):
    # On [n,n+1): log x >= log n and psi_n/x >= psi_n/(n+1).
    f_lower = log_bounds(n)[0] - reciprocal[n][1] + psi[n][0] // (n + 1)
    min_f = min(min_f, f_lower)
    max_e = max(max_e, abs(psi[n][0] - (n + 1) * Q), abs(psi[n][1] - n * Q))
assert min_f > Q, fmt(min_f)
assert max_e < 20 * Q, fmt(max_e)


atom_sum = ZERO
for n in range(52, 216):
    if atoms[n] != ZERO:
        atom_sum = add(atom_sum, mul_pos(atoms[n], integrand(n, 1)))


# Composite midpoint quadrature on [51,216] with h=1/100.  The integrand
# is continuous and globally 1/40-Lipschitz: on each smooth piece,
# |K'| <= 1/x <= 1/51, K < 1/4, |F'| <= 20/51^2, F > 1.
# Thus |(K/F)'| < 1/51 + 5/51^2 < 1/40.  Breakpoints remain continuous.
midpoint_sum = ZERO
for j in range(16500):
    x_num = 10201 + 2 * j  # 51 + (j + 1/2)/100
    midpoint_sum = add(midpoint_sum, integrand(x_num, 200))
midpoint_integral = by_ratio(midpoint_sum, 1, 100)
midpoint_error = Q * 165 // 16000  # length * Lipschitz * h / 4
integral = midpoint_integral[0] - midpoint_error, midpoint_integral[1] + midpoint_error
score = sub(atom_sum, integral)

# Coarse decimal-rational inequalities are also checked as exact integers.
assert min_f > 3 * Q // 2
assert max_e < 8 * Q
assert atom_sum[0] > 243299 * Q // 100000
assert midpoint_integral[1] < 240154 * Q // 100000
assert score[0] > Q // 50

print("a=psi(103):", fmt(a[0]), fmt(a[1]))
print("b=psi(107):", fmt(b[0]), fmt(b[1]))
print("minimum certified cell bound F:", fmt(min_f))
print("maximum certified cell bound |E|:", fmt(max_e))
print("J0:", fmt(J[0]), fmt(J[1]))
print("atomic sum:", fmt(atom_sum[0]), fmt(atom_sum[1]))
print("midpoint integral:", fmt(midpoint_integral[0]), fmt(midpoint_integral[1]))
print("quadrature error:", fmt(midpoint_error))
print("unrestricted score:", fmt(score[0]), fmt(score[1]))
assert score[0] > 0
