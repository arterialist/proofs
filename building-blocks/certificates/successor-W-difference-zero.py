"""One actual critical-line zero and its nonzero successor correction.

All decisive tests use Arb/Acb enclosures. The rational zero bracket is
certified by opposite completed-xi signs, not a zero-location oracle.
The shifted-log-derivative tail is bounded analytically below.
"""
from flint import arb, acb, acb_series, ctx

ctx.prec = 256
half = arb(1) / 2
lo = arb("14.13472514173469379045")
hi = arb("14.13472514173469379046")
height = arb("14.134725141734693790455 +/- 0.000000000000000000005")
rho = acb(half, height)


def completed_xi(t):
    z = acb(half, t)
    return z * (z - 1) / 2 * acb(arb.pi()) ** (-z / 2) * (z / 2).gamma() * z.zeta()


xi_lo = completed_xi(lo)
xi_hi = completed_xi(hi)
# xi(1/2+it) is exactly real by conjugation and its functional equation.
assert xi_lo.real > arb("1e-23")
assert xi_hi.real < arb("-3e-24")
assert height > 14 and height < 15

J = 256
coefficient = acb(1)
partial = acb(0)
for j in range(1, J + 1):
    coefficient *= (rho + j - 1) / j
    w = rho + j
    zeta_series = acb_series([w, 1], prec=2).zeta()
    log_derivative = -zeta_series[1] / zeta_series[0]
    partial += coefficient * log_derivative / w

# For j >= J, |(rho+j)/(j+1)| <= 1, since Im(rho)^2 < 225
# and (j+1)^2-(j+1/2)^2 = j+3/4 > 225.
# For sigma >= J+1/2,
# D(sigma) <= 2^(-sigma) [log 2 + 2 log 2/(sigma-1)
#                                  + 2/(sigma-1)^2] < 2*2^(-sigma).
# These follow respectively from the coefficient recurrence and the
# decreasing-function integral bound on sum_{n>=2} log(n)n^(-sigma).
sigma = arb(J) + half
majorant = arb(2).log() + 2 * arb(2).log() / (sigma - 1) + 2 / (sigma - 1) ** 2
assert majorant < 2
assert abs(coefficient) < arb(10) ** 8
tail = 2 * abs(coefficient) * arb(2) ** (-sigma) / sigma
assert tail < arb("1e-70")

# The previously certified actual charge lies strictly inside this ball.
kappa = arb("0.27895 +/- 0.00005")
finite_gamma = partial - acb(kappa) / rho
error = acb(arb(0, tail), arb(0, tail))
gamma = finite_gamma + error
assert gamma.real > arb("-0.125") and gamma.real < arb("-0.124")
assert gamma.imag > arb("-0.186") and gamma.imag < arb("-0.184")

# The residue formula also needs this factor nonzero at the chosen zero.
zeta_line_one = acb(1, height).zeta()
assert zeta_line_one.real > arb("0.323")
assert zeta_line_one.real < arb("0.325")

# The unknown positive integer multiplicity multiplies this nonzero number.
residue_per_multiplicity = -2 * zeta_line_one * gamma / (rho + 1)
assert residue_per_multiplicity.real > arb("0.0095")
assert residue_per_multiplicity.real < arb("0.0097")

print("xi at lower endpoint:", xi_lo)
print("xi at upper endpoint:", xi_hi)
print("analytic tail bound:", tail)
print("Gamma on the entire zero bracket:", gamma)
print("zeta on 1+i times the entire bracket:", zeta_line_one)
print("difference residue divided by multiplicity:", residue_per_multiplicity)
print("All strict rational enclosure tests passed.")
