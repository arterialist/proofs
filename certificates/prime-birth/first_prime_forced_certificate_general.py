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
With a list of known primes p1,p2,... the script subtracts their true contribution 2 sum (log p/sqrt q) h(log q) over the
powers q = p^k < e^L, and the conclusion is about a nonnegative measure mu' supported above log(largest known prime):
if W0(h) - known - 2 int h dmu' >= 0 then mu' has mass at least |W0(h) - known|/(2 max|h^-|) where h < 0 there.
Usage: python3 first_prime_forced_certificate_general.py L c1,c2,... [mesh ratio, default 1.001] [d, default 1e-4] [known primes p1,p2,...]

Outcome, 10 November 2026 (all printed bounds rounded outward).
  L = 1, c = (1), ratio 1.005, d = 0.001:  W0(h) in [-0.125721, -0.107629]; mass >= 0.2152 between 1.3294 and 2.7183.
     (agrees with first_prime_forced_certificate.py)
  L = 0.8, c = (1, 0.192, 0.103), ratio 1.0005, d = 0.0001 (about 30 s):
     W0(h) in [-0.016499, -0.014629];  h >= 0 on [0, 0.249359];  h >= -0.202793;
     mass >= 0.0360 at positions between 1.2832 and e^0.8 < 2.2256.
With known primes (ratio 1.0005 or 1.001, d = 0.0001); "W" is W0(h) minus the known primes' contribution:
  known 2, L = 1.25, c = (0.521, 1, 0.318):  W in [-0.147558, -0.141107]; above log 2, h >= 0 outside (0.758874, 1.25)
     and h >= -0.401919; remaining mass >= 0.1755 between x = 2.1358 and 3.4904.
  known 2, 3 (and 4), L = 1.75, c = (0.396, 0.749, 1):  W in [-0.164271, -0.137134]; above log 3, h >= 0 outside
     (1.210736, 1.75) and h >= -0.642174; remaining mass >= 0.1067 between x = 3.3559 and 5.7547.
  known 2, 3, 5 (and 4), L = 2.05, c = (0.262, 0.514, 0.749, 1, 0.772):  W in [-0.268578, -0.187416]; above log 5,
     h >= 0 outside (1.631696, 2.05) and h >= -1.130037; remaining mass >= 0.0829 between x = 5.1125 and 7.7680.
  known 2, 3, 5, 7 (and 4, 8, 9), L = 2.5, c = (0.275, 0.534, 0.759, 0.927, 1, 0.831):  W in [-0.327673, -0.154230];
     above log 7, h >= 0 outside (2.056873, 2.5) and h >= -1.978347; remaining mass >= 0.0389 between x = 7.8214 and 12.1826.
  known 2, 3, 5, 7, 11 (and 4, 8, 9), L = 2.68, c = (0.233, 0.459, 0.670, 0.857, 1):  W in [-0.255932, -0.148844];
     above log 11, h >= 0 outside (2.397794, 2.68) and h >= -1.205473; remaining mass >= 0.0617 between x = 11 and 14.5852.
  known primes to 13 (and 4, 8, 9, 16), L = 2.93, c = (0.238, 0.466, 0.673, 0.846, 0.963, 0.980, 1), ratio 1.0003:
     W in [-0.307194, -0.213092]; above log 13, h >= 0 outside (2.564920, 2.93) and h >= -2.808533;
     remaining mass >= 0.0379 between x = 13 and 18.7277.
  known primes to 17 (and 4, 8, 9, 16), L = 3.03, c = (0.175, 0.347, 0.514, 0.672, 0.823, 1, 0.338), ratio 1.0003:
     W in [-0.153067, -0.096856]; above log 17, h >= 0 outside (2.833200, 3.03) and h >= -1.034131;
     remaining mass >= 0.0468 between x = 17 and 20.6973.
  known primes to 19 (and 4, 8, 9, 16, 25), L = 3.25, c = (0.121, 0.238, 0.348, 0.447, 0.527, 0.563, 0.267, 1), ratio 1.0003:
     W in [-0.335221, -0.283644]; above log 19, h >= 0 outside (2.944336, 3.25) and h >= -1.206172;
     remaining mass >= 0.1175 between x = 19 and 25.7904.
  known primes to 23 (and 4, 8, 9, 16, 25, 27, 32), L = 3.47, c = (0.205, 0.402, 0.586, 0.747, 0.876, 0.960, 1, 0.409),
     ratio 1.0003:  W in [-0.298627, -0.185814]; above log 23, h >= 0 outside (3.135490, 3.47) and h >= -3.124455;
     remaining mass >= 0.0297 between x = 23 and 32.1368 (this interval contains both 29 and 31).
  known primes to 29 (and 4, 8, 9, 16, 25, 27, 32), L = 3.55, c = (0.164, 0.326, 0.482, 0.630, 0.766, 0.890, 1, 0.042),
     ratio 1.0003:  W in [-0.384117, -0.300192]; above log 29, h >= 0 outside (3.367173, 3.55) and h >= -1.008724;
     remaining mass >= 0.1487 between x = 29 and 34.8134.
