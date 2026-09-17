"""Reproducible interval/rational checks for the three-rate Weil note.

Requires python-flint 0.9.0 for the rigorous xi signs. All other comparisons
use exact Python fractions. The analytic zero-count and Weil-form steps are
proved separately in the accompanying written note.
"""

from fractions import Fraction as Q
from math import factorial

from flint import acb, arb, ctx


def exp_upper(x, n=20):
    """Exact rational upper bound for exp(x), 0 <= x < n+2."""
    return sum(x**k / factorial(k) for k in range(n + 1)) + (
        x ** (n + 1) / factorial(n + 1)
    ) / (1 - x / (n + 2))


assert exp_upper(Q(2351, 1000)) < Q(21, 2)

# Machin's identity and alternating arctangent bounds.
x = Q(1, 5)
y = Q(1, 239)
pi_lower = 16 * (x - x**3 / 3 + x**5 / 5 - x**7 / 7) - 4 * y
pi_upper = 16 * (x - x**3 / 3 + x**5 / 5 - x**7 / 7 + x**9 / 9) - 4 * (y - y**3 / 3)
assert pi_lower > Q(3141, 1000)
assert pi_upper < Q(22, 7)
assert exp_upper(Q(253, 100)) < Q(3141, 250)  # 4 * 3.141

# H_n - log(n+1/2) decreases to Euler's constant.
H10 = sum(Q(1, k) for k in range(1, 11))
gamma_upper = H10 - Q(2351, 1000)
S_quarter_upper = 1 + gamma_upper / 2 - Q(253, 200)
assert gamma_upper == Q(9103, 15750)
assert S_quarter_upper == Q(1511, 63000) < Q(24, 1000)
print("elementary S(1/4) upper:", S_quarter_upper)

# With pi < 22/7 and s >= 100.5, this gives the large-a F > 1.3
# margin. The other two checks bound s*2^-s and s^2*2^-s for s >= 100;
# both functions decrease on that range.
assert exp_upper(Q(27, 10)) < Q(175, 11)
assert 5 * Q(1, 2) ** 100 < Q(1, 20)
assert 5 * 100 * Q(1, 2) ** 100 < Q(1, 100)
assert 5 * 10000 * Q(1, 2) ** 100 < Q(1, 10)

# The finite-interval curvature margin and the high-zero dyadic tail.
tmax = 10**4
T = 3 * 10**12
c0_lower = Q(2 * 216**2, (tmax + 225) ** 3 * (tmax + 484) ** 3)
assert c0_lower > Q(75, 10**21)  # 7.5e-20

# Uniform Taylor coefficient for one off-line quartet, derivative n <= 2.
for n in range(3):
    m = n + 1
    packet_coefficient = factorial(n) * (Q(m, 2) + m * (m + 1) * 2 ** (n + 4))
    assert packet_coefficient <= 1539 < 2000

tail = [Q(8000, 1) / (1 - Q(1, 2) ** (2 * n + 2)) * Q(1, T) ** (2 * n + 2)
        for n in range(3)]
assert tail[0] < Q(12, 10**22)
assert tail[1] < Q(11, 10**47)
assert tail[2] < Q(12, 10**72)
assert S_quarter_upper + tail[0] < Q(24, 1000)
curvature_error = (Q(24, 1000) * tail[2] + Q(768, 1000) * tail[0]
                   + tail[0] * tail[2] + Q(384, 1000) * tail[1]
                   + 2 * tail[1] ** 2)
assert curvature_error < Q(1, 10**21)

ctx.dps = 50


def Xi(t):
    s = acb(arb(1) / 2, arb(t))
    return (s * (s - 1) / 2) * (arb.pi() ** (-s / 2)) * (s / 2).gamma() * s.zeta()


for t, sign in [(14, 1), (15, -1), (21, -1), (22, 1)]:
    value = Xi(t)
    assert value.imag.contains(0)
    if sign > 0:
        assert value.real > 0
    else:
        assert value.real < 0
    print("Xi(", t, ") real ball:", value.real)
