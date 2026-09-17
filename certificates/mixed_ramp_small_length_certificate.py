"""Arb certificate for the complete mixed-ramp Weil sign when min(L,M)<=2/25.

Run from the repository root: python3 certificates/mixed_ramp_small_length_certificate.py
All rational values are built exactly; only exp/log/EulerGamma/pi use Arb balls.
"""
from flint import arb, ctx

ctx.prec = 192
L0 = arb(2) / 25
C = 1 - arb.const_euler() - (2 * arb.pi()).log()

# Since 0<L<=L0, the n=0,1 terms of the negative part of G_inf''
# dominate their respective values at L0; its positive part is <=-C.
concavity_gap = (arb(3) / 2) * (-3 * L0).exp() + (arb(5) / 4) * (-5 * L0).exp() + C
assert C.upper() < 0
assert concavity_gap.lower() > arb('0.6027')

# Every omitted summand d_n(1-e^{-(2n+3)L0}) is strictly positive,
# so this finite sum is a one-sided lower bound on G_inf(L0).
G_lower = C * (1 - (-L0).exp())
for n in range(1000):
    d = arb(1) / ((2 * n + 2) * (2 * n + 3))
    G_lower += d * (1 - (-(2 * n + 3) * L0).exp())

assert G_lower.lower() > arb('0.00211825')
assert (G_lower / L0).lower() > arb('0.02647')
print('C:', C)
print('uniform concavity gap:', concavity_gap)
print('one-sided G_inf(2/25) lower:', G_lower)
print('lower chord slope:', G_lower / L0)
print('CERTIFIED: Q(f_L,f_M)>0.02647*min(L,M) for 0<min(L,M)<=2/25')
