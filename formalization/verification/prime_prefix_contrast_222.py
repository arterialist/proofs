"""Exact-rational certificate that psi(222) - Psi_1(222) < -19/1000.

For 0 <= z <= 1/3, log((1+z)/(1-z)) equals the positive atanh
series. After M terms, its tail is at most
2*z**(2*M+1)/((2*M+1)*(1-z*z)). Every interval below is rational.
"""

from fractions import Fraction
from math import isqrt


Q = Fraction
M = 5
N = 222


def atanh_log_bounds(z: Fraction) -> tuple[Fraction, Fraction]:
    assert 0 <= z <= Q(1, 3)
    lower = sum((2 * z ** (2 * j + 1) / (2 * j + 1) for j in range(M)), Q(0))
    remainder = 2 * z ** (2 * M + 1) / ((2 * M + 1) * (1 - z * z))
    return lower, lower + remainder


LOG2_LOWER, LOG2_UPPER = atanh_log_bounds(Q(1, 3))


def log_bounds(n: int) -> tuple[Fraction, Fraction]:
    if n == 1:
        return Q(0), Q(0)
    k = n.bit_length() - 1
    r = Q(n, 2**k)
    z = (r - 1) / (r + 1)
    lower, upper = atanh_log_bounds(z)
    return k * LOG2_LOWER + lower, k * LOG2_UPPER + upper


def is_prime(n: int) -> bool:
    return n >= 2 and all(n % d for d in range(2, isqrt(n) + 1))


log_n_lower, log_n_upper = log_bounds(N)
upper_sum = Q(0)
prime_power_count = 0

for p in range(2, N + 1):
    if not is_prime(p):
        continue
    log_p_lower, log_p_upper = log_bounds(p)
    q = p
    while q <= N:
        log_q_lower, log_q_upper = log_bounds(q)
        factor_lower = 1 - log_n_upper + log_q_lower
        factor_upper = 1 - log_n_lower + log_q_upper
        upper_sum += max(
            log_p_lower * factor_lower,
            log_p_lower * factor_upper,
            log_p_upper * factor_lower,
            log_p_upper * factor_upper,
        )
        prime_power_count += 1
        if q > N // p:
            break
        q *= p

assert prime_power_count == 61
assert upper_sum < Q(-19, 1000)
print("psi(222) - Psi_1(222) < -19/1000; exact rational certificate passed")
