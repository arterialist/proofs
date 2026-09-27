"""Independent Arb checks for the radius-one arithmetic carrier proof.

Run: uv run --with python-flint python certificates/actual_weil_radius_one_carrier1058_band.py
Every cell endpoint is rational, and Arb encloses log, sqrt, cos and arithmetic.
"""

from flint import arb, ctx

ctx.dps = 60
powers = ((2, 2), (3, 3), (4, 2), (5, 5), (7, 7))
largest = arb(0)
largest_cell = None
for j in range(400):
    t = arb(f"{1048*40 + 2*j + 1}/40", "1/40")
    left = arb(f"{1048*20 + j}/20")
    right = arb(f"{1048*20 + j + 1}/20")
    assert t.lower() <= left.lower() and right.upper() <= t.upper()
    value = sum(
        2 * arb(p).log() / arb(n).sqrt() * (t * arb(n).log()).cos()
        for n, p in powers
    )
    assert value < arb(3), (j, value)
    if value.upper() > largest.upper():
        largest, largest_cell = value, j

assert largest < arb("2.60")
print("largest Arb interval upper:", largest.upper())
print("cell:", largest_cell)

# Numerical margins in the written analytic inequalities. Arb supplies outward
# enclosures; the derivations of these expressions are in the linked notes.
pi = arb.pi()
a = arb(19) / 80
K = arb(1058)
T = arb(2500)
epsilon = arb(1) / 1000000
comb_mass = sum(2 * arb(p).log() / arb(n).sqrt() for n, p in powers)
assert comb_mass < arb("5.86")
assert (T / (2 * pi)).log() - 1 / T > arb("5.98")
assert (arb(1048) / (2 * pi)).log() - 1 / arb(1048) > 5
assert (T / (2 * pi)).log() + 1 / (15 * T) + 25 / (8 * T**2) < 6

M = 2601
chebyshev_error = 4 * (5 * T / 12).exp() * (arb(2) / 3) ** M
low_mass_bound = 2 * T / pi * chebyshev_error**2
assert low_mass_bound < arb("1e-6")

r_epsilon = 1 - epsilon**2 * (K + 1) ** 2 / 2
norm_lower = r_epsilon**2 * (K - 1) ** 4 * (1 - a**2 / 6) ** 8 / (2 * pi)
assert norm_lower > arb("1.84e11")
b = arb(10)
outside_upper = (
    (K**2 + arb(1) / 4) ** 2 / (7 * b**7)
    + (6 * K**2 + arb(1) / 2) / (5 * b**5)
    + 1 / (3 * b**3)
) / (pi * a**8)
assert outside_upper < arb("5.64e8")
assert outside_upper / norm_lower < arb(".004")

delta = 1 - K / T
C = (1 + 1 / (4 * T**2)) / (a**4 * delta**4)
assert C < 2840
high_energy_upper = C**2 / (200 * pi * T**2)
assert high_energy_upper < arb(".0021")
assert high_energy_upper / norm_lower < arb("1.2e-14")

print("comb mass upper:", comb_mass.upper())
print("high-moment low-mass upper:", low_mass_bound.upper())
print("carrier norm lower:", norm_lower.lower())
print("outside-band mass upper:", outside_upper.upper())
print("normalized high-form upper:", (high_energy_upper / norm_lower).upper())
