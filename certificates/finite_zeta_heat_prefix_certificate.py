"""Exact rational corners for the finite-zeta heat-prefix bounds.

This checks constants in the written analytic proof.  It does not sample
complex heights or prove the Euler-product and integral estimates in Lean.
Only Python's standard library is needed.
"""

from __future__ import annotations

import argparse
import json
from fractions import Fraction
from math import factorial
from pathlib import Path


def require(condition: bool, message: str) -> None:
    if not condition:
        raise RuntimeError(message)


def integer_root_floor(value: int, degree: int) -> int:
    if value < 0 or degree < 1:
        raise ValueError("The value must be nonnegative and the degree positive")
    if value == 0:
        return 0
    estimate = 1 << ((value.bit_length() + degree - 1) // degree)
    while True:
        updated = ((degree - 1) * estimate + value // estimate ** (degree - 1)) // degree
        if updated >= estimate:
            break
        estimate = updated
    while estimate**degree > value:
        estimate -= 1
    while (estimate + 1) ** degree <= value:
        estimate += 1
    require(
        estimate**degree <= value < (estimate + 1) ** degree,
        "The integer root enclosure failed",
    )
    return estimate


def power_bounds(n: int, numerator: int, denominator: int) -> tuple[Fraction, Fraction]:
    if n < 1 or numerator < 1 or denominator < 1:
        raise ValueError("Positive integer power parameters are required")
    scale = 10**18
    root = integer_root_floor(n**numerator * scale**denominator, denominator)
    return Fraction(root, scale), Fraction(root + 1, scale)


def euler_ratio_lower(numerator: int, denominator: int) -> tuple[Fraction, Fraction]:
    """Enclose zeta(2a)/zeta(a), where a=1+numerator/denominator."""
    delta = Fraction(numerator, denominator)
    powers = [power_bounds(n, numerator, denominator) for n in range(1, 101)]
    zeta_upper = sum(
        (1 / (n * bounds[0]) for n, bounds in enumerate(powers, start=1)), Fraction(0)
    ) + 1 / (delta * powers[-1][0])
    zeta_twice_lower = sum(
        ((1 / (n * bounds[1])) ** 2 for n, bounds in enumerate(powers, start=1)),
        Fraction(0),
    )
    return zeta_twice_lower / zeta_upper, zeta_upper


def exp_lower(x: Fraction, last_degree: int) -> Fraction:
    term = total = Fraction(1)
    for degree in range(1, last_degree + 1):
        term *= x / degree
        total += term
    return total


def exp_upper(x: Fraction, last_degree: int) -> Fraction:
    require(x >= 0, "The exponential upper bound requires x >= 0")
    require(x < last_degree + 2, "The geometric exponential tail does not converge")
    term = total = Fraction(1)
    for degree in range(1, last_degree + 1):
        term *= x / degree
        total += term
    first_omitted = term * x / (last_degree + 1)
    return total + first_omitted / (1 - x / (last_degree + 2))


def check() -> dict[str, object]:
    require(
        sum((Fraction(1, factorial(k)) for k in range(6)), Fraction(0)) > Fraction(8, 3),
        "The e > 8/3 corner failed",
    )

    entry_ratio, _ = euler_ratio_lower(7, 15)
    entry_delta = Fraction(7, 15)
    entry_low = Fraction(9, 160) * (1 / entry_delta**2 + 1)
    entry_high = 1 / (entry_delta * power_bounds(806, 7, 15)[0])
    require(entry_ratio > Fraction(883, 2000), "The entry Euler corner failed")
    require(entry_low == Fraction(1233, 3920), "The entry low error changed")
    require(entry_high < Fraction(59, 625), "The entry high error corner failed")
    require(806**2 <= 649999, "The square-root cutoff corner failed")
    require(
        exp_upper(Fraction(40, 3), 80) < 640000 < 649999,
        "The log M > 40/3 corner failed",
    )
    entry_margin = Fraction(883, 2000) - entry_low - Fraction(59, 625)
    require(entry_margin > Fraction(3, 100), "The entry denominator margin failed")

    large_ratio, cold_zeta_upper = euler_ratio_lower(11, 50)
    require(large_ratio > Fraction(53, 200), "The large-prefix Euler corner failed")
    require(cold_zeta_upper < Fraction(5141, 1000), "The cold zeta upper corner failed")
    require(exp_lower(Fraction(11), 15) > 50000, "The e^11 > 50000 corner failed")
    large_margin = Fraction(53, 200) - Fraction(7863, 48400) - Fraction(1, 5500)
    require(
        large_margin == Fraction(1, 10) + Fraction(571, 242000),
        "The large-prefix exact surplus changed",
    )

    cold_tail = 1 / (Fraction(11, 50) * power_bounds(649999, 11, 50)[0])
    cold_margin = large_ratio - cold_tail
    require(cold_margin > Fraction(13, 500), "The all-height cold-prefix corner failed")

    return {
        "scope": "Exact scalar corners; the uniform analytic reduction is a written proof.",
        "arithmetic": "Fractions and checked integer root enclosures; decimals are diagnostic only.",
        "entry": {
            "integer_prefix_lower": 649999,
            "sigma_cone": "22/15 + (t/4) log M",
            "time_range": "all real t >= 0",
            "height_range": "all imaginary parts",
            "euler_lower_corner": "883/2000",
            "low_error_corner": "1233/3920",
            "high_error_corner": "59/625",
            "rational_margin": str(entry_margin),
            "claimed_floor": "3/100",
            "diagnostic_euler_lower": float(entry_ratio),
            "diagnostic_complete_margin": float(entry_ratio - entry_low - entry_high),
        },
        "large": {
            "log_prefix_lower": 100,
            "sigma_cone": "61/50 + (t/4) log M",
            "time_range": "all real t >= 0",
            "height_range": "all imaginary parts",
            "rational_margin": str(large_margin),
            "surplus_over_one_tenth": "571/242000",
            "claimed_floor": "1/10",
        },
        "cold": {
            "integer_prefix_lower": 649999,
            "sigma_lower": "61/50",
            "height_range": "all imaginary parts",
            "claimed_floor": "13/500",
            "diagnostic_complete_margin": float(cold_margin),
        },
        "rh_status": "These bounds do not constrain critical-strip zeta zeros or prove RH.",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="Save the checked JSON report to this path")
    args = parser.parse_args()
    report = json.dumps(check(), indent=2) + "\n"
    if args.output is not None:
        args.output.write_text(report, encoding="utf-8")
    print(report, end="")


if __name__ == "__main__":
    main()
