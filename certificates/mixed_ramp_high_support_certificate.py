"""Independent Arb constants for a high-support mixed-ramp Weil bound."""

from flint import arb, ctx

ctx.prec = 192

gamma = arb.const_euler()
kappa = arb(2).log() / 2
pi = arb.pi()
g0 = 2 - gamma - (4 * pi).log()
C = 1 - gamma - (2 * pi).log()
S = 1 - arb(2).log()

# h(u)=min(u,kappa) up to 3, then gamma-1.3/u^2. Verify the
# upward jump at u=3 and the sign needed for the gamma bound.
assert (gamma - arb(13) / 90 - kappa).lower() > 0
assert C.upper() < 0
assert (-C - S).lower() > 0

# Exact first two integrals in r(10)=e^-10 int_0^10 e^u h(u) du.
I1 = (-arb(10)).exp() * ((kappa - 1) * kappa.exp() + 1)
I2 = kappa * ((arb(3) - 10).exp() - (kappa - 10).exp())

# h increases on [3,10]. Ten left rectangles, integrating e^(u-10)
# exactly on each interval, give a rigorous lower bound.
I3_lower = arb(0)
for j in range(10):
    u = arb(3) + arb(7 * j) / 10
    v = u + arb(7) / 10
    I3_lower += (gamma - arb(13) / (10 * u * u)) * ((v - 10).exp() - (u - 10).exp())

r10_lower = I1 + I2 + I3_lower
margin = 2 * r10_lower + g0
print('gamma:', gamma)
print('kappa:', kappa)
print('g0:', g0)
print('r(10) lower:', r10_lower)
print('uniform full mixed-ramp margin:', margin)
assert r10_lower.lower() > arb('0.5584')
assert margin.lower() > arb('0.0086')
print('CERTIFIED: Q(f_L,f_M)>0.0086 for min(L,M)>=10')
