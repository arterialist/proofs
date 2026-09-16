#!/usr/bin/env python3
"""Rational interval signs for actual primorial Möbius post-branch sums."""

import importlib.util
from fractions import Fraction as Q
from pathlib import Path

source = Path(__file__).with_name('post_branch_kernel_p5_x2.py')
spec = importlib.util.spec_from_file_location('kernel', source)
kernel = importlib.util.module_from_spec(spec)
spec.loader.exec_module(kernel)


def exp_minus_two_over_x_interval(X, terms=24):
    z = Q(2, X)
    upper = sum((-z) ** k / kernel.factorial(k) for k in range(2 * terms + 1))
    lower = upper - z ** (2 * terms + 1) / kernel.factorial(2 * terms + 1)
    return lower, upper


def log_ratio_interval(t, terms=25):
    y = (t - 1) / (t + 1)
    lower = 2 * sum(y ** (2 * k + 1) / (2 * k + 1)
                    for k in range(terms + 1))
    first = 2 * terms + 3
    tail = 2 * y ** first / (first * (1 - y * y))
    return lower, lower + tail


def log_integer_interval(X):
    power = X.bit_length() - 1
    t = Q(X, 2 ** power)
    a = log_ratio_interval(Q(2))
    b = log_ratio_interval(t)
    return power * a[0] + b[0], power * a[1] + b[1]


def divisors_mu(p):
    primes = [n for n in range(2, p)
              if all(n % d for d in range(2, int(n ** .5) + 1))]
    result = [(1, 1)]
    for prime in primes:
        result += [(d * prime, -mu) for d, mu in result]
    return sorted(result)


def actual_form_polynomials(divisors):
    A, B = {}, {}
    for e, mu_e in divisors:
        for a, mu_a in divisors:
            first, second = kernel.kernel_parts(e, a)
            A = kernel.add(A, kernel.scale(first, mu_e * mu_a))
            B = kernel.add(B, kernel.scale(second, mu_e * mu_a))
    return A, B


def interval_for_polynomials(A, B, q, L, X):
    first = kernel.polynomial_interval(A, q)
    second = kernel.polynomial_interval(B, q)
    factor = L[0] / X, L[1] / X
    return kernel.interval_add(kernel.interval_mul(factor, first),
                               kernel.interval_mul(kernel.interval_mul(factor, factor),
                                                   second))


def midpoint(interval):
    return float((interval[0] + interval[1]) / 2)


def certify(p, X):
    kernel.P, kernel.X = p, X
    divisors = divisors_mu(p)
    D = max(d for d, _ in divisors)
    assert 1 < X < D
    q = exp_minus_two_over_x_interval(X)
    L = log_integer_interval(X)
    A, B = actual_form_polynomials(divisors)
    full = interval_for_polynomials(A, B, q, L, X)
    assert full[0] > 0
    # In the cutoff n<X the actual prefix is reconstructed from every
    # squarefree divisor, without replacing it by ordinary Mertens data.
    coefficient = dict(divisors)
    prefix, value = [], 0
    for n in range(1, D):
        value += coefficient.get(n, 0)
        prefix.append(value)
    assert value == -coefficient[D]
    assert value != 0  # total at D, not D-1, vanishes
    head = (Q(0), Q(0))
    tail = (Q(0), Q(0))
    cross = (Q(0), Q(0))
    # Direct double Abel only for the first primorials to avoid O(D^2).
    if D <= 6:
        for u in range(1, D):
            for v in range(1, D):
                coefficient_uv = prefix[u - 1] * prefix[v - 1]
                if not coefficient_uv:
                    continue
                value_uv = kernel.mixed_difference_interval(u, v, q, L)
                if coefficient_uv < 0:
                    value_uv = -value_uv[1], -value_uv[0]
                value_uv = (coefficient_uv * value_uv[0],
                            coefficient_uv * value_uv[1]) if coefficient_uv > 0 else (
                            -coefficient_uv * value_uv[0],
                            -coefficient_uv * value_uv[1])
                if u < X and v < X:
                    head = kernel.interval_add(head, value_uv)
                elif u >= X and v >= X:
                    tail = kernel.interval_add(tail, value_uv)
                else:
                    cross = kernel.interval_add(cross, value_uv)
        combined = kernel.interval_add(kernel.interval_add(head, tail), cross)
        assert combined[0] <= full[1] and full[0] <= combined[1]
        assert head[0] > 0 and cross[0] > 0 and tail[0] > 0
    print(f'p={p} X={X} D={D} actual={midpoint(full):+.12e}',
          f'certified [{float(full[0]):+.12e},{float(full[1]):+.12e}]')
    if D <= 6:
        print(f'  head={midpoint(head):+.12e} cross={midpoint(cross):+.12e}'
              f' tail={midpoint(tail):+.12e}')


if __name__ == '__main__':
    for p, stages in [(5, (2, 3, 4, 5)),
                      (7, (2, 3, 4, 5, 6, 10))]:
        for X in stages:
            certify(p, X)
