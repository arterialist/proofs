#!/usr/bin/env python3
"""Certify a Pick-sign obstruction for the actual theta moment ratio.

Dependency: python-flint==0.9.0 (Arb ball arithmetic).
Run: python certificates/theta_moment_ratio_pick_obstruction.py
Optional: --precision 256

The accompanying note proves the analytic continuation and tail estimates:
building-blocks/theta-and-heat/theta-mellin-bernstein-obstruction.md
This is a numerical certificate with analytic tails, not a Lean proof.
"""

import argparse
from fractions import Fraction

from flint import acb, arb, ctx


def require(condition, message):
    if not condition:
        raise ArithmeticError(message)


def derivative_coefficients(order):
    coefficients = [Fraction(-3), Fraction(2)]
    for _ in range(order):
        updated = [Fraction(0)] * (len(coefficients) + 1)
        for degree, coefficient in enumerate(coefficients):
            updated[degree] += (Fraction(5, 4) + degree) * coefficient
            updated[degree + 1] -= coefficient
        coefficients = updated
    return coefficients


def certify(precision):
    require(precision >= 128, "Use at least 128 bits of precision.")
    ctx.prec = precision
    rational_coefficients = derivative_coefficients(18)
    derivative_bound = sum(
        abs(coefficient) * (2 * (degree + 2)) ** (degree + 2)
        for degree, coefficient in enumerate(rational_coefficients)
    )
    require(derivative_bound < 10**60, "Derivative bound failed.")
    coefficients = [
        arb(value.numerator) / value.denominator
        for value in rational_coefficients
    ]
    pi = arb.pi()
    cutoff = arb("1e-40")
    global_bound = arb(10**60)

    # Bounds for both powers x^(3/2+i) and x^(7/2+i).
    lower_tail = global_bound * cutoff**2 * cutoff.sqrt() / arb("2.5")
    omitted_modes = (
        3000 * global_bound * (-pi * 169 / 2).exp()
        / (1 - (-pi * 27 / 2).exp())
    )
    decay = pi * arb(8).exp() / 2
    upper_tail = (
        global_bound * (2 / pi) * (-decay).exp()
        / (1 - (-3 * decay).exp())
    )
    require(lower_tail < arb("1e-40"), "Lower tail bound failed.")
    require(omitted_modes < arb("1e-51"), "Mode tail bound failed.")
    require(upper_tail < arb("1e-100"), "Upper tail bound failed.")
    require(
        lower_tail + omitted_modes + upper_tail < arb("1e-35"),
        "Combined tail bound failed.",
    )

    def truncated_derivative(x):
        exponential = x.exp()
        total = acb(0)
        for n in range(1, 13):
            y = pi * n * n * exponential
            polynomial = acb(0)
            for coefficient in reversed(coefficients):
                polynomial = polynomial * y + coefficient
            total += n * n * polynomial * (x * arb("1.25") - y).exp()
        return total

    point = acb(arb("-7.25"), arb("0.5"))
    endpoints = [
        "1e-40", "1e-10", ".001", ".01", ".1", ".25", ".5",
        "1", "2", "3", "4", "6", "8",
    ]
    error = acb(arb("0 +/- 1e-35"), arb("0 +/- 1e-35"))
    integrals = []
    for parameter in (point - 1, point):
        def integrand(x, analytic):
            # Propagate Arb's analyticity flag across the logarithm branch cut.
            power = (x.log(analytic=analytic) * (2 * parameter + 18)).exp()
            return power * truncated_derivative(x)

        total = acb(0)
        for left, right in zip(endpoints, endpoints[1:]):
            total += acb.integral(
                integrand, acb(left), acb(right),
                abs_tol=arb("1e-25"), rel_tol=arb("1e-25"),
                eval_limit=50000,
            )
        integrals.append(total + error)

    ratio = ((2 * point + 17) * (2 * point + 18) / point
             * integrals[0] / integrals[1])
    require(ratio.imag > arb("-0.406130"), "Lower sign enclosure failed.")
    require(ratio.imag < arb("-0.406129"), "Upper sign enclosure failed.")
    print(f"Precision: {precision} bits")
    print(f"phi(-29/4 + i/2): {ratio}")
    print("CERTIFIED: -0.406130 < Im(phi(-29/4 + i/2)) < -0.406129 < 0")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--precision", type=int, default=180)
    certify(parser.parse_args().precision)
