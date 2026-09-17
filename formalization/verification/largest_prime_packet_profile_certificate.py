from fractions import Fraction as Q
from math import factorial


def mobius(n: int) -> int:
    """Return the exact Möbius value using elementary trial division."""
    value = 1
    remaining = n
    prime = 2
    while prime * prime <= remaining:
        if remaining % prime == 0:
            remaining //= prime
            value = -value
            if remaining % prime == 0:
                return 0
        prime += 1
    if remaining > 1:
        value = -value
    return value


def exp_minus_bounds(x: Q, odd_n: int):
    """Exact alternating-series bounds for exp(-x), 0 < x <= 1."""
    assert odd_n % 2 == 1
    lo = sum(((-x) ** k) / factorial(k) for k in range(odd_n + 1))
    hi = sum(((-x) ** k) / factorial(k) for k in range(odd_n + 2))
    return lo, hi


a_lo, a_hi = exp_minus_bounds(Q(1), 13)
b_lo, b_hi = exp_minus_bounds(Q(1, 2), 11)

# Convenient decimal rational enclosures, certified by the exact series.
A_LO, A_HI = Q(367879, 10**6), Q(367880, 10**6)
B_LO, B_HI = Q(606530, 10**6), Q(606531, 10**6)
assert A_LO < a_lo < a_hi < A_HI
assert B_LO < b_lo < b_hi < B_HI

# C0 = integral_(1/2)^1 M(exp(-alpha)) dalpha
#    = sum mu(n) [exp(-n/2)-exp(-n)]/n.
N = 20
lower = Q(0)
upper = Q(0)
for n in range(1, N + 1):
    mu = mobius(n)
    diff_lo = B_LO**n - A_HI**n
    diff_hi = B_HI**n - A_LO**n
    if mu == 1:
        lower += diff_lo / n
        upper += diff_hi / n
    elif mu == -1:
        lower -= diff_hi / n
        upper -= diff_lo / n

# Absolute geometric tail; 1/n <= 1/(N+1) for n>N.
tail = B_HI ** (N + 1) / ((N + 1) * (1 - B_HI))
lower -= tail
upper += tail

assert lower > Q(53, 1000)
assert upper < Q(54, 1000)

print("Certified 0.053 < C0 < 0.054")

# Adjacent dyadic layer C1 = integral_(1/4)^(1/2) M(exp(-alpha)) d alpha.
c_lo, c_hi = exp_minus_bounds(Q(1, 4), 9)
C_LO, C_HI = Q(778800, 10**6), Q(778801, 10**6)
assert C_LO < c_lo < c_hi < C_HI

lower = Q(0)
upper = Q(0)
N = 30
for n in range(1, N + 1):
    mu = mobius(n)
    diff_lo = C_LO**n - B_HI**n
    diff_hi = C_HI**n - B_LO**n
    if mu == 1:
        lower += diff_lo / n
        upper += diff_hi / n
    elif mu == -1:
        lower -= diff_hi / n
        upper -= diff_lo / n
tail = C_HI ** (N + 1) / ((N + 1) * (1 - C_HI))
lower -= tail
upper += tail
assert Q(-61, 1000) < lower
assert upper < Q(-60, 1000)

print("Certified -0.061 < C1 < -0.060")
