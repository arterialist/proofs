"""Zeros of the Fourier transform of the lowest eigenvector of Weil's quadratic form, in multiprecision (60 digits).
For each L the form on test functions supported in [0, L] uses only the prime powers below e^L (basis
e^{2 pi i k u/L}/sqrt(L), |k| <= K). F(t) = e^{-itL/2} sum_k v_k gh_k(t) for the eigenvector v of the smallest eigenvalue.
Connes and van Suijlekom (arXiv 2511.23257) prove that such F has only real zeros when the lowest eigenvalue is simple
and its eigenfunction even; Connes, Consani and Moscovici (arXiv 2511.22755) report the agreement with the zeta zeros.
Whether the zeros of F converge to the zeta zeros as L grows is open, and that convergence would imply RH.
This script reproduces the phenomenon in a plain Fourier basis and proves nothing.
Usage: python3 weil_lowest_eigenvector_zeros.py L:K [L:K ...]      (about 1 minute for K=10, 4 minutes for K=14)

Outcome, 10 November 2026. Distance from the first zeta zeros to the nearest zero of F:
  L=1.0, K=10, prime 2:        7.1e-4, 0.039, 0.21, then no match.   Smallest eigenvalue 1.2e-6.
  L=1.45, K=10, primes 2, 3:   2.3e-10, 7.7e-8, 1.9e-6, 1.9e-4, 1.1e-3, 0.012, 0.13.
  L=2.0, K=10, primes 2..7:    1.0e-17, 3.5e-14, 6.8e-12, 5.1e-8, 1.1e-5, 0.11.   Smallest eigenvalue 1.0e-21.
  L=2.0, K=14, primes 2..7:    2.2e-21, 3.4e-18, 2.9e-16, 2.4e-13, 4.9e-12, 9.8e-10, 1.7e-7, 4.8e-6, 0.055.
                               Three smallest eigenvalues 3.7e-25, 3.3e-22, 1.7e-19.
The values still move with K, so they describe this finite basis and not the limit of all test functions."""
import mpmath as mp, sys, time
mp.mp.dps = 60
def build(L, K):
    L = mp.mpf(L); idx = list(range(-K, K + 1)); n = len(idx)
    w = {k: 2 * mp.pi * k / L for k in idx}
    def A(j, k, u):
        if abs(u) >= L: return mp.mpc(0)
        D = w[j] - w[k]
        if j == k: I = L - abs(u)
        elif u >= 0: I = (1 - mp.exp(1j * D * u)) / (1j * D)
        else: I = (mp.exp(1j * D * u) - 1) / (1j * D)
        return mp.exp(1j * w[k] * u) * I / L
    def gh(j, z): return (mp.exp(1j * (z + w[j]) * L) - 1) / (1j * (z + w[j]) * mp.sqrt(L))
    Q = mp.matrix(n, n); pps = []
    for p in range(2, int(mp.exp(L)) + 1):
        if all(p % r for r in range(2, int(p**0.5) + 1)):
            q = p
            while q <= mp.exp(L): pps.append((p, q)); q *= p
    half = mp.mpc(0, 0.5)
    for a, j in enumerate(idx):
        for b, k in enumerate(idx):
            if b < a: continue
            d = 1 if j == k else 0
            pole = gh(j, half) * mp.conj(gh(k, -half)) + gh(j, -half) * mp.conj(gh(k, half))
            f = lambda u: (mp.exp(-2 * u) * d - mp.exp(-u / 2) * (A(j, k, u) + A(j, k, -u)) / 2) / (1 - mp.exp(-2 * u))
            arch = -(mp.euler + mp.log(mp.pi)) * d + 2 * (mp.quad(f, mp.linspace(0, L, 9)) - mp.log(1 - mp.exp(-2 * L)) * d / 2)
            val = pole + arch - sum(mp.log(p) / mp.sqrt(q) * (A(j, k, mp.log(q)) + A(j, k, -mp.log(q))) for p, q in pps)
            Q[a, b] = val
            if a != b: Q[b, a] = mp.conj(val)
    return idx, Q, gh, sorted({p for p, q in pps})
if __name__ == "__main__":
    NZ = 14; ZZ = [mp.im(mp.zetazero(n)) for n in range(1, NZ + 1)]; t0 = time.time()
    for L, K in [(a, int(b)) for a, b in (s.split(":") for s in sys.argv[1:])]:
        idx, Q, gh, ps = build(L, K); Lm = mp.mpf(L)
        ev, V = mp.eigh(Q); order = sorted(range(len(idx)), key=lambda i: ev[i]); v = [V[a, order[0]] for a in range(len(idx))]
        F = lambda t: mp.exp(-0.5j * t * Lm) * sum(v[a] * gh(j, t) for a, j in enumerate(idx))
        ph = F(mp.mpf(1)); ph = ph / abs(ph); G = lambda t: (F(t) / ph).real
        imr = max(abs((F(mp.mpf(t)) / ph).imag) / abs(F(mp.mpf(t))) for t in (3, 10.5, 17, 33.3))
        print(f"L={L} K={K} primes {ps}  three smallest eigenvalues {mp.nstr(ev[order[0]], 4)}, {mp.nstr(ev[order[1]], 4)}, {mp.nstr(ev[order[2]], 4)}"
              f"  |Im F|/|F| {mp.nstr(imr, 2)}   ({time.time()-t0:.0f}s)")
        out = []
        for g in ZZ:
            try:
                z = mp.findroot(G, g); out.append(mp.nstr(abs(z - g), 2) if abs(z - g) < 0.4 else "none")
            except Exception: out.append("none")
        print("   distance from each of the first zeta zeros to the nearest zero of F:\n   " + "  ".join(out), flush=True)
