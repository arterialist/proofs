"""Actual p=2, N=2 complete anticausal energy comparison.

Arb verifies only the final finite arithmetic bound. All power tails,
negative-age intervals, and the unbounded physical tail are enclosed
analytically in prime-two-anticausal-energy.md.
"""
from flint import arb, ctx

ctx.prec = 192
log2 = arb(2).log()
A = 2 - log2
kappa = 2 * arb(2).sqrt() - 1 - log2 / arb(2).sqrt() - arb.pi() * A / 4
assert A > 0
assert kappa > 0

cells = 64
powers = 16
negative_age_norm_upper = arb(0)
for i in range(cells):
    z = 1 + arb(i) / cells
    partial = sum((1 / (1 + arb(2) ** k * z) for k in range(powers)), arb(0))
    # R(z) tail <= 2^(1-powers)/z; its A/2 factor is included here.
    F_upper = A * partial / 2 + (kappa + A * arb(2) ** (-powers)) / z
    # F is positive and decreasing on [1,2], so use the left cell endpoint.
    negative_age_norm_upper += F_upper ** 2 / (2 * cells)

remaining_norm_upper = A ** 2 / 18 * (arb(3) / 2 - 2 * log2)
new_energy_upper = 4 * (negative_age_norm_upper + remaining_norm_upper)
old_energy = 1 + A ** 2 / 2 - A ** 2 * log2 ** 2 / 4
change_upper = new_energy_upper - old_energy

assert new_energy_upper < arb("1.542105")
assert old_energy > arb("1.648795")
assert change_upper < -arb(1) / 10
print("Actual kappa_2:", kappa)
print("Norm upper on x<1/2, including every negative-age interval:", negative_age_norm_upper)
print("Norm upper on x>=1/2, including its entire infinite tail:", remaining_norm_upper)
print("New energy upper:", new_energy_upper)
print("Old energy, exact formula:", old_energy)
print("Upper bound for the full energy change:", change_upper)
print("Certified: full energy change < -1/10.")