An independent review on the same day rederived the closed forms and reran the cases up to L = 2.05; the last seven
rows were added after it.
Unconditional statements about the pole and archimedean functional. They say nothing about RH."""
import sys, math
from mpmath import iv, mp
iv.dps = 30
KNOWN = [int(v) for v in sys.argv[5].split(",")] if len(sys.argv) > 5 else []
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
pts = [D0]; top = float(L.a)                                        # interior mesh points are exact binary floats below L
while pts[-1] * RATIO < top: pts.append(pts[-1] * RATIO)
d = iv.mpf(pts[0])
I = iv.mpf([-1, 1]) * (iv.mpf("2.5") * h0 + G * d) / (2 * (1 - d)) * d
for lo, hi in zip(pts[:-1], pts[1:]): I += (iv.mpf(hi) - iv.mpf(lo)) * F(iv.mpf([lo, hi]))
last = iv.mpf(pts[-1]); I += (L - last) * F(iv.mpf([last.a, L.b]))  # last cell [pts[-1], L], with L as an interval
S = sum(c[j] * w[j] / (w[j] * w[j] + iv.mpf(1) / 4) for j in range(J))
pole = -4 * ((iv.exp(L / 2) + iv.exp(-L / 2)) / 2 - 1) * S * S
W0 = pole - (gamma + iv.log(pi)) * h0 + 2 * I - h0 * iv.log(1 - iv.exp(-2 * L))
dn = lambda x: math.floor(float(iv.mpf(x).a) * 1e6 - 1) / 1e6
up = lambda x: math.ceil(float(iv.mpf(x).b) * 1e6 + 1) / 1e6
print(f"L = {Ls}, coefficients {cs}, {len(pts)} subintervals;  h(0) = |g|^2 in [{dn(h0.a):.6f}, {up(h0.b):.6f}]")
print(f"W0(h) in [{dn(W0.a):.6f}, {up(W0.b):.6f}]")
W = W0; ustart = iv.mpf(0)
for p in KNOWN:
    q = p
    while iv.log(iv.mpf(q)).b < L.a:
        W = W - 2 * iv.log(iv.mpf(p)) / iv.sqrt(iv.mpf(q)) * h(iv.log(iv.mpf(q))); q *= p
    assert not (iv.log(iv.mpf(q)).a <= L.b and iv.log(iv.mpf(q)).b >= L.a), "a prime power sits at e^L"
if KNOWN:
    ustart = iv.log(iv.mpf(max(KNOWN)))
    print(f"with the known primes {KNOWN} and their powers below e^L subtracted: W(h) in [{dn(W.a):.6f}, {up(W.b):.6f}]")
if up(W.b) >= 0: print("NOT certified: the upper bound is not negative"); sys.exit(1)
N = 20000; hmin = iv.mpf(0); first_neg = None; last_neg = None
for k in range(N):
    X = L * iv.mpf([iv.mpf(k) / N, iv.mpf(k + 1) / N]); X = iv.mpf([X.a, X.b])
    if X.b <= ustart.a: continue                                    # cells at or below the largest known prime carry no mass of mu'
    v = h(X)
    if v.a < hmin.a: hmin = iv.mpf(v.a)
    if v.a < 0:
        if first_neg is None: first_neg = k
        last_neg = k + 1
u1 = L * iv.mpf(first_neg) / N; u2 = L * iv.mpf(last_neg) / N
mass = (-iv.mpf(up(W.b))) / (2 * (-iv.mpf(dn(hmin.a))))
where = f"above log {max(KNOWN)}" if KNOWN else "on (0, L]"
print(f"{where}: h >= 0 outside ({dn(u1.a):.6f}, {up(u2.b):.6f});  h >= {dn(hmin.a):.6f}")
print(f"CERTIFIED: the functional is negative on this g. If the remaining measure is >= 0 and the functional with it is >= 0 on g,")
f4d = lambda x: math.floor(x * 1e4) / 1e4; f4u = lambda x: math.ceil(x * 1e4) / 1e4      # 4 decimals, rounded outward
print(f"           it has mass at least {f4d(dn(mass.a)):.4f} at positions x = e^u between {f4d(dn(iv.exp(iv.mpf(dn(u1.a))).a)):.4f} and {f4u(up(iv.exp(iv.mpf(up(u2.b))).b)):.4f}")
