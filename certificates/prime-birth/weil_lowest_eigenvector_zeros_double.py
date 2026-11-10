"""Zeros of the Fourier transform of the lowest eigenvector of Weil's quadratic form, as primes enter. Double precision.
For each L the form on test functions supported in [0, L] uses only the prime powers below e^L. Take its eigenvector
with the smallest eigenvalue, v, and the function F(t) = e^{-itL/2} * sum_k v_k gh_k(t) (Fourier transform of the
centred eigenfunction). Connes and van Suijlekom (arXiv 2511.23257) prove that when the lowest eigenvalue is simple
with an even eigenfunction, all zeros of F are real. Connes, Consani and Moscovici (arXiv 2511.22755) report the
agreement with the zeta zeros and state that a proof of convergence would establish RH. This script reproduces the
phenomenon in a plain Fourier basis; it proves nothing. Trust it only while the gap between the two smallest
eigenvalues is far above 1e-13 (L up to about 1.5); use weil_lowest_eigenvector_zeros.py beyond that.
Usage: python3 weil_lowest_eigenvector_zeros_double.py 0.6:10 1.0:10 1.45:10

Outcome, 10 November 2026, K=10. First zero of F minus the first zeta zero 14.134725:
  L=0.3 (no primes) +11;  L=0.6 (no primes) +0.80;  L=0.7 (prime 2) +0.20;  L=1.0 (prime 2) +7.1e-4;
  L=1.1 (2, 3) +7.3e-5;  L=1.39 (2, 3, and 4) +2.8e-9;  L=1.45 +2.3e-10;  L=1.62 (2, 3, 5) +6e-13 (at the precision limit).
At L=1.45 the first five zeros of F are within 2.3e-10, 7.7e-8, 1.9e-6, 1.9e-4, 1.1e-3 of the zeta zeros."""
import numpy as np, sys, mpmath as mp
from scipy.optimize import brentq
import weil_form as weil
ZZ = [float(mp.im(mp.zetazero(n))) for n in range(1, 16)]
def run(L, K, T=60.0):
    idx, pole, arch, prime = weil.matrices(L, K)
    Q = pole + arch - (sum(prime.values()) if prime else 0); Q = (Q + Q.conj().T) / 2
    ev, V = np.linalg.eigh(Q); v = V[:, 0]
    def F(t): return np.exp(-0.5j * t * L) * sum(v[a] * weil.gh(j, t, L) for a, j in enumerate(idx))
    ph = F(1.0); ph = ph / abs(ph)                      # global phase so that F is real on the real axis
    G = lambda t: (F(t) / ph).real
    ts = np.linspace(0.5, T, 6000); vals = np.array([F(t) / ph for t in ts])
    imag_ratio = np.abs(vals.imag).max() / np.abs(vals.real).max()
    zs = [brentq(G, a, b) for a, b, x, y in zip(ts[:-1], ts[1:], vals.real[:-1], vals.real[1:]) if x * y < 0]
    return ev[:3], imag_ratio, zs, sorted(prime)
print("first zeta zeros:", " ".join(f"{z:9.5f}" for z in ZZ[:8]))
for L, K in [(float(a), int(b)) for a, b in (s.split(":") for s in sys.argv[1:])]:
    ev, ir, zs, ps = run(L, K)
    print(f"L={L:5.3f} K={K:2d} primes {ps}  eigenvalues {ev[0]:.3e} {ev[1]:.3e} {ev[2]:.3e}  |Im F|/|Re F| {ir:.1e}")
    print("   zeros of F:   ", " ".join(f"{z:9.5f}" for z in zs[:8]))
    print("   minus zeta:   ", " ".join(f"{z - g:+9.1e}" for z, g in zip(zs[:8], ZZ)), flush=True)
