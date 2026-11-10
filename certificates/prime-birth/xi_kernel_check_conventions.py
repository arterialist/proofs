"""Check of conventions for the notes in building-blocks/weil-and-spectral on admissible systems.
Phi(u) = 2 sum (2 pi^2 n^4 e^{9u/2} - 3 pi n^2 e^{5u/2}) exp(-pi n^2 e^{2u}) (even; the series is used for u >= 0 only),
Xi(t) = int Phi(u) e^{itu} du = xi(1/2 + it).
Explicit formula in the notes' normalisation, for even real h:
   sum_rho h^(gamma) = W0(h) - 2 sum Lambda(n) n^{-1/2} h(log n),
   W0(h) = int h(u) 2 cosh(u/2) du + (1/2pi) int h^(t) (Re psi(1/4 + it/2) - log pi) dt.
For h = Phi the transform Xi vanishes at every zero, so W0(Phi) must equal 2 sum Lambda(n) n^{-1/2} Phi(log n).

Outcome, 10 November 2026 (30 digits, ordinary quadrature): int Phi = xi(1/2) = 0.497120778188314; the transform of Phi
agrees with xi(1/2 + it) at t = 3 and t = 10 to 12 digits; pole term 1.0, archimedean term -0.997310784089, so
W0(Phi) = 0.00268921591077, and 2 sum Lambda(n) n^-1/2 Phi(log n) = 0.00268921591077.
"""
import mpmath as mp
mp.mp.dps = 30
def Phi(u):
    u = abs(mp.mpf(u)); s = mp.mpf(0)
    for n in range(1, 60):
        term = (2 * mp.pi**2 * n**4 * mp.exp(4.5 * u) - 3 * mp.pi * n**2 * mp.exp(2.5 * u)) * mp.exp(-mp.pi * n**2 * mp.exp(2 * u))
        s += term
        if abs(term) < mp.mpf(10) ** -40 and n > 3: break
    return 2 * s
xi = lambda s: mp.mpf(0.5) * s * (s - 1) * mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s)
print("Phi(0) =", mp.nstr(Phi(0), 12), " Phi(-0.3) - Phi(0.3) =", mp.nstr(Phi(-0.3) - Phi(0.3), 5))
print("int Phi =", mp.nstr(2 * mp.quad(Phi, mp.linspace(0, 2, 17)), 15), "  xi(1/2) =", mp.nstr(xi(mp.mpf(0.5)), 15))
Xi = lambda t: mp.re(xi(mp.mpc(0.5, t)))
for t in (3.0, 10.0):
    print(f"Xi({t}) by transform {mp.nstr(2 * mp.quad(lambda u: Phi(u) * mp.cos(t * u), mp.linspace(0, 2, 33)), 12)}  direct {mp.nstr(Xi(t), 12)}")
pole = 2 * mp.quad(lambda u: Phi(u) * 2 * mp.cosh(u / 2), mp.linspace(0, 2, 17))
Om = lambda t: mp.re(mp.digamma(mp.mpc(0.25, t / 2))) - mp.log(mp.pi)
arch = mp.quad(lambda t: Xi(t) * Om(t), mp.linspace(0, 80, 41)) / mp.pi
def vonm(n):
    for p in range(2, n + 1):
        if all(p % d for d in range(2, int(p**0.5) + 1)):
            q = p
            while q < n: q *= p
            if q == n: return mp.log(p)
    return mp.mpf(0)
rhs = 2 * sum(vonm(n) / mp.sqrt(n) * Phi(mp.log(n)) for n in range(2, 12))
print("pole term", mp.nstr(pole, 12), " arch term", mp.nstr(arch, 12), " W0(Phi) =", mp.nstr(pole + arch, 12))
print("2 sum Lambda(n) n^-1/2 Phi(log n) =", mp.nstr(rhs, 12))
