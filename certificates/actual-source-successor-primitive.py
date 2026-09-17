"""Rigorous bounded test for the actual compensated-successor primitive.

Uses python-flint's Arb balls. No zero computation or sign inference beyond
the explicitly certified intervals is made.
"""

import math
from flint import arb, arb_series, ctx

ctx.prec = 192
one = arb(1)
K = 12
partial = arb(0)
for k in range(1, K + 1):
    s = arb(2 * k + 1) / 2
    zeta_series = arb_series([s, one], prec=2).zeta()
    D = -zeta_series[1] / zeta_series[0]
    coefficient = arb(math.comb(2 * k, k)) / (4**k * (2 * k + 1))
    partial += coefficient * D

# For k>K, D(k+1/2) <= 2^(-k-1/2) times this constant.
r0 = arb(2 * K + 1) / 2
tail_constant = arb(2).log() + 2 * arb(2).log() / r0 + 2 / r0**2
tail = tail_constant / (arb(2) ** K * arb(2).sqrt() * (2 * K + 3))
kappa_lower = arb(2789) / 10000
kappa_upper = arb(279) / 1000
assert partial > kappa_lower
assert partial + tail < kappa_upper
print("kappa partial:", partial)
print("rigorous omitted-tail upper bound:", tail)
print("certified: 2789/10000 < kappa < 279/1000")

l2, l3, l5 = arb(2).log(), arb(3).log(), arb(5).log()
# The derivative numerator is x*Lambda(n+1)-psi(n)-kappa*(x+1).
assert l2 - kappa_upper > 0
assert l3 - kappa_upper > 0
assert l5 - kappa_upper > 0
assert l2 - 2 * kappa_upper > 0
assert 2 * l3 - l2 - 3 * kappa_upper > 0
assert 4 * l2 - (l2 + l3) - 5 * kappa_lower < 0
assert 4 * l5 - (2 * l2 + l3) - 5 * kappa_upper > 0

prime_base = {2: 2, 3: 3, 4: 2, 5: 5, 7: 7, 8: 2, 9: 3,
              11: 11, 13: 13, 16: 2, 17: 17, 19: 19, 23: 23}
lam = {n: arb(prime_base[n]).log() if n in prime_base else arb(0)
       for n in range(2, 24)}
Jlower = arb(0)
psi = arb(0)
for n in range(1, 23):
    psi_next = psi + lam[n + 1]
    a, b = arb(n).sqrt(), arb(n + 1).sqrt()
    Jnext = Jlower + 2 * psi_next * (b.atan() - a.atan())
    Jnext += 2 * (psi + kappa_upper) * (1 / b - 1 / a)
    left = n * lam[n + 1] - psi - kappa_upper * (n + 1)
    right = (n + 1) * lam[n + 1] - psi - kappa_upper * (n + 2)
    if n == 1:
        assert left > 0
        assert lam[n + 1] - kappa_upper > 0
    elif lam[n + 1] == 0 or right < 0:
        assert Jnext > arb(1) / 25
    elif left > 0:
        assert Jlower > arb(1) / 25
    else:
        assert left < 0 and right > 0
        slope = lam[n + 1] - kappa_upper
        assert slope > 0
        stationary = (psi + kappa_upper) / slope
        assert stationary > n and stationary < n + 1
        z = stationary.sqrt()
        Jstationary = Jlower + 2 * psi_next * (z.atan() - a.atan())
        Jstationary += 2 * (psi + kappa_upper) * (1 / z - 1 / a)
        assert Jstationary > arb(1) / 25
        print(f"interior minimum in cell ({n},{n+1}):", stationary, Jstationary)
    Jlower = Jnext
    psi = psi_next
    if n + 1 in (4, 6):
        assert Jlower > arb(1) / 10
        print(f"rigorous lower bound for J(log({n+1})):", Jlower)
print("certified by exact cell extrema: J(v)>0 for 0<v<=log(23)")

# Trudgian's explicit unconditional psi bound, with R=6.455,
# implies |a(u)| <= C0*exp(u/2-c*sqrt(u)) for u>=log(23).
R = arb(1291) / 200
C0 = (8 / (17 * arb.pi() * one.exp())).sqrt()
c = 1 / (2 * R.sqrt())
tail_at_25 = C0 * (5 * arb(2).sqrt() - 4) * (-5 * c).exp()
assert arb(25) > arb(23).log()
assert tail_at_25 < kappa_lower
print("scaled primitive remainder bound at v=25:", tail_at_25)
print("certified with the quoted PNT theorem: J(v)>=kappa*exp(-v/2) for v>=25")

# A sharper exact integration of the two positive error kernels closes x>=23.
z23 = (arb(23).log() / R).sqrt()
assert z23 > arb(1) / 2
epsilon23 = (8 / (17 * arb.pi())).sqrt() * z23.sqrt() * (-z23).exp()
assert epsilon23 < arb(162) / 1000
assert 2 * (kappa_lower - epsilon23) > arb(1) / 5
print("relative PNT error bound for every x>=23:", epsilon23)
print("certified with the quoted PNT theorem: J(log x)>1/(5*sqrt x) for x>=23")
print("conclusion: J(0)=0 and J(v)>0 for every real v>0")
