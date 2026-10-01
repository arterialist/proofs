#!/usr/bin/env python3
"""Exact rational constants for the short-interval actual Weil bounds.

This certificate checks numerical corners, not the Fourier/digamma identity,
the infinite-dimensional integral estimates, or the complete Weil theorem.
No binary floating-point value is used to decide a mathematical inequality.
"""

from __future__ import annotations

import argparse
import json
from fractions import Fraction
from pathlib import Path


def exp_upper(x: Fraction, degree: int) -> Fraction:
    """Taylor sum through degree, with a geometric upper bound on the tail."""
    if x < 0 or degree < 0:
        raise ValueError("Require a nonnegative argument and degree.")
    ratio = x / (degree + 2)
    if ratio >= 1:
        raise ValueError("The geometric tail ratio must be less than one.")
    term = Fraction(1)
    total = term
    for k in range(1, degree + 1):
        term *= x / k
        total += term
    first_omitted = term * x / (degree + 1)
    return total + first_omitted / (1 - ratio)


def log_two_lower(terms: int) -> Fraction:
    """Positive truncated atanh series: log 2 > 2 sum 3^(-2j-1)/(2j+1)."""
    if terms < 1:
        raise ValueError("At least one term is required.")
    return 2 * sum(
        (Fraction(1, (2 * j + 1) * 3 ** (2 * j + 1)) for j in range(terms)),
        Fraction(0),
    )


def pole_loss_upper(width: Fraction) -> Fraction:
    """Bound 2 sinh(width/2)-width by its odd Taylor series and a tail ratio."""
    if width < 0 or width > Fraction(1, 6):
        raise ValueError("The certified width must lie in [0, 1/6].")
    x = width / 2
    return x**3 / (3 * (1 - x**2 / 20))


def checked(condition: bool, description: str) -> None:
    if not condition:
        raise RuntimeError(f"Certificate failed: {description}")


def rational(value: Fraction) -> str:
    return f"{value.numerator}/{value.denominator}"


def certificate() -> dict[str, object]:
    log_two = log_two_lower(5)
    harmonic = sum((Fraction(1, k) for k in range(1, 257)), Fraction(0))
    gamma_upper = harmonic - 8 * log_two
    checked(gamma_upper < Fraction(29, 50), "Euler constant upper corner")

    wide_log_exp = exp_upper(Fraction(129, 200), 14)
    narrow_log_exp = exp_upper(Fraction(109, 50), 30)
    checked(wide_log_exp < Fraction(21, 11), "exp(129/200) < 21/11")
    checked(narrow_log_exp < Fraction(98, 11), "exp(109/50) < 98/11")

    width = Fraction(1, 6)
    rho_corner = (Fraction(1, 4) + width / 16) / (1 - width)
    checked(rho_corner == Fraction(5, 16), "regular kernel corner")
    gamma_margin = Fraction(129, 200) - Fraction(29, 50) - Fraction(5, 96)
    checked(gamma_margin == Fraction(31, 2400), "wide gamma margin")
    pole_upper = pole_loss_upper(width)
    checked(pole_upper < Fraction(1, 1000), "wide negative pole budget")
    full_margin = gamma_margin - Fraction(1, 1000)
    checked(full_margin == Fraction(143, 12000), "wide complete Weil margin")
    checked(full_margin > Fraction(1, 100), "wide margin > 1/100")

    narrow_gamma = Fraction(109, 50) - Fraction(29, 50) - Fraction(5, 448)
    narrow_full = narrow_gamma - Fraction(1, 1000)
    checked(narrow_full > Fraction(19, 12), "narrow complete Weil margin > 19/12")
    two_window = Fraction(19, 12) - Fraction(3, 4) - Fraction(1, 28)
    checked(two_window == Fraction(67, 84), "complete two-window margin")
    checked(two_window - Fraction(23, 42) == Fraction(1, 4), "two-window gain")

    return {
        "status": "all exact rational checks passed",
        "scope": "finite constants only; analytic identities and bounds are written proofs",
        "wide_width": "1/6",
        "narrow_width": "1/28",
        "log_two_lower": rational(log_two),
        "gamma_upper_from_harmonic_256": rational(gamma_upper),
        "gamma_upper_corner": "29/50",
        "exp_129_over_200_upper": rational(wide_log_exp),
        "exp_109_over_50_upper": rational(narrow_log_exp),
        "regular_kernel_upper_corner": rational(rho_corner),
        "negative_pole_loss_upper": rational(pole_upper),
        "wide_gamma_margin": rational(gamma_margin),
        "wide_complete_weil_margin": rational(full_margin),
        "narrow_gamma_margin": rational(narrow_gamma),
        "narrow_complete_weil_margin": rational(narrow_full),
        "narrow_stated_margin": "19/12",
        "two_window_margin": rational(two_window),
        "two_window_previous_margin": "23/42",
        "two_window_gain": "1/4",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="Write the exact certificate JSON.")
    args = parser.parse_args()
    payload = certificate()
    encoded = json.dumps(payload, indent=2, sort_keys=True) + "\n"
    if args.output is not None:
        args.output.write_text(encoded, encoding="utf-8")
        print(f"All exact rational checks passed; wrote {args.output}.")
    else:
        print(encoded, end="")


if __name__ == "__main__":
    main()
