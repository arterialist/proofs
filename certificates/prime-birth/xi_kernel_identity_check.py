"""Independent check of identity (K) of building-blocks/weil-and-spectral/admissible-systems-xi-kernel-comparison.md
for polynomial weights. For an even polynomial w and the kernel h_w with transform w(t) Xi(t)^2, the explicit formula
gives 2 sum_n Lambda(n) n^(-1/2) h_w(log n) = W0(h_w), because the sum over zeros vanishes identically. Written out,
     B(w) := 2 sum_n Lambda(n) n^(-1/2) h_w(log n) / h_w(0) = [ pi w(i/2) + int w Xi^2 Omega dt ] / int w Xi^2 dt,
with Omega(t) = Re psi(1/4 + it/2) - log pi and w(i/2) = sum_r alpha_r (-1/4)^r. The right side involves no primes.
The left sides below were computed separately from the 50-digit kernel table (xi_kernel_explicit_kernel.py).

Outcome, 10 November 2026 (30 digits, ordinary quadrature):
   w = 1:       right side 0.0751971327,    left side 7.519713e-2
   degree 8:    right side 0.000669855513,  left side 6.6985551e-4
   degree 12:   right side 8.34609659e-5,   left side 8.3460966e-5"""
import mpmath as mp
mp.mp.dps = 30
xi = lambda s: mp.mpf(0.5) * s * (s - 1) * mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)
Xi2 = lambda t: mp.re(xi(mp.mpc(0.5, t))) ** 2
Om = lambda t: mp.re(mp.digamma(mp.mpc(0.25, t / 2))) - mp.log(mp.pi)
for name, alpha, Bprime in [("w = 1", [1], "7.519713e-2"), ("degree 8", ["2.27942", "0.0506854", "0.000783157", "2.13792e-6", "7.48483e-8"], "6.6985551e-4"),
                            ("degree 12", ["2.258739", "0.05216107", "0.0007103534", "4.97466e-6", "4.918306e-8", "0", "1.584807e-12"], "8.3460966e-5")]:
    a = [mp.mpf(x) for x in alpha]
    w = lambda t: sum(a[r] * t ** (2 * r) for r in range(len(a)))
    wi = sum(a[r] * (mp.mpf(-1) / 4) ** r for r in range(len(a)))
    den = 2 * mp.quad(lambda t: w(t) * Xi2(t), mp.linspace(0, 100, 101))
    num = mp.pi * wi + 2 * mp.quad(lambda t: w(t) * Xi2(t) * Om(t), mp.linspace(0, 100, 101))
    print(f"{name}: prime-free formula gives B = {mp.nstr(num / den, 9)};  prime-side value {Bprime};  h_w(0) = {mp.nstr(den / (2 * mp.pi), 12)}")
