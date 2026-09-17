"""Exploratory finite scan for the unproved Suzuki Hankel half bound.

Requires numpy, scipy, and mpmath. The grid scan is not a certificate over
continuous parameters. The interval check at (omega, x) = (1/2, 7) verifies
the counterexample to the stronger 3/4 bound.
"""

import numpy as np
from scipy.special import beta, betaincc, gamma
import mpmath as mp


OMEGAS = (0.01, 0.05, 0.10, 0.20, 0.25, 0.30, 0.40, 0.45, 0.49, 0.50)
N = 500
NUMBERS = np.arange(1, N + 1, dtype=float)


def prime_divisors_up_to(bound):
    divisors = [[] for _ in range(bound + 1)]
    for p in range(2, bound + 1):
        if not divisors[p]:
            for n in range(p, bound + 1, p):
                divisors[n].append(p)
    return divisors


PRIME_DIVISORS = prime_divisors_up_to(N)


def coefficients(omega):
    values = NUMBERS**omega
    for n in range(2, N + 1):
        for p in PRIME_DIVISORS[n]:
            values[n - 1] *= 1 - p ** (-2 * omega)
    return values


def smoothed_gamma_kernel(t, omega):
    """Suzuki's g_omega^{<1>}(t), for a vector with 0 < t < 1."""
    if omega == 0.5:
        root = np.sqrt(1 - t * t)
        return 2 / np.sqrt(t) * (2 * root + np.log(t) - np.log1p(root))
    a1 = (3 - 2 * omega) / 2
    a2 = (5 - 2 * omega) / 4
    b1 = beta(a1, omega) * betaincc(a1, omega, t * t)
    b2 = beta(a2, omega) * betaincc(a2, omega, t * t)
    return (
        4 * omega / (2 * omega - 1) * np.pi**omega / gamma(omega)
        * (t ** (omega - 1) * b1
           - (2 * omega + 1) / (4 * omega) * t ** (-0.5) * b2)
    )


def scan_omega(omega):
    coeffs = coefficients(omega)
    minimum = (float("inf"), None)
    for x in np.arange(2, 500.001, 0.25):
        # The n = x term is zero; omitting it avoids t = 1 in the formula.
        count = int(np.ceil(x)) - 1
        value = np.dot(
            coeffs[:count],
            smoothed_gamma_kernel(NUMBERS[:count] / x, omega),
        ) / np.sqrt(x)
        if value < minimum[0]:
            minimum = (float(value), float(x))
    return minimum


def phi_up_to(bound):
    phi = np.arange(bound + 1, dtype=np.int64)
    for p in range(2, bound + 1):
        if phi[p] == p:
            phi[p::p] -= phi[p::p] // p
    return phi


def integer_half_scan():
    bound = 5000
    phi = phi_up_to(bound)
    weights = phi[1:] / np.arange(1, bound + 1)
    numbers = np.arange(1, bound + 1, dtype=float)
    minimum = (float("inf"), None)
    for x in range(2, bound + 1):
        t = numbers[: x - 1] / x
        root = np.sqrt(1 - t * t)
        value = 2 * np.dot(
            weights[: x - 1],
            2 * root + np.log(t) - np.log1p(root),
        )
        if value < minimum[0]:
            minimum = (float(value), x)
    return minimum


def interval_half_at_seven():
    mp.iv.dps = 50
    phi = (0, 1, 1, 2, 2, 4, 2)
    total = mp.iv.mpf(0)
    for n in range(1, 7):
        t = mp.iv.mpf(n) / 7
        root = mp.iv.sqrt(1 - t * t)
        bracket = 2 * root + mp.iv.log(t) - mp.iv.log(1 + root)
        total += 2 * mp.iv.mpf(phi[n]) / n * bracket
    assert total.b < mp.iv.mpf("0.75")
    return total


if __name__ == "__main__":
    for omega in OMEGAS:
        value, x = scan_omega(omega)
        print(f"omega={omega:.2f} minimum={value:.12f} x={x:.2f}")
    print("integer omega=0.50 minimum:", integer_half_scan())
    print("interval omega=0.50 x=7:", interval_half_at_seven())
