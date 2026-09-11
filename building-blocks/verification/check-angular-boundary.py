#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Andrew
"""Exact finite checks for angular-height-boundary.md; Python standard library.

Geometry is adapted from the two source checkers identified in the adjacent
provenance file. Polynomial identities are reconstructed using integer
coefficient arithmetic. No logarithmic inequality or RH estimate is tested.
"""
from bisect import bisect_left
from fractions import Fraction as Q
from functools import lru_cache
from hashlib import sha256
from math import gcd, isqrt
from pathlib import Path
import json
import platform


def require(condition):
    if not condition:
        raise ArithmeticError("exact identity or inequality failed")


def roots(N):
    return sorted(Q(a, n) for n in range(1, N + 1)
                  for a in range(n) if gcd(a, n) == 1)


def weights(xs):
    return {a: ((xs[i + 1] if i + 1 < len(xs) else Q(1))
                - (xs[i - 1] if i else xs[-1] - 1)) / 2
            for i, a in enumerate(xs)}


counts = dict(meshes=0, sector_masses=0, insertion_basis_coefficients=0,
              births=0, small_conductor_masses=0, recent_band_masses=0)
previous = previous_weights = None
for N in range(2, 61):
    xs = roots(N)
    w = weights(xs)
    require(sum(w.values()) == 1 and w[Q(0)] == Q(1, N))
    A = {n: Q(0) for n in range(1, N + 1)}
    for i, a in enumerate(xs):
        right = xs[i + 1] if i + 1 < len(xs) else Q(1)
        gap = right - a
        require(0 < gap <= Q(1, 2))
        require(gap == Q(1, a.denominator * right.denominator))
        A[a.denominator] += w[a]
    for n in A:
        expected = sum((Q(1, n * b) for b in range(N - n + 1, N + 1)
                        if gcd(b, n) == 1), Q(0))
        require(A[n] == expected)
        if n < N:
            require(A[n] <= Q(1, N - n))
        counts['sector_masses'] += 1
    if N >= 3:
        coefficients = {a: w[a] for a in previous}
        birth_mass = Q(0)
        for a in xs:
            if a.denominator != N:
                continue
            j = bisect_left(previous, a)
            left = previous[j - 1]
            right = previous[j] if j < len(previous) else Q(1)
            b, d = left.denominator, right.denominator
            require(b + d == N)
            require(a == Q(left.numerator + right.numerator, N))
            require((a - left) / (right - left) == Q(d, N))
            require(w[a] == Q(1, 2 * b * d))
            coefficients[left] += w[a] * Q(b, N)
            coefficients[right % 1] += w[a] * Q(d, N)
            birth_mass += w[a]
            counts['births'] += 1
        require(coefficients == previous_weights)
        require(birth_mass == sum((Q(1, N * b) for b in range(1, N)
                                  if gcd(b, N) == 1), Q(0)))
        counts['insertion_basis_coefficients'] += len(previous)
        for Y in range(1, N + 1):
            mass = sum((A[n] for n in range(1, min(Y, N - 1) + 1)), Q(0))
            require(mass <= 1)
            if N > 2 * Y:
                require(mass <= Q(2 * Y, N))
            counts['small_conductor_masses'] += 1
        H = sum((Q(1, j) for j in range(1, N + 1)), Q(0))
        band = sum((A[n] for n in range(N - isqrt(N), N)), Q(0))
        require(N * band * band <= 4 * H * H)
        counts['recent_band_masses'] += 1
    previous, previous_weights = xs, w
    counts['meshes'] += 1


# Polynomials are coefficient lists in increasing degree, with integer entries.
def trim(p):
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def mul(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, ai in enumerate(a):
        for j, bj in enumerate(b):
            c[i + j] += ai * bj
    return trim(c)


def divrem(a, b):
    require(b[-1] == 1)
    a = a[:]
    q = [0] * max(1, len(a) - len(b) + 1)
    while len(a) >= len(b) and a != [0]:
        k, c = len(a) - len(b), a[-1]
        q[k] = c
        for j, bj in enumerate(b):
            a[k + j] -= c * bj
        trim(a)
    return trim(q), a


def divisors(n):
    return [d for d in range(1, n + 1) if n % d == 0]


def mobius(n):
    sign, p = 1, 2
    while p * p <= n:
        if n % p == 0:
            sign = -sign
            n //= p
            if n % p == 0:
                return 0
        p += 1
    return -sign if n > 1 else sign


def power_minus_one(d):
    return [-1] + [0] * (d - 1) + [1]


@lru_cache(None)
def cyclotomic(n):
    f = power_minus_one(n)
    for d in divisors(n)[:-1]:
        f, rem = divrem(f, cyclotomic(d))
        require(rem == [0])
    return f


fixtures = [(1, 2), (1, 12), (2, 6), (2, 12), (3, 6), (3, 12),
            (4, 8), (4, 12), (5, 10), (6, 12), (6, 18), (8, 24),
            (9, 18), (10, 30), (12, 24), (15, 30), (4, 15), (6, 15),
            (8, 15), (12, 30), (19, 33)]
for n, N in fixtures:
    plus, minus, order = [1], [1], 0
    for d in divisors(N):
        m = mobius(N // d)
        if d % n == 0:
            order += m
        term = [d] if d % n == 0 else power_minus_one(d)
        if m == 1:
            plus = mul(plus, term)
        elif m == -1:
            minus = mul(minus, term)
    mod = cyclotomic(n)
    require(order == 0)
    require(divrem(mul(cyclotomic(N), minus), mod)[1]
            == divrem(plus, mod)[1])

birth_fixtures = [3, 8, 15, 30, 42]
for N in birth_fixtures:
    plus, minus = [0] * (N - 1) + [N], [1]
    for k in divisors(N)[1:]:
        term, m = power_minus_one(N // k), mobius(k)
        if m == 1:
            plus = mul(plus, term)
        elif m == -1:
            minus = mul(minus, term)
    f = cyclotomic(N)
    derivative = [i * f[i] for i in range(1, len(f))]
    require(divrem(mul(derivative, minus), f)[1] == divrem(plus, f)[1])

result = {
    'all_passed': True, 'python': platform.python_version(),
    'arithmetic': 'integer and Fraction; no floating point',
    'checker_sha256': sha256(Path(__file__).read_bytes()).hexdigest(),
    'geometry_cutoffs': [2, 60], 'counts': counts,
    'regularized_old_factor_fixtures': fixtures,
    'birth_derivative_fixtures': birth_fixtures,
    'scope': 'Finite exact geometry and polynomial checks; no Lean audit, '
             'logarithmic inequality test, or unbounded arithmetic estimate.'
}
print(json.dumps(result, indent=2))
