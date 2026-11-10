"""Interval-arithmetic certificate: the pole and archimedean part of Weil's functional is negative on one explicit
test function, so every nonnegative "prime" measure that makes the functional nonnegative on it has mass near 2.

Test function: g(u) = sin(2 pi u) for 0 <= u <= 1, zero elsewhere. Its autocorrelation, for 0 <= u <= 1, is
    h(u) = int g(v) g(v - u) dv = (1/2)(1 - u) cos(2 pi u) + sin(2 pi u)/(4 pi),      h(-u) = h(u),  h = 0 for |u| >= 1.
Functional without primes (see building-blocks/weil-and-spectral/weil-positivity-forces-the-primes.md, section 1):
    W0(h) = pole + A,
    pole  = 2 g^(i/2) g^(-i/2) = -4 a^2 (cosh(1/2) - 1)/(a^2 + 1/4)^2,   a = 2 pi,
    A     = -(gamma + log pi) h(0) + 2 int_0^1 (e^{-2u} h(0) - e^{-u/2} h(u))/(1 - e^{-2u}) du - h(0) log(1 - e^{-2}).
For a nonnegative measure mu on (0, infinity) the functional with mu in place of the primes is W0(h) - 2 int h dmu.
If that is >= 0 then int h dmu <= W0(h)/2 < 0, so mu({h < 0}) >= |W0(h)| / (2 max|h^-|).

The script encloses every quantity in intervals (mpmath.iv), so the printed inequalities are rigorous up to the
correctness of mpmath's interval arithmetic and of this code. Near u = 0 the integrand F is bounded by hand:
its numerator n(u) = e^{-2u}/2 - e^{-u/2} h(u) has n(0) = 0 and |n'| <= 1 + 0.3 + 2 pi^2 d on [0, d], and
1 - e^{-2u} >= 2u(1 - u), so |F| <= (1.3 + 2 pi^2 d)/(2 (1 - d)) there.

Outcome, 10 November 2026 (mpmath interval arithmetic at 30 digits, 1386 subintervals, about one second):
   W0(h) in [-0.125771, -0.107579], so W0(h) < 0.
   h >= 0 on [0, 0.2848] and h >= -0.250026 on [0, 1].
   Hence mu((0.2848, 1)) >= 0.215: mass at least 0.215 at positions x = e^u between 1.329 and e.
This statement is unconditional. It does not use RH and says nothing about RH."""
from mpmath import iv, mp
iv.dps = 30
pi = iv.pi; a = 2 * pi; half = iv.mpf(1) / 2
gamma = iv.mpf(["0.5772156649015328", "0.5772156649015329"])
def h(u): return half * (1 - u) * iv.cos(2 * pi * u) + iv.sin(2 * pi * u) / (4 * pi)
def F(u): return (iv.exp(-2 * u) * half - iv.exp(-u / 2) * h(u)) / (1 - iv.exp(-2 * u))
# sanity check of the closed form of h against direct numerical integration (not part of the proof)
for u0 in (0.0, 0.3, 0.69, 0.95):
    direct = mp.quad(lambda v: mp.sin(2 * mp.pi * v) * mp.sin(2 * mp.pi * (v - u0)), [u0, 1])
    closed = 0.5 * (1 - u0) * mp.cos(2 * mp.pi * u0) + mp.sin(2 * mp.pi * u0) / (4 * mp.pi)
    assert abs(direct - closed) < 1e-12, (u0, direct, closed)
# 1. the integral I = int_0^1 F
pts = [0.001]                                                       # mesh points are exact binary floats
while pts[-1] < 1.0: pts.append(min(pts[-1] * 1.005, 1.0))
d = iv.mpf(pts[0])
Fbound = (iv.mpf("1.3") + 2 * pi * pi * d) / (2 * (1 - d))
I = iv.mpf([-1, 1]) * Fbound * d                                    # contribution of [0, d]
for lo, hi in zip(pts[:-1], pts[1:]):
    I += (iv.mpf(hi) - iv.mpf(lo)) * F(iv.mpf([lo, hi]))             # int over [lo, hi] lies in width * F([lo, hi])
n = len(pts) - 1
pole = -4 * a * a * ((iv.exp(half) + iv.exp(-half)) / 2 - 1) / (a * a + iv.mpf(1) / 4) ** 2
A = -(gamma + iv.log(pi)) * half + 2 * I - half * iv.log(1 - iv.exp(-2))
W0 = pole + A
import math
dn = lambda x: math.floor(float(iv.mpf(x).a) * 1e6 - 1) / 1e6       # print bounds rounded outward at 6 decimals
up = lambda x: math.ceil(float(iv.mpf(x).b) * 1e6 + 1) / 1e6
print(f"subintervals: {n}")
print(f"integral I  in [{dn(I.a):.6f}, {up(I.b):.6f}]")
print(f"pole term   in [{dn(pole.a):.6f}, {up(pole.b):.6f}]")
print(f"A           in [{dn(A.a):.6f}, {up(A.b):.6f}]")
print(f"W0(h)       in [{dn(W0.a):.6f}, {up(W0.b):.6f}]")
assert up(W0.b) < 0
print("CERTIFIED: W0(h) < 0 for g = sin(2 pi u) on [0, 1]")
# 2. where h can be negative, and how negative
N = 20000; hmin = iv.mpf(0); first_neg = None
for k in range(N):
    X = iv.mpf([iv.mpf(k) / N, iv.mpf(k + 1) / N]); v = h(X)
    if v.a < hmin.a: hmin = iv.mpf(v.a)
    if v.a < 0 and first_neg is None: first_neg = k
u1 = iv.mpf(first_neg) / N
print(f"h >= 0 on [0, {dn(u1.a):.6f}];  h >= {dn(hmin.a):.6f} on [0, 1]")
mass = (-iv.mpf(up(W0.b))) / (2 * (-iv.mpf(dn(hmin.a))))
print(f"CERTIFIED: if mu >= 0 and W0(h) - 2 int h dmu >= 0, then mu((u1, 1)) >= {dn(mass.a):.6f} with u1 = {dn(u1.a):.6f},")
print(f"           that is, mass at least {math.floor(dn(mass.a) * 1e4) / 1e4:.4f} on x = e^u between {math.floor(dn(iv.exp(iv.mpf(dn(u1.a))).a) * 1e4) / 1e4:.4f} and e < 2.7183")
W0pt = (-4 * (2 * mp.pi) ** 2 * (mp.cosh(0.5) - 1) / ((2 * mp.pi) ** 2 + 0.25) ** 2 - (mp.euler + mp.log(mp.pi)) / 2
        + 2 * mp.quad(lambda u: (mp.exp(-2 * u) / 2 - mp.exp(-u / 2) * (0.5 * (1 - u) * mp.cos(2 * mp.pi * u) + mp.sin(2 * mp.pi * u) / (4 * mp.pi))) / (1 - mp.exp(-2 * u)), mp.linspace(0, 1, 9))
        - mp.log(1 - mp.exp(-2)) / 2)
hl2 = 0.5 * (1 - mp.log(2)) * mp.cos(2 * mp.pi * mp.log(2)) + mp.sin(2 * mp.pi * mp.log(2)) / (4 * mp.pi)
print(f"for comparison (ordinary quadrature, not part of the proof): W0(h) = {float(W0pt):.7f}, h(log 2) = {float(hl2):.6f},")
print(f"           and with the true prime 2: W0(h) - 2 h(log 2) log 2/sqrt 2 = {float(W0pt - 2 * hl2 * mp.log(2) / mp.sqrt(2)):+.5f}")
