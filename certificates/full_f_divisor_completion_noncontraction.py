#!/usr/bin/env python3
"""Interval certificate for actual full-F divisor completion at X=128, D=11.

Requires mpmath and sympy. The analytic quadrature remainder proof is in
../building-blocks/factorial-and-renewal/factorial-f-ground-square-root-divisor-completion-noncontraction.md.
All reported enclosures include the proved 1e-9 absolute allowance.
"""
from fractions import Fraction
from math import ceil, factorial

import mpmath as mp
import sympy as sp

mp.iv.dps = 35
iv = mp.iv
X, D, N = 128, 11, 514


def rational_interval(q):
    return iv.mpf(int(q.p)) / int(q.q)


def gauss_nodes():
    z = sp.symbols("z")
    p = sp.legendre(8, z)
    roots = sp.polys.polytools.intervals(p, eps=sp.Rational(1, 10**45))
    assert len(roots) == 8
    result = []
    for (a, b), multiplicity in roots:
        assert multiplicity == 1
        t = rational_interval(a) + (rational_interval(b) - rational_interval(a)) * iv.mpf([0, 1])
        derivative = (6435 * 8 * t**7 - 12012 * 6 * t**5 + 6930 * 4 * t**3 - 1260 * 2 * t) / 128
        weight = 2 / ((1 - t*t) * derivative**2)
        result.append(((t + 1) / 2, weight / 2))
    return result


nodes = gauss_nodes()
logs = [iv.mpf(0)] + [iv.log(n) for n in range(1, N + 1)]
mangoldt = [iv.mpf(0) for _ in range(N + 1)]
for n in range(2, N + 1):
    factors = sp.factorint(n)
    if len(factors) == 1:
        mangoldt[n] = logs[next(iter(factors))]

psi, harmonic = [iv.mpf(0)], [iv.mpf(0)]
for n in range(1, N + 1):
    psi.append(psi[-1] + mangoldt[n])
    harmonic.append(harmonic[-1] + mangoldt[n] / n)

ground = [iv.mpf(1) for _ in range(N + 1)]
for n in range(2, N + 1):
    ground[n] = logs[n] - harmonic[n] + psi[n] / n
for n in range(127, N + 1):
    assert ground[n].a > iv.mpf("1.56")
    assert abs(psi[n] - n).b < 11

low_coeff = [iv.mpf(0) for _ in range(N + 1)]
for d in range(1, D + 1):
    mu = int(sp.mobius(d))
    if mu:
        for m in range(1, N // d + 1):
            low_coeff[d*m] += mu * logs[m]
assert (low_coeff[221] - logs[221]).a <= 0 <= (low_coeff[221] - logs[221]).b
assert mangoldt[221] == 0


def atom_prefix(coefficients):
    result = [[iv.mpf(0)] for _ in range(3)]
    for n in range(1, N + 1):
        atom = coefficients[n] / (n*n*ground[n])
        for k in range(3):
            result[k].append(result[k][-1] + atom * logs[n]**k)
    return result


actual_prefix = atom_prefix(mangoldt)
low_prefix = atom_prefix(low_coeff)
density_prefix = [[iv.mpf(0) for _ in range(N + 1)] for _ in range(3)]


def density_cell(n, length):
    result = [iv.mpf(0) for _ in range(3)]
    for node, weight in nodes:
        x = n + length * node
        logx = iv.log(x)
        f = logx - harmonic[n] + psi[n] / x
        term = length * weight / (x*x*f)
        result[0] += term
        result[1] += term * logx
        result[2] += term * logx**2
    return result


for n in range(127, N):
    values = density_cell(n, iv.mpf(1))
    for k in range(3):
        density_prefix[k][n + 1] = density_prefix[k][n] + values[k]


def density_primitive(x):
    n = int(float(x.mid))
    assert x.a > n and x.b < n + 1
    partial = density_cell(n, x - n)
    return [density_prefix[k][n] + partial[k] for k in range(3)]


def scores(y):
    logy = iv.log(y)
    lo, hi = ceil(float(y.mid)) - 1, ceil(float((2*y).mid)) - 1
    # Gauss nodes are strictly inside the cells, so no endpoint ambiguity.
    assert y.a > lo and y.b < lo + 1
    assert (2*y).a > hi and (2*y).b < hi + 1

    def atomic(prefix):
        return y * ((prefix[2][hi] - prefix[2][lo])
                    - 2*logy*(prefix[1][hi] - prefix[1][lo])
                    + logy**2*(prefix[0][hi] - prefix[0][lo]))

    left, right = density_primitive(y), density_primitive(2*y)
    q = [right[k] - left[k] for k in range(3)]
    density = y * (q[2] - 2*logy*q[1] + logy**2*q[0])
    return atomic(actual_prefix) - density, atomic(low_prefix) - density


energies = [iv.mpf(0) for _ in range(4)]
for cell in range(512):
    left = iv.mpf(X) + iv.mpf(cell) / 4
    for node, weight in nodes:
        y = left + node / 4
        actual, low = scores(y)
        high = actual - low
        factor = weight / (4*y)
        for k, value in enumerate((actual**2, low**2, high**2, low*high)):
            energies[k] += factor * value

# Exact rational bounds from the analytic remainder proof.
c8 = Fraction(factorial(8)**4, 17 * factorial(16)**3)
inner = 390 * c8 * Fraction(factorial(16), 4**16) * 256 * (1 + 2*6 + 36)
outer = 512 * c8 * Fraction(1, 4**17) * factorial(16) * 10**6
allowance = Fraction(1, 10**9)
assert outer + 100*inner < allowance
padding = iv.mpf([-1, 1]) / 10**9
certified = [value + padding for value in energies]

expected = [("1.776e-6", "1.779e-6"), ("0.758e-6", "0.761e-6"),
            ("1.750e-6", "1.753e-6"), ("-0.368e-6", "-0.365e-6")]
for label, value, (lower, upper) in zip(("B2", "L2", "T2", "LT"), certified, expected):
    assert value.a > iv.mpf(lower)
    assert value.b < iv.mpf(upper)
    print(label, iv.nstr(value, 25))

difference = certified[0] - certified[1]
assert difference.a > iv.mpf("1.015e-6")
assert difference.b < iv.mpf("1.021e-6")
assert certified[0].a > 2*certified[1].b
assert certified[0].a > certified[2].b
print("B2-L2", iv.nstr(difference, 25))
print("PASS: actual square-root divisor completion is not a universal energy contraction.")
