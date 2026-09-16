"""Ball-arithmetic checks for the finite sum in the renewal cosine sign proof.

Run with python-flint installed. The analytic alternating-series tail is
proved separately in the accompanying note; this script checks only two
strict finite inequalities, not a numerical approximation to an infinite sum.
"""

from flint import acb, arb, ctx

ctx.dps = 50
s = acb(arb(1) / 2, 12)
denominator = 1 - acb(2) ** (1 - s)
eta_512 = acb(0)
for n in range(1, 513):
    eta_512 += (-1) ** (n - 1) * acb(n) ** (-s)
z_512 = eta_512 / denominator

assert z_512.imag < -arb(37) / 50
assert abs(denominator) > 2

print("Im eta_512 / (1 - 2^(1-s)):", z_512.imag)
print("|1 - 2^(1-s)|:", abs(denominator))
print("Both strict interval inequalities certified.")
