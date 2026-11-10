"""Independent check of identity (K) of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md
for polynomial weights. For an even polynomial w and the kernel h_w with transform w(t) Xi(t)^2, the explicit formula
gives 2 sum_n Lambda(n) n^(-1/2) h_w(log n) = W0(h_w), because the sum over zeros vanishes identically. Written out,
     2 sum_n Lambda(n) n^(-1/2) h_w(log n) / h_w(0) = [ pi w(i/2) + int w Xi^2 Omega dt ] / int w Xi^2 dt,          (K')
with Omega(t) = Re psi(1/4 + it/2) - log pi and w(i/2) = sum_r alpha_r (-1/4)^r. The right side involves no primes.
This script computes both sides by ordinary quadrature at 30 digits: the left side from
h_w(u) = (1/pi) int_0^inf w(t) Xi(t)^2 cos(tu) dt at u = log n for the prime powers n <= 40 (later terms are below 1e-30).
The kernels are w = 1 and the two rounded safety-margin kernels of xi_kernel_explicit_kernel.py (degrees 8 and 12).

Outcome, 10 November 2026 (about six minutes):
   w = 1:       prime side 0.0751971326975,  prime-free side 0.0751971326975
   degree 8:    prime side 0.000669855513265,  prime-free side 0.000669855513265
   degree 12:   prime side 8.3460965877e-5,  prime-free side 8.3460965877e-5"""
import mpmath as mp
mp.mp.dps = 30
xi = lambda s: mp.mpf(0.5) * s * (s - 1) * mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)
Xi2 = lambda t: mp.re(xi(mp.mpc(0.5, t))) ** 2
Om = lambda t: mp.re(mp.digamma(mp.mpc(0.25, t / 2))) - mp.log(mp.pi)
def vonm(n):
    for p in range(2, n + 1):
        if all(p % d for d in range(2, int(p**0.5) + 1)):
            q = p
            while q < n: q *= p
            if q == n: return mp.log(p)
    return mp.mpf(0)
grid = mp.linspace(0, 100, 201)
for name, alpha in [("w = 1", ["1"]), ("degree 8", ["2.27942", "0.0506854", "0.000783157", "2.13792e-6", "7.48483e-8"]),
                    ("degree 12", ["2.258739", "0.05216107", "0.0007103534", "4.97466e-6", "4.918306e-8", "0", "1.584807e-12"])]:
    a = [mp.mpf(x) for x in alpha]
    w = lambda t: sum(a[r] * t ** (2 * r) for r in range(len(a)))
    wi = sum(a[r] * (mp.mpf(-1) / 4) ** r for r in range(len(a)))
    den = 2 * mp.quad(lambda t: w(t) * Xi2(t), grid)
    free = (mp.pi * wi + 2 * mp.quad(lambda t: w(t) * Xi2(t) * Om(t), grid)) / den
    h = lambda u: mp.quad(lambda t: w(t) * Xi2(t) * mp.cos(t * u), grid) / mp.pi
    prime = 2 * sum(vonm(n) / mp.sqrt(n) * h(mp.log(n)) for n in range(2, 41) if vonm(n) > 0) / (den / (2 * mp.pi))
    print(f"{name}: prime side {mp.nstr(prime, 12)},  prime-free side {mp.nstr(free, 12)}")
