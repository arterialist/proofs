#!/usr/bin/env python3
"""Exact rational interval certificate for the p=5, X=2 kernel.

The only transcendental inputs are q=exp(-1) and L=log(2).  They are
enclosed by the alternating exponential series and the positive atanh
series, respectively.  All subsequent polynomial and matrix arithmetic uses
fractions.Fraction.
"""

from fractions import Fraction as Q
from itertools import product
from math import factorial


def add(*polys):
    out = {}
    for poly in polys:
        for exponent, coefficient in poly.items():
            out[exponent] = out.get(exponent, Q(0)) + coefficient
    return {exponent: coefficient for exponent, coefficient in out.items()
            if coefficient}


def scale(poly, scalar):
    return {exponent: coefficient * scalar
            for exponent, coefficient in poly.items() if coefficient * scalar}


def monomial(exponent, coefficient=Q(1)):
    return {exponent: coefficient} if coefficient else {}


def interval_add(x, y):
    return x[0] + y[0], x[1] + y[1]


def interval_mul(x, y):
    values = [x[0] * y[0], x[0] * y[1], x[1] * y[0], x[1] * y[1]]
    return min(values), max(values)


def polynomial_interval(poly, q_interval):
    low, high = Q(0), Q(0)
    q_low, q_high = q_interval
    for exponent, coefficient in poly.items():
        if coefficient >= 0:
            low += coefficient * q_low**exponent
            high += coefficient * q_high**exponent
        else:
            low += coefficient * q_high**exponent
            high += coefficient * q_low**exponent
    return low, high


def exp_minus_one_interval(terms=24):
    # Odd truncation is below exp(-1); the preceding even truncation is above.
    even = sum((Q(-1) ** k) / factorial(k) for k in range(2 * terms + 1))
    odd = even - Q(1, factorial(2 * terms + 1))
    return odd, even


def log_two_interval(terms=18):
    # log 2 = 2 sum_{k>=0} 1 / ((2k+1) 3^(2k+1)).
    lower = 2 * sum(Q(1, (2 * k + 1) * 3 ** (2 * k + 1))
                    for k in range(terms + 1))
    first_denominator = 2 * terms + 3
    tail = Q(2, first_denominator * 3**first_denominator) * Q(9, 8)
    return lower, lower + tail


P = 5
X = 2
DIVISORS = (1, 2, 3, 6)


def h_polynomial(d, n):
    m = min(n, X * d)
    # q^n/(2d)[q^(Xd-m)-q^(Xd)+(1-q)(n-m)].
    return scale(add(
        monomial(n + X * d - m),
        monomial(n + X * d, -1),
        monomial(n, n - m),
        monomial(n + 1, -(n - m)),
    ), Q(1, 2 * d))


def g_polynomial(x, y):
    return add(monomial(max(x, y)), monomial(x + y, -1))


def kernel_parts(e, a):
    # K = (L/X) A(q) + (L/X)^2 B(q).
    first = scale(add(h_polynomial(P * e, a),
                      scale(h_polynomial(P * e, P * a), -1)), 2)
    second = add(g_polynomial(P * e, P * a),
                 scale(g_polynomial(e, P * a), -2))
    return first, second


def form_parts(vector):
    first, second = {}, {}
    for i, e in enumerate(DIVISORS):
        for j, a in enumerate(DIVISORS):
            coefficient = vector[i] * vector[j]
            a_part, b_part = kernel_parts(e, a)
            first = add(first, scale(a_part, coefficient))
            second = add(second, scale(b_part, coefficient))
    return first, second


def form_interval(vector, q_interval, log_interval):
    first, second = form_parts(vector)
    first_value = polynomial_interval(first, q_interval)
    second_value = polynomial_interval(second, q_interval)
    log_over_x = (log_interval[0] / X, log_interval[1] / X)
    return interval_add(interval_mul(log_over_x, first_value),
                        interval_mul(interval_mul(log_over_x, log_over_x),
                                     second_value))


def kernel_interval(e, a, q_interval, log_interval):
    first, second = kernel_parts(e, a)
    first_value = polynomial_interval(first, q_interval)
    second_value = polynomial_interval(second, q_interval)
    log_over_x = (log_interval[0] / X, log_interval[1] / X)
    return interval_add(interval_mul(log_over_x, first_value),
                        interval_mul(interval_mul(log_over_x, log_over_x),
                                     second_value))


def decimal_interval(interval):
    return f"[{float(interval[0]):.15g}, {float(interval[1]):.15g}]"


def main():
    q_interval = exp_minus_one_interval()
    log_interval = log_two_interval()

    positive_vector = (-1, 1, 0, 0)
    negative_vector = (-1, 0, -1, 2)
    assert sum(positive_vector) == 0
    assert sum(negative_vector) == 0

    positive = form_interval(positive_vector, q_interval, log_interval)
    negative = form_interval(negative_vector, q_interval, log_interval)
    assert positive[0] > 0
    assert negative[1] < 0

    # The symmetric matrix is entrywise negative despite its indefinite
    # restriction to the zero-total subspace.
    for e, a in product(DIVISORS, repeat=2):
        left = kernel_interval(e, a, q_interval, log_interval)
        right = kernel_interval(a, e, q_interval, log_interval)
        symmetric = ((left[0] + right[0]) / 2,
                     (left[1] + right[1]) / 2)
        assert symmetric[1] < 0

    print("q=exp(-1) in", decimal_interval(q_interval))
    print("L=log(2) in", decimal_interval(log_interval))
    print("Q(-1,1,0,0) in", decimal_interval(positive))
    print("Q(-1,0,-1,2) in", decimal_interval(negative))
    print("All 16 symmetric matrix entries have certified negative upper bounds")
    print("PASS: the exact p=5, X=2 zero-total form is sign-indefinite")


if __name__ == "__main__":
    main()
