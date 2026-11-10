"""Interval-arithmetic certificate, general version of first_prime_forced_certificate.py.
Test function g(u) = sum_j c_j sin(2 pi j u / L) on [0, L], zero elsewhere, with rational coefficients c_1, c_2, ...
With w_j = 2 pi j / L, the autocorrelation for 0 <= u <= L is h(u) = sum_{j,k} c_j c_k A_jk(u),
    A_jj(u) = (1/2)(L - u) cos(w_j u) + sin(w_j u)/(2 w_j),
    A_jk(u) = (sin(w_k u) - sin(w_j u))/(2 (w_j - w_k)) + (sin(w_k u) + sin(w_j u))/(2 (w_j + w_k))      (j != k),
and h(0) = (L/2) sum c_j^2. The functional without primes is
    W0(h) = -4 (cosh(L/2) - 1) S^2 - (gamma + log pi) h(0) + 2 int_0^L F - h(0) log(1 - e^{-2L}),
    S = sum_j c_j w_j/(w_j^2 + 1/4),     F(u) = (e^{-2u} h(0) - e^{-u/2} h(u))/(1 - e^{-2u}).
Near 0: the numerator n of F has n(0) = 0 and |n'| <= 2.5 h(0) + G d on [0, d], G = (L/2) sum c_j^2 w_j^2 >= |h''|,
and 1 - e^{-2u} >= 2u(1 - u), so |F| <= (2.5 h(0) + G d)/(2 (1 - d)) on [0, d].
If mu >= 0 and W0(h) - 2 int h dmu >= 0 then mu({h < 0}) >= |W0(h)|/(2 max|h^-|), and {h < 0} lies in (u1, L).
Usage: python3 first_prime_forced_certificate_general.py L c1,c2,... [mesh ratio, default 1.001] [d, default 1e-4]

Outcome, 10 November 2026.
  L = 1, c = (1), ratio 1.005, d = 0.001:  W0(h) in [-0.125721, -0.107629]; mass >= 0.2152 between 1.3295 and e.
     (agrees with first_prime_forced_certificate.py)
  L = 0.8, c = (1, 0.192, 0.103), ratio 1.0005, d = 0.0001 (17979 subintervals, about 30 s):
     W0(h) in [-0.016499, -0.014629];  h >= 0 on [0, 0.249359];  h >= -0.202793;
     mass >= 0.0360 at positions between 1.2832 and e^0.8 = 2.2255.
Unconditional statements about the pole and archimedean functional. They say nothing about RH."""
import sys, math
from mpmath import iv, mp
iv.dps = 30
Ls = sys.argv[1]; cs = sys.argv[2].split(","); RATIO = float(sys.argv[3]) if len(sys.argv) > 3 else 1.001; D0 = float(sys.argv[4]) if len(sys.argv) > 4 else 1e-4
L = iv.mpf(Ls); c = [iv.mpf(x) for x in cs]; J = len(c); pi = iv.pi
w = [2 * pi * (j + 1) / L for j in range(J)]
gamma = iv.mpf(["0.5772156649015328", "0.5772156649015329"])
def h(u):
    s = iv.mpf(0)
    for j in range(J):
        for k in range(J):
            if j == k: A = (L - u) * iv.cos(w[j] * u) / 2 + iv.sin(w[j] * u) / (2 * w[j])
            else: A = (iv.sin(w[k] * u) - iv.sin(w[j] * u)) / (2 * (w[j] - w[k])) + (iv.sin(w[k] * u) + iv.sin(w[j] * u)) / (2 * (w[j] + w[k]))
            s += c[j] * c[k] * A
    return s
h0 = L / 2 * sum(x * x for x in c); G = L / 2 * sum(c[j] * c[j] * w[j] * w[j] for j in range(J))
def F(u): return (iv.exp(-2 * u) * h0 - iv.exp(-u / 2) * h(u)) / (1 - iv.exp(-2 * u))
# sanity check of the closed form of h against direct numerical integration (not part of the proof)
Lf = float(mp.mpf(Ls)); cf = [float(mp.mpf(x)) for x in cs]
gf = lambda v: sum(cf[j] * mp.sin(2 * mp.pi * (j + 1) * v / Lf) for j in range(J))
for u0 in (0.0, 0.3 * Lf, 0.69 * Lf, 0.95 * Lf):
    direct = mp.quad(lambda v: gf(v) * gf(v - u0), [u0, Lf]); closed = mp.mpf(h(iv.mpf(u0)).mid)
    assert abs(direct - closed) < 1e-10, (u0, direct, closed)
pts = [D0]; top = float(L.b)
while pts[-1] < top: pts.append(min(pts[-1] * RATIO, top))
d = iv.mpf(pts[0])
I = iv.mpf([-1, 1]) * (iv.mpf("2.5") * h0 + G * d) / (2 * (1 - d)) * d
for lo, hi in zip(pts[:-1], pts[1:]): I += (iv.mpf(hi) - iv.mpf(lo)) * F(iv.mpf([lo, hi]))
I += iv.mpf(["-1e-20", "1e-20"])                                      # the mesh ends within 1e-29 of L; F is bounded near L
S = sum(c[j] * w[j] / (w[j] * w[j] + iv.mpf(1) / 4) for j in range(J))
pole = -4 * ((iv.exp(L / 2) + iv.exp(-L / 2)) / 2 - 1) * S * S
W0 = pole - (gamma + iv.log(pi)) * h0 + 2 * I - h0 * iv.log(1 - iv.exp(-2 * L))
dn = lambda x: math.floor(float(iv.mpf(x).a) * 1e6 - 1) / 1e6
up = lambda x: math.ceil(float(iv.mpf(x).b) * 1e6 + 1) / 1e6
print(f"L = {Ls}, coefficients {cs}, {len(pts)-1} subintervals;  h(0) = |g|^2 in [{dn(h0.a):.6f}, {up(h0.b):.6f}]")
print(f"W0(h) in [{dn(W0.a):.6f}, {up(W0.b):.6f}]")
if up(W0.b) >= 0: print("NOT certified: the upper bound is not negative"); sys.exit(1)
N = 20000; hmin = iv.mpf(0); first_neg = None
for k in range(N):
    X = L * iv.mpf([iv.mpf(k) / N, iv.mpf(k + 1) / N]); X = iv.mpf([X.a, X.b]); v = h(X)
    if v.a < hmin.a: hmin = iv.mpf(v.a)
    if v.a < 0 and first_neg is None: first_neg = k
u1 = L * iv.mpf(first_neg) / N
mass = (-iv.mpf(up(W0.b))) / (2 * (-iv.mpf(dn(hmin.a))))
print(f"h >= 0 on [0, {dn(u1.a):.6f}];  h >= {dn(hmin.a):.6f} on [0, L]")
print(f"CERTIFIED: W0(h) < 0. If mu >= 0 and W0(h) - 2 int h dmu >= 0, then mu(({dn(u1.a):.6f}, {Ls})) >= {dn(mass.a):.6f},")
print(f"           that is, mass at least {dn(mass.a):.4f} at positions x = e^u between {dn(iv.exp(iv.mpf(dn(u1.a))).a):.4f} and e^L = {up(iv.exp(L).b):.4f}")
